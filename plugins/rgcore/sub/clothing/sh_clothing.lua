/* -------------------------------------------------------------------------- */
/*                                Clothing Base                               */
/* -------------------------------------------------------------------------- */

function PLUGIN:SetPlayerBodygroup(ply, groupname, value)
    if (!ply or !IsValid(ply)) then return end
    if (!groupname) then return end
    local value = value or 0
    local index = ply:FindBodygroupByName(groupname)
    if (index > -1) then
        local char = ply:GetCharacter()
        if (char) then
            local groups = char:GetData("groups", {})
            groups[index] = value
            char:SetData("groups", groups)
        end
        ply:SetBodygroup(index, value)
    end
end

function PLUGIN:AddClothingItemTable(t)
    for id, data in pairs(t) do
        print("[RG Clothing] Registering " .. id)
        local ITEM = ix.item.Register(id, nil, false, nil, true)
        if (!ITEM) then
            print("[RG Clothing] Failed to register " .. id )
            continue
        end
        ITEM.name = data.name or "Unknown Clothing Item"
        ITEM.description = data.desc or "This item can be worn."
        ITEM.model = data.model or "models/fty/items/shirt_citizen1.mdl"
        ITEM.skin = data.skin or 0
        ITEM.groups = data.groups or {}
        ITEM.groups_female = data.groups_female or {}
        ITEM.groups_male = data.groups_male or {}
        ITEM.onlyFemale = data.onlyFemale or false
        ITEM.onlyMale = data.onlyMale or false
        ITEM.factions = data.factions or {FACTION_CITIZEN, FACTION_CWU, FACTION_CMU}
        ITEM.models = data.models or {}
        ITEM.armor = data.armor or 0
        ITEM.canDrop = data.canDrop or function() return true end
        ITEM.canWear = data.canWear or function() return true end
        ITEM.canUnwear = data.canUnwear or function() return true end
        ITEM.GetSkin = data.GetSkin or function(item) return ITEM.skin or 0 end
        ITEM.functions.Wear = {
            name = "Wear",
            tip = "Wear this clothing item",
            icon = "icon16/add.png",
            OnRun = function(item) 
                local client = item.player
                if (!client) then return end
                local snd = false
                if (item.groups) then
                    for name,val in pairs(item.groups) do
                        self:SetPlayerBodygroup(client, name, val)
                        snd = true
                    end
                end
                if (item.groups_female) then
                    for name,val in pairs(item.groups_female) do
                        self:SetPlayerBodygroup(client, name, val)
                        snd = true
                    end
                end
                if (item.groups_male) then
                    for name,val in pairs(item.groups_male) do
                        self:SetPlayerBodygroup(client, name, val)
                        snd = true
                    end
                end
                if (item.armor) then
                    client:SetArmor(item.armor)
                end
                if (snd) then client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1) end
                return false
            end,
            OnCanRun = function(item) 
                if (item.entity) then return false end
                if (item.canWear != nil) then
                    if (isbool(item.canWear)) then
                        return item.canWear
                    end
                    local suc, res = pcall(item.canWear, item)
                    if (suc) then
                        if (res == true) then return true end
                        if (res == false) then return false end
                    else
                        print("[RG Clothing] Item CanWear call failed. Falling back to base checks. Error below:\n" .. res)
                    end
                end
                local client = item.player
                if (!client) then return false end
                local character = client:GetCharacter()
                if (!character) then return false end

                if (item.onlyFemale) then
                    if (!client:IsFemale()) then return false end
                end

                if (item.onlyMale) then
                    if (client:IsFemale()) then return false end
                end

                if (item.models) then
                    for _, model in ipairs(item.models) do
                        if (client:GetModel() == model) then
                            return true
                        end
                    end
                    return false
                end

                if (item.factions) then
                    for _,fac in ipairs(item.factions) do
                        if (character:GetFaction() == fac) then
                            return true
                        end
                    end
                end

                return false
            end
        }
        ITEM.functions.Unwear = {
            name = "Unwear",
            tip = "Unwear this clothing item",
            icon = "icon16/delete.png",
            OnRun = function(item) 
                local client = item.player
                if (!client) then return end
                local snd = false
                if (item.groups) then
                    for name,val in pairs(item.groups) do
                        self:SetPlayerBodygroup(client, name, 0)
                        snd = true
                    end
                end
                if (item.groups_female) then
                    for name,val in pairs(item.groups_female) do
                        self:SetPlayerBodygroup(client, name, 0)
                        snd = true
                    end
                end
                if (item.groups_male) then
                    for name,val in pairs(item.groups_male) do
                        self:SetPlayerBodygroup(client, name, 0)
                        snd = true
                    end
                end
                if (item.armor) then
                    client:SetArmor(math.Clamp(client:Armor() - item.armor, 0, 255))
                end
                if (snd) then client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1) end
                return false
            end,
            OnCanRun = function(item) 
                if (item.entity) then return false end
                if (item.canUnwear != nil) then
                    if (isbool(item.canUnwear)) then
                        return item.canUnwear
                    end
                    local suc, res = pcall(item.canUnwear, item)
                    if (suc) then
                        if (res == true) then return true end
                        if (res == false) then return false end
                    else
                        print("[RG Clothing] Item CanUnwear call failed. Falling back to base checks. Error below:\n" .. res)
                    end
                end
                local client = item.player
                if (!client) then return false end
                local character = client:GetCharacter()
                if (!character) then return false end

                if (item.onlyFemale) then
                    if (!client:IsFemale()) then return false end
                end

                if (item.onlyMale) then
                    if (client:IsFemale()) then return false end
                end

                if (item.models) then
                    for _, model in ipairs(item.models) do
                        if (client:GetModel() == model) then
                            return true
                        end
                    end
                    return false
                end

                if (item.factions) then
                    for _,fac in ipairs(item.factions) do
                        if (character:GetFaction() == fac) then
                            return true
                        end
                    end
                end

                return false
            end
        }
        ITEM.functions.drop = {
            tip = "dropTip",
            icon = "icon16/world.png",
            OnRun = function(item) 
                local client = item.player
                if (!client) then return end
                if (item.groups) then
                    for name,val in pairs(item.groups) do
                        self:SetPlayerBodygroup(client, name, 0)
                    end
                end
                if (item.groups_female) then
                    for name,val in pairs(item.groups_female) do
                        self:SetPlayerBodygroup(client, name, 0)
                    end
                end
                if (item.groups_male) then
                    for name,val in pairs(item.groups_male) do
                        self:SetPlayerBodygroup(client, name, 0)
                    end
                end
                local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

                if (!bSuccess and isstring(error)) then
                    item.player:NotifyLocalized(error)
                else
                    item.player:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
                end

                return false
            end,
            OnCanRun = function(item) 
                if (item.entity) then return false end
                if (item.noDrop) then return false end
                if (item.canDrop != nil) then
                    if (isbool(item.canDrop)) then
                        return item.canDrop
                    end
                    local suc, res = pcall(item.canDrop, item)
                    if (suc) then
                        if (res == true) then return true end
                        if (res == false) then return false end
                    else
                        print("[RG Clothing] Item CanDrop call failed. Falling back to base checks. Error below:\n" .. res)
                    end
                end
                local client = item.player
                if (!client) then return false end
                local character = client:GetCharacter()
                if (!character) then return false end

                if (item.onlyFemale) then
                    if (!client:IsFemale()) then return false end
                end

                if (item.onlyMale) then
                    if (client:IsFemale()) then return false end
                end

                if (item.models) then
                    for _, model in ipairs(item.models) do
                        if (client:GetModel() == model) then
                            return true
                        end
                    end
                    return false
                end

                if (item.factions) then
                    for _,fac in ipairs(item.factions) do
                        if (character:GetFaction() == fac) then
                            return true
                        end
                    end
                end

                return false
            end
        }
    end
end


/* -------------------------------- Includes -------------------------------- */

ix.util.Include("sh_shirts.lua")
ix.util.Include("sh_pants.lua")
ix.util.Include("sh_gloves.lua")
ix.util.Include("sh_headgear.lua")