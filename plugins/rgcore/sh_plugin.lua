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

-- Submodules
ix.util.Include("sub/sh_footsteps.lua")
ix.util.Include("sub/sh_gestures.lua")
ix.util.Include("sub/sh_damage.lua")
ix.util.Include("sub/sh_commands.lua")
ix.util.Include("sub/sh_voicecommands.lua")
ix.util.Include("sub/sh_skins.lua")
ix.util.Include("sub/sh_relationships.lua")
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
   end
end

if (CLIENT) then
   function PLUGIN:ShouldDrawCrosshair(client, weapon)
      local shouldDraw = ix.option.Get("drawCrosshair", true)
      if (!shouldDraw) then return false end
   end
end