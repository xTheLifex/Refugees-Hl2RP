local ITEM = ITEM
ITEM.name = "Combine Turret"
ITEM.description = "A turret ready to be deployed by Civil Protection engineers"
ITEM.model = Model("models/combine_turrets/floor_turret.mdl")
ITEM.classes = {CLASS_EMP}
ITEM.flag = "V"
ITEM.width = 2
ITEM.height = 4
ITEM.iconCam = {
	pos = Vector(75.78, 78.39, 49.96),
	ang = Angle(10.84, 227.87, 0),
	fov = 21.33
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

        if (IsValid(entity) and IsValid(client)) then
            local turret = ents.Create("npc_turret_floor")

            if (!IsValid(turret)) then
                return false
            end

            
            entity:EmitSound(deploySounds[math.floor(math.random(1,#deploySounds))])
            
            if (ix.anim.GetModelClass(character:GetModel()) == "metrocop") then
                client:ForceSequence("luggagepush")
            elseif (ix.anim.GetModelClass(character:GetModel()) == "overwatch") then
                client:ForceSequence("console_type")
            end

            turret:SetPos( entity:GetPos() )
            turret:SetAngles( entity:GetAngles() )
            entity:Remove()

            turret:Spawn()
            return true
        end

        -- do not remove this item from the owning player's inventory
        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        return IsValid(client) and client:IsCombine()
    end
}

ITEM.functions.drop =  {
    tip = "dropTip",
    icon = "icon16/world.png",
    OnRun = function(item)
        local ply = item.player

        item:Remove()
        item.player:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
        -- I want to set the dropped turret's mass lower so players can pick it up with hands and rotate it

        local pos = ply:GetItemDropPos()
        local playerangles = ply:GetAngles()
        local tr = util.TraceLine({
            start = pos,
            endpos = pos + Vector(0,0,-30),
            filter = function(ent) return false end})

        ix.item.Spawn("turret", tr.HitPos, function(item, entity)
            
        end, Angle(0, playerangles.y, 0))


        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and !item.noDrop
    end
}