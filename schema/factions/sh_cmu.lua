FACTION.name = "Civil Medical Union"
FACTION.description = "Universal Union doctors."
FACTION.color = Color(255, 77, 41)
FACTION.pay = 1
FACTION.models = {
	{ "models/fty/citizens/female_01.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_02.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_03.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_04.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_05.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_06.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_07.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_08.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_10.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_11.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_17.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_19.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_21.mdl", 0, "0h9" },
	{ "models/fty/citizens/female_22.mdl", 0, "0h9" },
	{ "models/fty/citizens/male_01.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_02.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_03.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_04.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_05.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_06.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_07.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_08.mdl",   0, "0h9" },
	{ "models/fty/citizens/male_09.mdl",   0, "0h9" }
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION_CMU = FACTION.index

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("suitcase", 1)
	inventory:Add("jumpsuit_cmu_d", 1)
	inventory:Add("jeans_blue", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end
