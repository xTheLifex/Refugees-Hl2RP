
FACTION.name = "Metropolice Force"
FACTION.description = "A metropolice unit working as Civil Protection."
FACTION.color = Color(50, 100, 150)
FACTION.models = {"models/pandapolice/police.mdl"}
FACTION.pay = 2
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

local function Pick(t)
    if (istable(t)) then
		return t[math.random(1, #t)]
    else
		return t
    end
end

function FACTION:GetDefaultName(client)
	local tagline = Pick({ "FLASH", "RANGER", "HUNTER", "BLADE", "SCAR", "HAMMER", "SWEEPER", "SWIFT", "FIST", "SWORD", "SAVAGE", "TRACKER", "SLASH", "RAZOR", "STAB", "SPEAR", "STRIKER", "DAGGER" })
	local tagnumber = math.random(1,9)
	local id = Schema:ZeroNumber(math.random(1, 9999), 4)
	return "CCA-C18:RcT." .. tagline .. "-" .. tagnumber .. ":" .. id, true
end

FACTION_MPF = FACTION.index
