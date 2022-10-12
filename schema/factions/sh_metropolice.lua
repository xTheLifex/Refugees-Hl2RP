
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
end

function FACTION:GetDefaultName(client)
	return "CCA-C34:RCT-" .. Schema:ZeroNumber(math.random(1, 9999), 4), true
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()
	if (!Schema:IsCombineRank(oldValue, "RCT") and Schema:IsCombineRank(value, "RCT")) then
		character:JoinClass(CLASS_MPR)
	elseif (!Schema:IsCombineRank(oldValue, "05") and Schema:IsCombineRank(value, "05")) then
		character:JoinClass(CLASS_MPU)
	elseif (!Schema:IsCombineRank(oldValue, "04") and Schema:IsCombineRank(value, "05")) then
		character:JoinClass(CLASS_MPU)
	elseif (!Schema:IsCombineRank(oldValue, "03") and Schema:IsCombineRank(value, "05")) then
		character:JoinClass(CLASS_MPU)
	elseif (!Schema:IsCombineRank(oldValue, "02") and Schema:IsCombineRank(value, "05")) then
		character:JoinClass(CLASS_MPU)
	elseif (!Schema:IsCombineRank(oldValue, "01") and Schema:IsCombineRank(value, "05")) then
		character:JoinClass(CLASS_MPU)
	elseif (!Schema:IsCombineRank(oldValue, "EpU") and Schema:IsCombineRank(value, "EpU")) then
		character:JoinClass(CLASS_EMP)
	elseif (!Schema:IsCombineRank(oldValue, "DvL") and Schema:IsCombineRank(value, "DvL")) then
		character:JoinClass(CLASS_EMP)
	elseif (!Schema:IsCombineRank(oldValue, "CmD") and Schema:IsCombineRank(value, "CmD")) then
		character:JoinClass(CLASS_EMP)
	elseif (!Schema:IsCombineRank(oldValue, "SCN") and Schema:IsCombineRank(value, "SCN")
	or !Schema:IsCombineRank(oldValue, "SHIELD") and Schema:IsCombineRank(value, "SHIELD")) then
		character:JoinClass(CLASS_MPS)
	end
end

FACTION_MPF = FACTION.index
