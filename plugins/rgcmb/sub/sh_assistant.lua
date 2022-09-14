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

  function PLUGIN:ClientSay(message)
    net.Start("RGASay")
    net.WriteString(message)
    net.SendToServer()
  end

  concommand.Add("+RGAssistant", function() 
    local self = ix.plugin.Get("rgcmb")
    local client = LocalPlayer()
    local char = client:GetCharacter()
    local menu = DermaMenu()
    local area = client.ixArea

    local chud = ix.plugin.Get("rgcmb")
    
    local rank = char:CIGetRank() or nil
    local tag = char:CIGetTag() or nil
    local id = char:CIGetID() or nil
    local area = client:GetArea() or "UNKNOWN"

    -- TODO: FINISH
    local cp = false 
    local ota = false 
    local admin = false
    local elite = false
    local shotgunner = false 
    local scanner = false

    local colorBad = Color(175,21,21)
    local colorNotice = Color(202, 49, 207)
  
    local name = "UNKNOWN"
    if (tag and id) then
      name = tag .. "-" .. id
    elseif (id) then
      name = id
    end
    
    if (char:GetFaction() == FACTION_MPF) then cp = true end
    if (char:GetFaction() == FACTION_OTA) then ota = true end
    if (char:GetFaction() == FACTION_ADMIN) then admin = true end

    local radioChild, radioParent = menu:AddSubMenu("Radio")
    radioParent:SetIcon("icon16/transmit_blue.png")

    
    radioChild:AddOption("On Duty", function() 
      -- ON DUTY
      local a = {"10-8 standing by", "10-8", "is 10-8"}
      self:ClientSay(a[math.random(#a)])
      self:VisorMessage("Unit " .. name .. " is ON DUTY. 10-20: " .. area, colorNotice)
    end):SetIcon("icon16/user_gray.png")

    radioChild:AddOption("Off Duty", function() 
      -- OFF DUTY

    end):SetIcon("icon16/user.png")

    menu:Open(ScrW() / 2, ScrH() / 2)
  end)


  concommand.Add("-RGAssistant", function() CloseDermaMenus() end)
end