
PLUGIN.name = "Refugees - Civil Protection Module"
PLUGIN.description = "The Refugees Hl2RP Civil Protection module, containing all new features to the Civil Protection."
PLUGIN.author = "TheLife"
PLUGIN.maxLength = 512


-- Commands 
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

			-- Launch the door forwards.
			physdoor:SetVelocity(pos + eyeAngles:Forward() * 2000)
		end)
		
		-- Respawn the door after a while.
		timer.Simple(30, function()
			if (IsValid(physdoor) and physdoor ~= nil) then
				SafeRemoveEntity(physdoor)
			end

			newdoor = ents.Create("prop_door_rotating")
			newdoor:SetModel(model)
			newdoor:SetSkin(skin)
			newdoor:SetBodygroup(1, body)
			newdoor:SetPos(pos)
			newdoor:SetAngles(angles)
			newdoor:Spawn()
		end)

		client:ForceSequence("kickdoorbaton", nil, 3)
		
	end
})
