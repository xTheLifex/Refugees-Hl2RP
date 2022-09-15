FACTION.name = "Civil Research Union"
FACTION.description = "Universal Union approved science shit."
FACTION.color = Color(252, 186, 3)
FACTION.models = {
	"models/bmscientistcits/female_01.mdl",
	"models/bmscientistcits/female_02.mdl",
	"models/bmscientistcits/female_03.mdl",
	"models/bmscientistcits/female_04.mdl",
	"models/bmscientistcits/female_06.mdl",
	"models/bmscientistcits/female_07.mdl",
	"models/bmscientistcits/male_01.mdl",
	"models/bmscientistcits/male_02.mdl",
	"models/bmscientistcits/male_03.mdl",
	"models/bmscientistcits/male_04.mdl",
	"models/bmscientistcits/male_05.mdl",
	"models/bmscientistcits/male_06.mdl",
	"models/bmscientistcits/male_07.mdl",
	"models/bmscientistcits/male_08.mdl",
	"models/bmscientistcits/male_09.mdl",
	"models/bmscientistcits/male_10.mdl"
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION_CRU = FACTION.index


function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	local name = character:GetName()
  	character:SetName("Dr. " .. name)
end