FACTION.name = "Civil Workers Union"
FACTION.description = "Universal Union approved working shit."
FACTION.color = Color(3, 152, 252)
FACTION.models = {
	{"models/fty/citizens/female_01.mdl", 0, "031"},
	{"models/fty/citizens/female_02.mdl", 0, "031"},
	{"models/fty/citizens/female_03.mdl", 0, "031"},
	{"models/fty/citizens/female_04.mdl", 0, "031"},
	{"models/fty/citizens/female_05.mdl", 0, "031"},
	{"models/fty/citizens/female_06.mdl", 0, "031"},
	{"models/fty/citizens/female_07.mdl", 0, "031"},
	{"models/fty/citizens/female_08.mdl", 0, "031"},
	{"models/fty/citizens/female_10.mdl", 0, "031"},
	{"models/fty/citizens/female_11.mdl", 0, "031"},
	{"models/fty/citizens/female_17.mdl", 0, "031"},
	{"models/fty/citizens/female_19.mdl", 0, "031"},
	{"models/fty/citizens/female_21.mdl", 0, "031"},
	{"models/fty/citizens/female_22.mdl", 0, "031"},
	{"models/fty/citizens/male_01.mdl", 0, "031"},
	{"models/fty/citizens/male_02.mdl", 0, "031"},
	{"models/fty/citizens/male_03.mdl", 0, "031"},
	{"models/fty/citizens/male_04.mdl", 0, "031"},
	{"models/fty/citizens/male_05.mdl", 0, "031"},
	{"models/fty/citizens/male_06.mdl", 0, "031"},
	{"models/fty/citizens/male_07.mdl", 0, "031"},
	{"models/fty/citizens/male_08.mdl", 0, "031"},
	{"models/fty/citizens/male_09.mdl", 0, "031"}
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION_CWU = FACTION.index

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("suitcase", 1)
	inventory:Add("cwu_jumpsuit", 1)
	inventory:Add("jeans", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

