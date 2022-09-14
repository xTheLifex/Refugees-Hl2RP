--[[
 
    _____                                          _     
   / ____|                                        | |    
  | |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
  | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
  | |___| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
   \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
                                                         
                                                         
 
]]

-- Draw Pistol
do
	local COMMAND = {}
	function COMMAND:OnRun(client, arguments)
		if (!(client:Team() == FACTION_MPF)) then
			return "You must be a Metropolice Unit to do this!"
		end

		local character = client:GetCharacter()
		local inventory = character:GetInventory()
		
		local pistol = client:HasWeapon("weapon_pistol")
		local ixpistol = client:HasWeapon("ix_pistol")
		local usp = client:HasWeapon("arccw_uspmatch2")

		if !(pistol or ixpistol or usp) then
			return "You need a equipped pistol to do this!"
		end

		if (client:IsWepRaised()) then
			return "You already have a weapon drawn"
		end

		client:EmitSound("weapons/357/357_reload3.wav")
		if (pistol) then
			client:SelectWeapon("weapon_pistol")
		elseif (ixpistol) then
			client:SelectWeapon("ix_pistol")
		elseif (usp) then
			client:SelectWeapon("arccw_uspmatch2")
		end



		client:ForceSequence("drawpistol", function()
			client:SetWepRaised(true)
		end)
			
		
	end
	
	ix.command.Add("DrawPistol", COMMAND)
end

-- Door kick --
do
	local sounds = {
		"physics/wood/wood_crate_break1.wav",
		"physics/wood/wood_crate_break4.wav",
		"physics/wood/wood_crate_break5.wav"
	}
	ix.command.Add("DoorKick", {
		description = "Kick a door down as a Civil Protection unit",
		arguments = {},
		OnRun = function(self, client)
			-- Check if the player is MPF before doing this.
			local char = client:GetCharacter()	
			if (char:GetFaction() ~= FACTION_MPF) then
				return "You must be a Civil Protection unit to do this!"
			end
		
			-- Check their model and animation class.
			local animclass = ix.anim.GetModelClass(char:GetModel())
			if (animclass ~= "metrocop") then
				return "Your model doesn't support this command!"
			end
			
			local eyePos = client:EyePos()
			local eyeAngles = client:EyeAngles()
			local aimVector = client:GetAimVector()

			-- Find a door infront of the player. Cancel if no door.
			local tr = util.TraceLine({
				start = eyePos,
				endpos = eyePos + eyeAngles:Forward() * 64,
				filter = function(ent) return (ent:GetClass() == "prop_door_rotating") end
			})

			-- Know for sure if it's a door.
			if (tr.HitWorld or !IsValid(tr.Entity) or tr.Entity == nil) then
				return "You must look at a door to do this!"
			end

			-- Save some variables for later use.
			local hit = {pos = tr.HitPos, normal = tr.HitNormal}

			local door = tr.Entity

			-- Fail if door has combine lock
			if (IsValid(door.ixLock) and door.ixLock ~= nil) then
				return "This door cannot be kicked!"
			end

			local physdoor, newdoor

			-- Door removal
			timer.Simple(1.25, function() 
				door:BlastDoor(aimVector * 550)
				client:EmitSound(sounds[math.random(#sounds)])
			end)

			client:ForceSequence("kickdoorbaton")
			
		end
	})
end
