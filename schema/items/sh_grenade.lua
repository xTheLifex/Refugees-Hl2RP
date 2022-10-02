ITEM.name = "Grenade"
ITEM.description = "A small, green colored MK3A2 grenade that explodes a few seconds after it is thrown."
ITEM.model = "models/weapons/w_grenade.mdl"
ITEM.weaponCategory = "grenade"
ITEM.classes = {CLASS_EOW}
ITEM.flag = "V"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.DropActive = {
    name = "Drop Active", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    tip = "Drops an active grenade on the floor.", -- uses the "myFunctionDescription" language phrase when displaying in the UI
    icon = "icon16/bomb.png", -- path to the icon material
    OnRun = function(item) 
        local ply = item.player
        timer.Simple(1, function() 
            local nade = ents.Create("npc_grenade_frag")
            local gpos = ply:GetAngles():Forward() * 42
            gpos[3] = 0
            nade:SetPos(ply:GetPos() + gpos)
            nade:Spawn()
            nade:Fire("SetTimer", "5")
        end)
        ply:ForceSequence("grenPlace")
    end,
    OnCanRun = function(item)
        local ent = item.entity
        local ply = item.player

        if (IsValid(ent)) then return false end

        if (!ply) then return false end
        local char = ply:GetCharacter()
        if (!char) then return false end

        local class = ix.anim.GetModelClass(char:GetModel())
        if (class != "overwatch") then return false end
    end
}

ITEM.functions.Roll = {
    name = "Roll", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    tip = "Roll the grenade live on the floor..", -- uses the "myFunctionDescription" language phrase when displaying in the UI
    icon = "icon16/bomb.png", -- path to the icon material
    OnRun = function(item) 
        local ply = item.player
        timer.Simple(1, function() 
            local nade = ents.Create("npc_grenade_frag")
            local fw = ply:GetAngles():Forward()
            fw[3] = 0
            local gpos = fw * 42

            local tr = util.TraceLine({
                start = ply:GetPos() + gpos,
                endpos = (ply:GetPos() + gpos) + Vector(0,0,-32),
                filter = function(ent) return false end
            })

            nade:SetPos(tr.HitPos + Vector(0,0,8))
            nade:Spawn()
            local phys = nade:GetPhysicsObject()
            local ang = ply:GetAngles()
            ang:RotateAroundAxis(Vector(1,0,0), 90)
            --TODO: Rotate around Y to properly roll the nade.
            nade:SetAngles(ang)
            phys:ApplyForceCenter(fw * 700)
            nade:Fire("SetTimer", "5")
        end)
        ply:ForceSequence("grenDrop")
    end,
    OnCanRun = function(item)
        local ent = item.entity
        local ply = item.player

        if (IsValid(ent)) then return false end

        if (!ply) then return false end
        local char = ply:GetCharacter()
        if (!char) then return false end

        local class = ix.anim.GetModelClass(char:GetModel())
        if (class != "overwatch") then return false end
    end
}

ITEM.functions.Throw = {
    name = "Throw", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    tip = "Toss the grenade!", -- uses the "myFunctionDescription" language phrase when displaying in the UI
    icon = "icon16/bomb.png", -- path to the icon material
    OnRun = function(item) 
        local ply = item.player
        local char = ply:GetCharacter()

        timer.Simple(1, function() 
            local nade = ents.Create("npc_grenade_frag")
            local fw = ply:GetAngles():Forward()
            fw[3] = 0
            local gpos = fw * 42
            nade:SetPos(ply:GetPos() + gpos + Vector(0,0,64))
            nade:Spawn()
            local phys = nade:GetPhysicsObject()
            phys:ApplyForceCenter(fw * 1000)
            nade:Fire("SetTimer", "5")
        end)

        local rgcore = ix.plugin.Get("rgcore")
        rgcore:FlagAsResistance(ply, -1) -- until death


        local class = ix.anim.GetModelClass(char:GetModel())
        if (class == "metrocop") then
            -- CIVIL PROTECTION
            ply:ForceSequence("grenadethrow")
        elseif (class == "overwatch") then
            -- OVERWATCH
            ply:ForceSequence("grenThrow")
        else
            -- REBEL?
            ply:ForceSequence("throw1")
        end
    end,
    OnCanRun = function(item)
        local ent = item.entity
        local ply = item.player

        if (!ply) then return false end
        if (IsValid(ent)) then return false end

        local char = ply:GetCharacter()
        if (!char) then return false end
    end
}