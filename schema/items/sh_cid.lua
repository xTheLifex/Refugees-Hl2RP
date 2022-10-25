
ITEM.name = "Citizen ID"
ITEM.model = Model("models/gibs/metal_gib4.mdl")
ITEM.description = "A citizen identification card with ID #%s, assigned to %s."

function ITEM:GetDescription()
	return "A citizen identification card with ID #" .. self:GetData("id", "0000").. ", assigned to " .. self:GetData("name", "nobody").. "."
end

ITEM.functions.AssignApt = {
    name = "Assign Apartment",
    tip = "Assigns this CID to the apartment door you are currently staring at.",
    icon = "icon16/add.png",
    OnRun = function(item)
		if (IsValid(item.entity)) then return false end
		local ply = item.player

		if (!ply) then return false end
		if (!ply:IsCombine()) then return false end
		local ent = ply:GetEyeTrace().Entity
		if (IsValid(ent)) then
			if (ent:IsDoor()) then
				local mapID = ent:MapCreationID()
				if (mapID > -1) then
					item:SetData("doorMapID", mapID)
					ply:Notify("CID assigned to the door.")
				else
					ply:Notify("You cannot assign apartments to custom spawned doors.")
				end
			end
		end
		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		local ply = item.player
		if (!ply) then return end

		if (!ply:IsCombine()) then return false end

		local ent = ply:GetEyeTrace().Entity
		if (IsValid(ent)) then
			if (ent:IsDoor()) then return true end
		end
		return false
	end
}

ITEM.functions.Assign = {
	name = "Assign CID",
	tip = "Assign this CID to someone",
	icon = "icon16/add.png",
	OnRun = function(item)
		if (IsValid(item.entity)) then return false end
		local ply = item.player
		if (!ply) then return false end
		if (!ply:IsCombine()) then return false end


		local ent = ply:GetEyeTrace().Entity
		if (ent:IsPlayer()) then
			local char = ent:GetCharacter()
			if (!char) then return false end
			item:SetData("name", char:GetName())
			item:SetData("id", char:GetData("cid", "0000"))
			ply:Notify("Assigned CID to " .. char:GetName())
		end
		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		local ply = item.player
		if (!ply) then return false end
		if (!ply:IsCombine()) then return false end

		local ent = ply:GetEyeTrace().Entity
		if (ent:IsPlayer()) then
			return true
		end
		return false
	end
}