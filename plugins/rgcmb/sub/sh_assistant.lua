--[[
 
      _            _     _              _   
     / \   ___ ___(_)___| |_ __ _ _ __ | |_ 
    / _ \ / __/ __| / __| __/ _` | '_ \| __|
   / ___ \\__ \__ \ \__ \ || (_| | | | | |_ 
  /_/   \_\___/___/_|___/\__\__,_|_| |_|\__|
                                            
 
]]

if (SERVER) then
  util.AddNetworkString("RGASay")
  net.Receive("RGASay", function(len, ply) 
    if (!ply:IsCombine()) then return end

    local message = net.ReadString()
    if (message ~= "") then
      hook.Run("PlayerSay", ply, message)
    end

  end)
end

if (CLIENT) then

  local function GetPosGrid(pos)
    local x = math.Round(pos.x/500)
    local y = math.Round(pos.y/500)
    local z = math.Round(pos.z/500)+64
  
    return {x,y,z}
  end

  local function Reduce(num)
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

    if (data["radio"] and data["radio"] == true) then
      local radios = inventory:GetItemsByUniqueID("handheld_radio", true)
      
      if (#radios < 0) then return end
      local hasActiveRadio = false
      for _, radio in ipairs(radios) do
        local enabled = radio:GetData("enabled", false)
        if (enabled) then hasActiveRadio = true end
      end

      if (!hasActiveRadio) then return end

    end

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


    child, parent = menu:AddSubMenu(name)
    parent:SetIcon(data["icon"] or "icon16/transmit_blue.png")

    if (data["options"]) then
      for k,v in pairs(data["options"]) do
        child:AddOption(k, v)
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
    
    local function Radio(msg)
      self:ClientSay(radioPrefix .. msg)
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

    
  
    local name = "UNKNOWN"
    local formattedName = ""
    if (tag and id) then
      name = tag .. "-" .. id
      formattedName = tag .. ";" .. id
    elseif (id) then
      name = id
      formattedName = id
    end


    

    
    ----------- CIVIL PROTECTION
    
    ----------- OVERWATCH 
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
        ["Affirmative"] = function ()
          Radio(Pick({"AFFIRMATIVE2", "AFFIRMATIVE3", "10-4", "Copy", "Copy that"}) .. "#" .. RandPitch())
        end,
        ["Negative"] = function ()
          Radio("10-2#" .. RandPitch())
        end,
        ["Everything clear!"] = function() 
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
        end,
        ["My Position"] = function ()
          Radio(formattedName .. Pick({";GRID;", ";SECTOR;"}) .. formattedPos)
        end,
        ["My Bearing"] = function() 
          Radio("bearing; " .. Reduce(GetBearing()) .. ";degrees")
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
        ["Target's Fucked"] = function ()
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



    menu:Open(ScrW() / 2, ScrH() / 2)
  end)


  concommand.Add("-RGAssistant", function() CloseDermaMenus() end)
end