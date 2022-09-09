local PLUGIN = PLUGIN

PLUGIN.SocioStatus = PLUGIN.SocioStatus or "GREEN"
PLUGIN.BOL = PLUGIN.BOL or { }
PLUGIN.FactionCalls = PLUGIN.FactionCalls or { }

surface.CreateFont(
  "CHudLabel",
  {
    font = "BudgetLabel",
    extended = true,
    size = ScreenScale( 7.5 ),
    weight = 200,
    antialias = true,
    shadow = true,
    outline = true,
    scanlines = 2
  }
)

-- Clientside network receives
local function nUpdateSociostatus()
  local newStatus = net.ReadString()

  if ( !PLUGIN.SocioColors[ newStatus ] ) then
    return
  end

  PLUGIN.SocioStatus = newStatus
end
net.Receive( "nUpdateSociostatus", nUpdateSociostatus )

local function nUpdateBOL()
  local bolTable = net.ReadTable()

  PLUGIN.BOL = bolTable

  local oldTab = PLUGIN.BOLPos

  PLUGIN.BOLPos = { }

  -- Small loop so we can remove old positions
  for i, v in ipairs( PLUGIN.BOL ) do
    if ( oldTab[ v ] ) then
      PLUGIN.BOLPos[ v ] = oldTab[ v ]
    end
  end
end
net.Receive( "nUpdateBOL", nUpdateBOL )

local function nMPFTerminal()
  vgui.Create( "ixMPFTerminal" )
end
net.Receive( "nMPFTerminal", nMPFTerminal )

local function nCommandTerminal()
  vgui.Create( "ixHighCommand" )
end
net.Receive( "nCommandTerminal", nCommandTerminal )

-- Clientside hooks
local client = LocalPlayer()

function PLUGIN:ShouldDrawLocalPlayer()
  return client.bShouldDraw
end

local col_white = Color( 255, 255, 255 )
local col_green = Color( 0, 255, 0 )
local col_yellow = Color( 255, 255, 0 )
local col_red = Color( 255, 0, 0 )

local function GetPosGrid(pos)
  local x = math.Round(pos.x/500)
  local y = math.Round(pos.y/500)
  local z = math.Round(pos.z/500)+64

  return "[" .. x .. " " .. z .. " " .. y .. "]"
end

local function GetBearing()
  local angle = client:EyeAngles()
  local bearing = math.Round(angle.y)+180
  return bearing
end

local meter = 0.01905

local function GetRange()
  local tr = util.TraceLine( {
    start = client:EyePos(),
    endpos = client:EyePos() + client:EyeAngles():Forward() * 10000,
    filter = function( ent ) return (ent != client) end
  } )

  local distance = math.Round(tr.HitPos:Distance(client:GetPos()))
  local meters = math.Round(distance*meter)
  local text = meters .. "m"

  local hit = tr.HitPos

  if (meters > 500) then
    return "ERR", col_red, false, hit
  end

  if (meters > 100) then
    return text, col_red, true, hit
  end

  if (meters > 50) then
    return text, col_yellow, true, hit
  end

  if (meters < 5) then
    return text, col_red, true, hit
  end

  if (meters < 20) then
    return text, col_yellow, true, hit
  end



  return text, col_white, true, hit
end

function PLUGIN:HUDPaint()
  if ( !IsValid( client ) ) then
    client = LocalPlayer()
  end

  if ( !client:IsCombine() ) then
    return
  end

  local socioColor = self.SocioColors[ self.SocioStatus ]

  local blackTSin = TimedSin( 0.5, 120, 200, 0 )

  if ( self.SocioStatus == "BLACK" ) then
    socioColor = Color( blackTSin, blackTSin, blackTSin )
  end

  local projectedThreat = 0
  local area = LocalPlayer():GetArea() or "NULL"
  
  local basepos = 5
  local spacing = 25
  local range, range_color, validrange, hit = GetRange()
  local rangepos = "[ ERROR ]"
  if (validrange) then rangepos = GetPosGrid(hit) end
  draw.SimpleText( "Sociostatus: " .. self.SocioStatus, "CHudLabel", ScrW() - 10, basepos, socioColor, TEXT_ALIGN_RIGHT )
  draw.SimpleText( "Current Location: " .. area, "CHudLabel", ScrW() - 10, basepos+spacing*2, col_white, TEXT_ALIGN_RIGHT )
  draw.SimpleText( "Position Grid: " .. GetPosGrid(client:GetPos()), "CHudLabel", ScrW() - 10, basepos+spacing*3, col_white, TEXT_ALIGN_RIGHT )
  draw.SimpleText( "Bearing: " .. GetBearing(), "CHudLabel", ScrW() - 10, basepos+spacing*4, col_white, TEXT_ALIGN_RIGHT )
  draw.SimpleText( "Rangefinder: " .. range, "CHudLabel", ScrW() - 10, basepos+spacing*5, range_color, TEXT_ALIGN_RIGHT )
  draw.SimpleText( "Rangefinder: " .. rangepos, "CHudLabel", ScrW() - 10, basepos+spacing*6, range_color, TEXT_ALIGN_RIGHT )
  draw.DrawText( "BOL:", "CHudLabel", ScrW() - 10, basepos+spacing*7, col_white, TEXT_ALIGN_RIGHT )

  self.BOLPos = self.BOLPos or { }

  local y = 165

  for i, v in ipairs( self.BOL ) do
    if ( !IsValid( v ) ) then
      table.remove( self.BOL, i )
      continue
    end

    self.BOLPos[ v ] = Lerp( 0.02, self.BOLPos[v] or 140, y )
    draw.SimpleText( v:GetName(), "CHudLabel", ScrW() - 10, self.BOLPos[ v ], col_white, TEXT_ALIGN_RIGHT )

    y = y + 40
  end

  for i, v in ipairs( player.GetAll() ) do
    if ( v == client ) then
      continue
    end

    if ( !v:Alive() ) then
      continue
    end

    local character = v:GetCharacter()

    if ( !character ) then
      continue
    end

    local faction = character:GetFaction()

    if ( !faction ) then
      continue
    end

    if ( !self.FactionCalls[ faction ] ) then
      continue
    end

    local suc, res, mult = pcall( self.FactionCalls[ faction ], v )

    if ( suc and res ) then
      projectedThreat = projectedThreat + mult
    end


    if ( !suc ) then
      ErrorNoHalt( "Warning callback has failed for " .. v:GetName() .. "'s faction!\n" .. res .. "\n" )
    end
  end
  self.threat = self.threat or projectedThreat
  self.nextTick = self.nextTick or 0

  if ( self.nextTick < CurTime() ) then
    self.threat = math.Approach( self.threat, projectedThreat, math.random( 1, 8 ) )
    self.nextTick = CurTime() + 0.25
  end

  local color = col_green

  local tsin = TimedSin( 1.25, 120, 200, 0 )

  if ( self.threat >= 40 and self.threat < 75 ) then
    color = col_yellow
  elseif ( self.threat >= 75 and self.threat <= 100 ) then
    color = col_red
  elseif ( self.threat > 100 ) then
    color = Color(tsin, tsin, tsin)
  end
  draw.DrawText( "Threat Assessment: " .. self.threat .. "%", "CHudLabel", ScrW() - 10, basepos+spacing*1, color, TEXT_ALIGN_RIGHT )
end
