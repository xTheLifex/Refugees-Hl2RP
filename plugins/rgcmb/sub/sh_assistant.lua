--[[
 
      _            _     _              _   
     / \   ___ ___(_)___| |_ __ _ _ __ | |_ 
    / _ \ / __/ __| / __| __/ _` | '_ \| __|
   / ___ \\__ \__ \ \__ \ || (_| | | | | |_ 
  /_/   \_\___/___/_|___/\__\__,_|_| |_|\__|
                                            
 
]]

if (SERVER) then
  util.AddNetworkString("RGASay")
  util.AddNetworkString("RGAPlaySound")

  net.Receive("RGASay", function(len, ply) 
    if (!ply:IsCombine()) then return end

    local message = net.ReadString()
    if (message ~= "") then
      hook.Run("PlayerSay", ply, message)
    end

  end)

  net.Receive("RGAPlaySound", function(len, ply) 
    if (ply:IsCombine()) then return end

    net.Start()
    net.WriteString(net.ReadString())
    net.Broadcast("RGAPlaySound")
  end)
end

if (CLIENT) then

  net.Receive("RGAPlaySound", function() 
    local snd = net.ReadString()
    if (!snd) then return end
    surface.PlaySound(snd)
  end)

  local function Sound(snd)
    net.Start("RGAPlaySound")
    net.WriteString(snd)
    net.SendToServer()
  end

  local function GetPosGrid(pos)
    local x = math.Round(pos.x/500)
    local y = math.Round(pos.y/500)
    local z = math.Round(pos.z/500)+64
  
    return {x,y,z}
  end

  local function Reduce(num)
    if (!isnumber(num)) then
      return num
    end

    if (num<=0) then
      return ""
    end

    if (num < 20) then
      return num
    end

    local data = {
      {300, 400},
      {200, 300},
      {100, 200},
      {90, 100},
      {80, 90},
      {70, 80},
      {60, 70},
      {50, 60},
      {40, 50},
      {30, 40},
      {20, 30}
    }

    for _, v in ipairs(data) do
      local lower = v[1]
      local higher = v[2]

      if (num >= lower and num < higher) then
        return lower .. ";" .. Reduce(num-lower)
      end
    end
  end

  function GetFormattedPosGrid(grid)
    local x = grid[1] -- X
    local z = grid[2] -- Y
    local y = grid[3] -- Z
    -- Using Y as height.
    -- TODO: Optional include height in the answer?

    if (!x or !y or !z) then return end

    local ans = ""
    local function A(msg)
      ans = ans .. msg .. ";"
    end

    if (x == 0) then
      A("0")
    else
      if (x<0) then A("NOMAD") end
      A(Reduce(math.abs(x)))
    end
    
    A("DASH")

    if (z == 0) then
      A("0")
    else
      if (z<0) then A("NOMAD") end
      A(Reduce(math.abs(z)))
    end

    return ans
  end
  
  local function GetBearing()
    local client = LocalPlayer()
    local angle = client:EyeAngles()
    local bearing = math.Round(angle.y)+180
    return bearing
  end
  
  local meter = 0.01905

  local function Pick(t)
    if (istable(t)) then
      return t[math.random(1, #t)]
    else
      return t
    end
  end

  local function RandPitch()
    return 100+math.random(-5,5)
  end

  function PLUGIN:ClientSay(message)
    net.Start("RGASay")
    net.WriteString(message)
    net.SendToServer()
  end



  function PLUGIN:AddAssistantOption(menu, name, icon, data)
    local client = LocalPlayer()
    local char = client:GetCharacter()
    local inventory = char:GetInventory()
    local area = client.ixArea
    local data = data or {}

    -- Do not add the option if it requires a radio and we dont have one.
    if (data["radio"] and data["radio"] == true) then
      local radios = inventory:GetItemsByBase("radios", true)
      
      if (#radios < 0) then return end
      --[[
      local hasActiveRadio = false
      for _, radio in ipairs(radios) do
        local enabled = radio:GetData("enabled", false)
        if (enabled) then hasActiveRadio = true end
      end

      if (!hasActiveRadio) then return end]]

    end

    -- Check for faction restrictions
    if (data["faction"]) then
      local playerFaction = char:GetFaction()
      if (istable(data["faction"])) then
        local factions = data["faction"]
        for _, f in ipairs(factions) do
          if (playerFaction != f) then return end
        end
      else
        if (playerFaction != data["faction"]) then return end
      end
    end

    -- Check for rank restrictions
    if (data["rank"]) then
      local hasRank = Schema:IsCombineRank(client:Name(), data["rank"] or "OWS")
      if (!hasRank) then return end
    end

    -- Check for dispatch restrictions
    local isDisp = Schema:IsCombineRank(client:Name(), "DISP")
    if (data["dispatch"] and data["dispatch"] == true) then
      if (!isDisp) then return end
    else
      if (isDisp) then return end
    end

    -- Check for custom restrictions
    local cond = data["condition"] or data["conditions"]
    if (cond and type(cond) == "function") then
      if (cond(client) == false) then return end
    end 

    child, parent = menu:AddSubMenu(name, data["action"] or nil)
    parent:SetIcon(data["icon"] or "icon16/transmit_blue.png")

    if (data["options"]) then
      for k,v in SortedPairs(data["options"]) do
        local optname = string.gsub(k, "^%d+%.%s*", "") -- Remove the first number and following character along with any subsequent space
        child:AddOption(optname, v)
      end
    end

    return child, parent
  end


  concommand.Add("+RGAssistant", function() 
    local self = ix.plugin.Get("rgcmb")
    local client = LocalPlayer()
    local char = client:GetCharacter()
    local inventory = char:GetInventory()
    local menu = DermaMenu()
    local area = client.ixArea
    local pos = client:GetPos()
    local posGrid = GetPosGrid(pos)
    local formattedPos = GetFormattedPosGrid(posGrid)
    local formattedBearing = Reduce(GetBearing()) .. "; degrees"
    local radioPrefix = "/radio "
    local yellPrefix = "/y "
    local dispatchPrefix = "/dispatch "


    local function Say(msg)
      self:ClientSay(msg)
    end

    local function Radio(msg)
      self:ClientSay(radioPrefix .. msg)
    end

    local function Dispatch(msg)
      self:ClientSay(dispatchPrefix .. msg)
    end

    local function Yell(msg)
      self:ClientSay(yellPrefix .. msg)
    end

    local function Visor(msg, color)
      self:VisorMessage(msg, color)
    end

    local rank = char:CIGetRank() or nil
    local tag = char:CIGetTag() or nil
    local id = char:CIGetID() or nil
    local area = client:GetArea() or "UNKNOWN"

    local colorBad = Color(175,21,21)
    local colorNotice = Color(202, 49, 207)
    local colorWarn = Color(151,132,24)
    local colorBlue = Color(32,143,177)

    
  
    local name = "UNKNOWN"
    local formattedName = ""
    local formattedID = ""
    if (tag and id) then
      name = tag .. "-" .. id
      formattedName = tag .. ";" .. id
    elseif (id) then
      name = id
      formattedName = id
    end
    



    

    
    /* -------------------------------------------------------------------------- */
    /*                              Civil Protection                              */
    /* -------------------------------------------------------------------------- */
    do
      
      local radio = self:AddAssistantOption(menu, "Radio", "icon16/transmit_blue.png", {
        radio = true,
        faction = FACTION_MPF
      })

      local duty = self:AddAssistantOption(radio, "Duty", nil, {
        radio = true,
        faction = FACTION_MPF,
        options = {
          ["On Duty"] = function()
            Visor("Unit " .. name .. " is ON DUTY.", colorBlue)
            Radio(Pick({
              "10-8#" .. math.random(95, 105),
              "IS 10-8#" .. math.random(95, 105),
              formattedName .. "; 10-8 standing by#" .. math.random(95, 105)
            }))
          end,
          ["Off Duty"] = function()
            Visor("Unit " .. name .. " is now OFF DUTY.", colorBlue)
            Radio(Pick({
              formattedName .. " is now 10-7.",
              formattedName .. "; Unit is now 10-7."
            }))
          end
        }
      })
    end

    /* -------------------------------------------------------------------------- */
    /*                                  Dispatch                                  */
    /* -------------------------------------------------------------------------- */

    /* ------------------------------- City Voice ------------------------------ */
    do
      local function Code(msg)
        Visor("Receiving Overwatch Priority Orders. Code:" .. msg, colorBad)
      end

      
      local cityVoice = self:AddAssistantOption(menu, "City Broadcast", "icon16/transmit_blue.png", {
        dispatch = true,
        options = {
          ["Anti-Citizen Reported in this community..."] = function() 
            Visor("Updating socio-stability report...")
            timer.Simple(2, function() Visor("Retrieving updates...") end)
            timer.Simple(5, function() Visor("List Retrieved!") end)
            timer.Simple(8, function() Visor("Standby for Overwatch Priority Announcement...", colorBad) end)

            timer.Simple(10 + math.random(1,2), function() 
              Code("LOCK, CAUTERIZE, STABILIZE")
              timer.Simple(math.random(1,2), function() Dispatch("ANTI-CITIZEN") end)
            end)
            
          end,
          ["You are charged with A-C activity level: ONE..."] = function(arguments)
            Visor("Updating socio-stability report...")
            timer.Simple(2, function() Visor("Retrieving updates...") end)
            timer.Simple(5, function() Visor("List Retrieved!") end)
            timer.Simple(8, function() Visor("Standby for Overwatch Priority Announcement...", colorBad) end)

            timer.Simple(10 + math.random(1,2), function() 
              Code("DUTY, SWORD, OPERATE")
              timer.Simple(math.random(1,2), function() Dispatch("ACTIVITY LEVEL 1") end)
            end)

          end,
          ["Evidence of A-C Activity in this Community..."] = function() 
            Visor("Updating socio-stability report...")
            timer.Simple(2, function() Visor("Retrieving updates...") end)
            timer.Simple(5, function() Visor("List Retrieved!") end)
            timer.Simple(8, function() Visor("Standby for Overwatch Priority Announcement...", colorBad) end)

            timer.Simple(10 + math.random(1,2), function() 
              Code("ASSEMBLE, CLAMP, CONTAIN")
              timer.Simple(math.random(1,2), function() Dispatch("ANTI-CIVIL EVIDENCE") end)
            end)
          end,
          ["You're charged with Capital Malcomp. A-C Status."] = function()
            Visor("Updating socio-stability report...")
            timer.Simple(2, function() Visor("Retrieving updates...") end)
            timer.Simple(5, function() Visor("List Retrieved!") end)
            timer.Simple(8, function() Visor("Standby for Overwatch Priority Announcement...", colorBad) end)

            timer.Simple(10 + math.random(1,2), function() 
              Visor("Available units: ASSEMBLE, INTERCEDE, PROSECUTE.", colorBad)
              timer.Simple(math.random(1,2), function() Dispatch("ARE CHARGED WITH") end)
            end)
          end,
          ["Inspection Procedure"] = function() 
            Visor("All units prepare " .. Pick({"for operation", "for citizen inspection", "for ID check procedures", "to administrate ID check."}))
            timer.Simple(3, function() Visor("Available units move to Residental Areas and prepare for instructions...") end)
            timer.Simple(30, function() Visor("Prepare to administrate citizen identification check...") end)
            timer.Simple(35, function() Visor("Preparing citizen announcement...") end)
            timer.Simple(37, function() Dispatch("ASSUME POSITIONS") end)
            timer.Simple(90, function() Visor("Preparing citizen reminder...") end)
            timer.Simple(94, function() Dispatch("INSPECTION") end)
          end,
          ["AUTONOMOUS JUDGEMENT"] = function()
            timer.Simple(0, function() Visor("ALERT.", colorBad) end)
            timer.Simple(3, function() Visor("ALERT.", colorBad) end)
            timer.Simple(6, function() Visor("ALERT.", colorBad) end)
            timer.Simple(12, function() Visor("PRIORITY ALERT.", colorBad) end)
            timer.Simple(15, function() Visor("SOCIO-STABILITY REPORT: RED...", colorBad) end)
            timer.Simple(24, function() Visor("STANDBY FOR OVERWATCH PRIORITY ANNOUNCEMENT...", colorBad) end)
            timer.Simple(32, function() Dispatch("AUTONOMOUS JUDGMENT") end)
            timer.Simple(34, function() Code("AMPUTATE, ZERO, CONFIRM") end)
          end
        }
      })
    end
    /* ------------------------------- Radio Voice ------------------------------- */






    
    /* -------------------------------------------------------------------------- */
    /*                                  Overwatch                                 */
    /* -------------------------------------------------------------------------- */
    do
      local radio = self:AddAssistantOption(menu, "Radio", "icon16/transmit_blue.png", {
        radio = true,
        faction = FACTION_OTA
      })

      local duty = self:AddAssistantOption(radio, "Duty", nil, {
        radio = true,
        faction = FACTION_OTA,
        options = {
          ["On Duty"] = function()
            Visor("Attention: Unit " .. name .. " is ACTIVE.", colorWarn)
            Radio(Pick({
              "OVERWATCH;" .. formattedName .. ";FULL ACTIVE",
              formattedName .. ";FULL ACTIVE",
              "OVERWATCH;" .. formattedName .. ";STANDING BY",
              formattedName .. ";STANDING BY",
              formattedName .. ";IS AT CODE;0;STANDING BY",
            }))
          end,
          ["Off Duty"] = function()
            Visor("Unit " .. name .. " is now INACTIVE.", colorWarn)
          end
        }
      })

      local response = self:AddAssistantOption(radio, "Reply", nil, {
        radio = true,
        faction = FACTION_OTA,
        options = {
          ["1. Affirmative"] = function ()
            Radio(Pick({"AFFIRMATIVE2", "AFFIRMATIVE3", "10-4", "Copy", "Copy that"}) .. "#" .. RandPitch())
          end,
          ["2. Negative"] = function ()
            Radio("10-2#" .. RandPitch())
          end,
          ["3. My Position"] = function ()
            Radio(formattedName .. Pick({";GRID;", ";SECTOR;"}) .. formattedPos)
          end,
          ["4. My Bearing"] = function() 
            Radio("bearing; " .. Reduce(GetBearing()) .. ";degrees")
          end,
          ["5. Everything clear!"] = function() 
            Radio(Pick({
              "OVERWATCH; TEAM HAS SECTOR",
              "TEAM HOLDING",
              formattedName .. ";IS HOLDING AT CODE;0",
              formattedName .. ";IS AT CODE;0",
              formattedName .. ";NO CONTACT;CODE;0",
              "OVERWATCH;" .. formattedName .. ";NO CONTACT; STANDING BY",
              "OVERWATCH;TEAM HAS SECTOR",
              "OVERWATCH;NO CONTACT; SIGHTLINE CLEAR",
              "NO CONTACT; SIGHTLINE CLEAR",
              formattedName .. ";NO CONTACT",
              formattedName .. ";SIGHTLINE CLEAR",
              "OVERWATCH;IS AT CODE;0",
              "OVERWATCH;SECURE NO VISCON",
              formattedName .. ";NO VISCON",
              formattedName .. ";NEGATIVE MOVEMENT; GRID; " .. formattedPos,
              formattedName .. ";NEGATIVE MOVEMENT; SECTOR; " .. formattedPos
            }))
          end
        }
      })

      local reports = self:AddAssistantOption(radio, "Reports", nil, {
        radio = true,
        faction = FACTION_OTA,
        options = {
          ["Advancing"] = function ()
            Radio(Pick({
              formattedName .. ";UNIT IS CLOSING",
              formattedName .. ";UNIT IS INBOUND",
              formattedName .. ";UNIT IS MOVING",
              formattedName .. ";CLOSING",
              formattedName .. ";CLOSING2",
              formattedName .. ";CLOSING2; COVER ME",
              formattedName .. ";CLOSING; COVER ME",
              "OVERWATCH;" .. tag .. "; UNIT IS CLOSING",
              "OVERWATCH;" .. tag .. "; UNIT IS INBOUND",
              "OVERWATCH;" .. tag .. "; UNIT IS MOVING"
            }))
          end,
          ["I'm hit. I'm fine."] = function()
            Radio(Pick({
              "TARGET NO EFFECT",
              "BODYPACK HOLDING",
              "TARGET NO EFFECT; BODYPACK HOLDING",
              "BODYPACK HOLDING; TARGET NO EFFECT",
              formattedName .. ";FULL ACTIVE; BODYPACK HOLDING",
              formattedName .. ";FULL ACTIVE; TARGET NO EFFECT"
            }))
          end,
          ["I'm hit. I'm bad."] = function()
            Radio(Pick({
              "REQUEST MEDICAL",
              "REQUEST STIMDOSE",
              formattedName .. "; REQUEST MEDICAL",
              formattedName .. "; REQUEST STIMDOSE",
              "DISPLACE; DISPLACE2",
              "COVER!#98; COVER!#105"
            }))
          end,
          ["Engaging"] = function()
            Radio(Pick({
              formattedName .. ";ENGAGING",
              formattedName .. ";FULL RESPONSE",
              formattedName .. ";SUPPRESSING",
              formattedName .. ";PROSECUTING"
            }))
          end,
          ["Target's Compromised"] = function ()
            Radio(Pick({
              "TARGET COMPROMISED",
              "WRAP IT UP"
            }))
          end,
          ["I'm last man standing"] = function()
            Visor(name .. " reports OVERWATCH team deserviced. " .. Pick({"All units Code 3", "All units SACRIFICE CODE.", "All units converge and respond.", "", "", ""}), colorBad)
            Radio(Pick({
              "TEAM IS DOWN",
              "SECTOR OVERRUN",
              "REQUEST SKYSHIELD",
              "REQUEST WINDER",
              "SECTOR;" .. formattedPos .. ";OUTBREAK; OUTBREAK#105; OUTBREAK#110",
              "REQUEST RESERVE",
              formattedName .. "; IS FINAL TEAM UNIT",
              formattedName .. ";IS HOLDING AT CODE;3;SECTOR IS NOT SECURE"
            }))
          end
        }
      })


      local contactCommon = "OVERWATCH; SECTOR NOT STERILE"
      local contacts = self:AddAssistantOption(reports, "Contact", nil, {
        radio = true,
        faction = FACTION_OTA,
        options = {
          ["Headcrab"] = function ()
            Radio(Pick({
              contactCommon,
              "OVERWATCH; INFESTATION ZONE; GRID;" .. formattedPos,
              "OVERWATCH; INFESTATION ZONE; SECTOR;" .. formattedPos,
              "CONTACT PARASITE; GRID;" .. formattedPos,
              "FREE PARASITE; GRID;" .. formattedPos,
              "CONTACT PARASITE; SECTOR;" .. formattedPos,
              "FREE PARASITE; SECTOR;" .. formattedPos
            }))
          end,
          ["Zombies"] = function()
            Radio(Pick({
              contactCommon,
              "OVERWATCH; INFESTATION ZONE; GRID;" .. formattedPos,
              "OVERWATCH; INFESTATION ZONE; SECTOR;" .. formattedPos,
              "CONTACT; NECROTICS;" .. formattedPos,
              "CONTACT; NECROTICS;" .. formattedPos,
              "CONTACT; NECROTICS;" .. formattedPos
            }))
          end,
          ["Antlions"] = function()
            Radio(Pick({
              contactCommon,
              "SWARM OUTBREAK IN SECTOR;" .. formattedPos,
              "OVERWATCH; VIROMES; GRID;" .. formattedPos,
              "OVERWATCH; INFESTATION ZONE; SECTOR;" .. formattedPos
            }))
          end,
          ["Lost Contact"] = function ()
            Radio(Pick({
              formattedName .. "; LOST CONTACT",
              formattedName .. "; LOST CONTACT",
              formattedName .. "; LOST CONTACT",
              formattedName .. "; LOST CONTACT; MOTION CHECK ALL RADIALS",
              formattedName .. "; LOST CONTACT; REPORT SIGHTLINES",
              formattedName .. "; IN CLEANUP",
              "TARGET BLACKOUT",
              "TARGET BLACKOUT",
            }))
          end
        }
      })

      local ask = self:AddAssistantOption(radio, "Ask", nil, {
        radio = true,
        faction = FACTION_OTA,
        options = {
          ["Is everything clear?"] = function ()
            Radio(Pick({
              "REPORT ALL RADIALS FREE",
              "REPORT ALL CLEAR",
              "OVERWATCH; REPORT ALL CLEAR",
              "OVERWATCH; REPORT ALL CLEAR",
              "OVERWATCH; REPORT ALL RADIALS FREE",
              "OVERWATCH; REPORT ALL RADIALS FREE"
            }))
          end
        }
      })


      local speak = self:AddAssistantOption(menu, "Speak", nil, {
        faction = FACTION_OTA
      })

      local orders = self:AddAssistantOption(speak, "Squad Orders", nil, {
        faction = FACTION_OTA,
        options = {}
      })

      self:AddAssistantOption(orders, "Breach", nil, {
        faction = FACTION_OTA,
        condition = function(client) 
          return true -- TODO: Door check
        end,
        action = function() 
          -- TODO: Finish
        end
      })
    end


    menu:Open(ScrW() / 2, ScrH() / 2)
  end)


  concommand.Add("-RGAssistant", function() CloseDermaMenus() end)
end