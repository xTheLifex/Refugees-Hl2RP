--[[
 
    _____                                          _     
   / ____|                                        | |    
  | |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
  | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
  | |___| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
   \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
                                                         
                                                         
 
]]

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
			local model = door:GetModel()
			local skin = door:GetSkin()
			local body = door:GetBodygroup(1)
			local pos = door:GetPos()
			local angles = door:GetAngles()


			-- Fail if door has combine lock
			if (IsValid(door.ixLock) and door.ixLock ~= nil) then
				return "This door cannot be kicked!"
			end

			local physdoor, newdoor

			-- Door removal
			timer.Simple(1.25, function() 
				
				-- Remove the original door.
				SafeRemoveEntity(door)

				-- Spawn a physics prop with the door model
				physdoor = ents.Create("prop_physics")
				physdoor:SetModel(model)
				physdoor:SetSkin(skin)
				physdoor:SetBodygroup(1, body)
				physdoor:SetPos(pos)
				physdoor:SetAngles(angles)
				physdoor:Spawn()

				-- Get physics object and remove if invalid
				local phys = physdoor:GetPhysicsObject()
				if (not phys:IsValid() ) then
					physdoor:Remove()
					return
				end
				
				-- Launch door forwards.
				phys:ApplyForceCenter(aimVector * 20000)

				client:EmitSound(sounds[math.random(#sounds)])

			end)
			
			-- Respawn the door after a while.
			timer.Simple(30, function()
				if (physdoor and IsValid(physdoor)) then
					physdoor:Remove()
				end

				newdoor = ents.Create("prop_door_rotating")
				newdoor:SetModel(model)
				newdoor:Spawn()
				newdoor:SetSkin(skin)
				newdoor:SetBodygroup(1, body)
				newdoor:SetPos(pos)
				newdoor:SetAngles(angles)
			end)

			client:ForceSequence("kickdoorbaton")
			
		end
	})
end
