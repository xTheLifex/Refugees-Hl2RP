local ITEM = ITEM
ITEM.name = "Manhack"
ITEM.description = "A viscerator, ready to be deployed by Civil Protection."
ITEM.model = "models/manhack.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-43.08, 25.11, 159.89),
	ang = Angle(72.57, 329.65, 0),
	fov = 5.3
}


local deploySounds = {
    "buttons/combine_button1.wav",
    "buttons/combine_button2.wav",
    "buttons/combine_button3.wav",
    "buttons/combine_button5.wav"
}

ITEM.functions.Deploy = {
    name = "Deploy", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    tip = "Deploys the turret on the ground", -- uses the "myFunctionDescription" language phrase when displaying in the UI
    icon = "icon16/add.png", -- path to the icon material
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local entity = item.entity -- only set if this is function is being ran while the item is in the world

        if (!IsValid(entity) and IsValid(client)) then

            if (ix.anim.GetModelClass(character:GetModel()) == "metrocop") then
                local manhack = ents.Create("npc_manhack")
                
                if (!IsValid(manhack)) then
                    return false
                end

                manhack:SetPos(client:GetPos() + Vector(0,0,100))
                manhack:SetAngles(client:GetAngles())
                manhack:Spawn()
                manhack:SetSequence("Deploy")
                manhack:SetSquad("Squad" .. character:GetName())
                client:EmitSound(deploySounds[math.floor(math.random(1,#deploySounds))])

                if (ix.anim.GetModelClass(character:GetModel()) == "metrocop") then
                    client:ForceSequence("deploy")
                end
            end


            return true
        end




        -- do not remove this item from the owning player's inventory
        return false
    end,
    OnCanRun = function(item)
        -- only allow admins to run this item function
        local client = item.player
        return IsValid(client) and client:IsCombine()
    end
}