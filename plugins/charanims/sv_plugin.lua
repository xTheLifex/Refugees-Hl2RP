
util.AddNetworkString("ixPlayGesture")

-- Override the schema faction to add an animation.
function Schema:SearchPlayer(client, target)
	if (!target:GetCharacter() or !target:GetCharacter():GetInventory()) then
		return false
	end

	local name = hook.Run("GetDisplayedName", target) or target:Name()
	local inventory = target:GetCharacter():GetInventory()

	ix.storage.Open(client, inventory, {
		entity = target,
		name = name
	})

	client:ForceSequence("spreadwall")

	return true
end
