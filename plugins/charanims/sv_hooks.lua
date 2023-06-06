
local animationList = {
	male = {
		"g_lefthandmotion",
		"g_look",
		"g_look_small",
		"g_noway_big"
	},
	female = {
		"g_left_openhand",
		"g_display_left",
		"urgenthandsweep"
	}
}

local chatClasses = {
	["ic"] = true,
	["w"] = true,
	["y"] = true
}

function PLUGIN:PostPlayerSay(client, chatType)
	if (!client:Alive() or !chatClasses[chatType]) then return end

	local modelClass = ix.anim.GetModelClass(client:GetModel())
	if (modelClass != "citizen_male" and modelClass != "citizen_female") then return end

	local activeWeapon = client:GetActiveWeapon()
	if (!IsValid(activeWeapon) or activeWeapon:GetClass() != "ix_hands") then return end

	local animation = client:IsFemale() and animationList.female[math.random(#animationList.female)] or animationList.male[math.random(#animationList.male)]

	net.Start("ixPlayGesture")
		net.WriteEntity(client)
		net.WriteUInt(client:LookupSequence(animation), 32)
	net.Broadcast()
end