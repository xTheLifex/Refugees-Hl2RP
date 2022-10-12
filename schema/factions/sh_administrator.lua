
FACTION.name = "Administrator"
FACTION.description = "A human Administrator advised by the Universal Union."
FACTION.color = Color(255, 200, 100, 255)
FACTION.pay = 50
FACTION.models = {
	"models/humans/combine/female_01.mdl",
	"models/humans/combine/female_02.mdl",
	"models/humans/combine/female_03.mdl",
	"models/humans/combine/female_04.mdl",
	"models/humans/combine/female_06.mdl",
	"models/humans/combine/female_07.mdl",
	"models/humans/combine/female_ga.mdl",
	"models/humans/combine/male_01.mdl",
	"models/humans/combine/male_02.mdl",
	"models/humans/combine/male_03.mdl",
	"models/humans/combine/male_04.mdl",
	"models/humans/combine/male_05.mdl",
	"models/humans/combine/male_06.mdl",
	"models/humans/combine/male_07.mdl",
	"models/humans/combine/male_08.mdl",
	"models/humans/combine/male_09.mdl",
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true

FACTION_ADMIN = FACTION.index

function FACTION:OnCharacterCreated(client, character)
  local id = Schema:ZeroNumber(math.random(1, 99999), 5)
  local inventory = character:GetInventory()

  character:SetData("cid", id)

  inventory:Add("suitcase", 1)
  inventory:Add("brown_suit", 1)
  inventory:Add("fancy_brown_pants", 1)
  inventory:Add("cid", 1, {
	  name = character:GetName(),
	  id = id
  })
end