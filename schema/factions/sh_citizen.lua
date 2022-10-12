
FACTION.name = "Citizen"
FACTION.description = "A regular human citizen enslaved by the Universal Union."
FACTION.color = Color(150, 125, 100, 255)
FACTION.isDefault = true
FACTION.models = {
	"models/fty/citizens/female_01.mdl",
	"models/fty/citizens/female_02.mdl",
	"models/fty/citizens/female_03.mdl",
	"models/fty/citizens/female_04.mdl",
	"models/fty/citizens/female_05.mdl",
	"models/fty/citizens/female_06.mdl",
	"models/fty/citizens/female_07.mdl",
	"models/fty/citizens/female_08.mdl",
	"models/fty/citizens/female_10.mdl",
	"models/fty/citizens/female_11.mdl",
	"models/fty/citizens/female_17.mdl",
	"models/fty/citizens/female_19.mdl",
	"models/fty/citizens/female_21.mdl",
	"models/fty/citizens/female_22.mdl",
	"models/fty/citizens/male_01.mdl",
	"models/fty/citizens/male_02.mdl",
	"models/fty/citizens/male_03.mdl",
	"models/fty/citizens/male_04.mdl",
	"models/fty/citizens/male_05.mdl",
	"models/fty/citizens/male_06.mdl",
	"models/fty/citizens/male_07.mdl",
	"models/fty/citizens/male_08.mdl",
	"models/fty/citizens/male_09.mdl"
}

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("suitcase", 1)
	inventory:Add("jumpsuit", 1)
	inventory:Add("blue_jeans", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

FACTION_CITIZEN = FACTION.index
