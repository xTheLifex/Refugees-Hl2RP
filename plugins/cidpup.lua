
local PLUGIN = PLUGIN

PLUGIN.name = "CIDPUP"
PLUGIN.author = "Nforce"
PLUGIN.description = "Disallows pickup of extra CID's."

function PLUGIN:CanPlayerTakeItem(client, item)

	local char = client:GetCharacter()
	local inv = char:GetInventory()
	local ciditem = inv:HasItem("cid")
    if client:Team() != 2 then return end -- only civs are disallowed. change the number if needed

	if ciditem then
		hasID = true
	else
		hasID = false
	end

	if hasID then
		if item:GetModel() == "models/gibs/metal_gib4.mdl" then
			return false
		end
	end
end
