
FACTION.name = "Overwatch Transhuman Arm"
FACTION.description = "A transhuman Overwatch soldier produced by the Combine."
FACTION.color = Color(150, 50, 50, 255)
FACTION.models = {"models/Combine_Soldier.mdl"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_CombineS.RunFootstepLeft", [1] = "NPC_CombineS.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ar2", 1)
	inventory:Add("ar2ammo", 4)
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
	return "UU-OTA-OWS:" .. tagline .. "-" .. tagnumber .. ":" .. id, true
end

FACTION_OTA = FACTION.index
