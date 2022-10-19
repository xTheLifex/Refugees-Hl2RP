--[[
 
   ____       __                             _   _ _     ____  ____  ____  
  |  _ \ ___ / _|_   _  __ _  ___  ___ ___  | | | | |   |___ \|  _ \|  _ \ 
  | |_) / _ \ |_| | | |/ _` |/ _ \/ __/ __| | |_| | |     __) | |_) | |_) |
  |  _ <  __/  _| |_| | (_| |  __/\__ \__ \ |  _  | |___ / __/|  _ <|  __/ 
  |_| \_\___|_|  \__,_|\__, |\___||___/___/ |_| |_|_____|_____|_| \_\_|    
                       |___/                                               
 
    ____                 __  __           _       _      
   / ___|___  _ __ ___  |  \/  | ___   __| |_   _| | ___ 
  | |   / _ \| '__/ _ \ | |\/| |/ _ \ / _` | | | | |/ _ \
  | |__| (_) | | |  __/ | |  | | (_) | (_| | |_| | |  __/
   \____\___/|_|  \___| |_|  |_|\___/ \__,_|\__,_|_|\___|
                                                         
 
]]

PLUGIN.name = "Refugees - Core Module"
PLUGIN.description = "The Refugees Core module, contains features shared with all modules and utility code."
PLUGIN.author = "TheLife"
PLUGIN.maxLength = 512

function PLUGIN:Log(text)
   print("[RG-CORE] " .. tostring(text))
end

function PLUGIN:CanPlayerUseBusiness(ply, uid)
   return false
end


-- Submodules
ix.util.Include("sub/sh_footsteps.lua")
ix.util.Include("sub/sh_gestures.lua")
ix.util.Include("sub/sh_damage.lua")
ix.util.Include("sub/sh_commands.lua")
ix.util.Include("sub/sh_voicecommands.lua")
ix.util.Include("sub/sh_skins.lua")
ix.util.Include("sub/sh_relationships.lua")
ix.util.Include("sub/sh_voices.lua")
ix.util.Include("sub/clothing/sh_clothing.lua")

ix.option.Add("drawCrosshair", ix.type.bool, true, {
   category = "appearance"
})

ix.lang.AddTable("english", {
   optDrawCrosshair = "Draw crosshair"
})


do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, path)
		if (client:IsAdmin() or client:IsSuperAdmin()) then
         net.Start("ulib_sound")
         net.WriteString(Sound(path) or "")
         net.Broadcast()
      else
         client:Notify("You must be an admin to do this!")
      end
	end

	ix.command.Add("PlaySound", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, path)
		if (client:IsAdmin() or client:IsSuperAdmin()) then
         client:EmitSound(path)
      else
         client:Notify("You must be an admin to do this!")
      end
	end

	ix.command.Add("PlayLocalSound", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, message)
		ix.command.Run(client, "Radio", {message})
	end

	ix.command.Add("R", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, message)
		client:ForceSequence(message)
	end

	ix.command.Add("Act", COMMAND)
end

if (SERVER) then
   function PLUGIN:ScalePlayerDamage(ply, hitgroup, dmginfo)
      self:DoDamageScaling(ply, hitgroup, dmginfo)
      self:DoDamageFlinch(ply, hitgroup, dmginfo)
   end

   function PLUGIN:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
      --self:DoSpeakingGestures(speaker, chatType, text, anonymous, receivers, rawText)
      if (chatType == "ic") then
         ix.log.Add(speaker, "chat", "RG-Core", text)
      end
   end
end

if (CLIENT) then
   function PLUGIN:ShouldDrawCrosshair(client, weapon)
      local shouldDraw = ix.option.Get("drawCrosshair", true)
      if (!shouldDraw) then return false end
   end

   local red = {
      ["pistol"] = true,
      ["smg1"] = true,
      ["ar2"] = true,
      ["rpg"] = true
   }
   local yellow = {

   }
   local green = {

   }

   local c_red = Color(255, 0, 0)
   local c_yellow = Color(185,150,54)
   local c_green = Color(26,126,26)



   function PLUGIN:PopulateItemTooltip(tooltip, item)
      if (LocalPlayer():IsCombine()) then
         if (red[item.id] or yellow[item.id] or green[item.id]) then
            local row = tooltip:AddRow("ContrabandAlert")
            local color = c_green

            if (red[item.id]) then color = c_red end
            if (yellow[item.id]) then color = c_yellow end
            if (green[item.id]) then color = c_green end

            row:SetBackgroundColor(color)
            row:SetText("This item is considered contraband by the Universal Union")
            row:SetFont("BudgetLabel")
            row:SetExpensiveShadow(0.5)
            row:SizeToContents()
         end
      end
   end
end