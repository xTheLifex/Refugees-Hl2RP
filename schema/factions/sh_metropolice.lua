
FACTION.name = "Metropolice Force"
FACTION.description = "A metropolice unit working as Civil Protection."
FACTION.color = Color(50, 100, 150)
FACTION.pay = 10
FACTION.models = {"models/ma/hla/terranovafemalepolice.mdl",
                  "models/ma/hla/terranovapolice.mdl"}
FACTION.weapons = {"ix_stunstick"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}
FACTION.walkSounds = {[0] = "NPC_MetroPolice.FootstepLeft", [1] = "NPC_MetroPolice.FootstepRight"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("pistol", 1)
	inventory:Add("pistolammo", 2)
	inventory:Add("handheld_radio", 1)
end

function FACTION:GetDefaultName(client)
	return "CCA-C34:RCT-" .. Schema:ZeroNumber(math.random(1, 9999), 4), true
end

FACTION_MPF = FACTION.index
