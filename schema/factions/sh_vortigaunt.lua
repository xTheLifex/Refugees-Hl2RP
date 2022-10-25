FACTION.name = "Vortigaunt"
FACTION.description = "The Vortigaunts are a sapient alien species found throughout the Half-Life series."
FACTION.color = Color(61, 155, 61)
FACTION.isDefault = true
FACTION.models = {
	"models/vortigaunt_slave.mdl"
}

function FACTION:GetDefaultName(client)
	return "UU-BIOTIC:" .. Schema:ZeroNumber(math.random(1, 99999), 5), true
end

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

FACTION_VORT = FACTION.index
