function PLUGIN:AddFoodItemTable(t)
    for id, data in pairs(t) do
        print("[RG Food] Registering " .. id)
        local ITEM = ix.item.Register(id, nil, false, nil, true)
        if (!ITEM) then
            print("[RG Food] Failed to register " .. id)
            break
        end
        ITEM.name = data.name or "Unknown Food Item"
        ITEM.description = data.desc or "This is a food item and can be eaten."
        ITEM.model = data.model or "models/props_junk/garbage_bag001a.mdl"
        ITEM.category = data.category or "Food and Drinks"
        ITEM.skin = data.skin or 0
        local trashitem = data.trash or nil
        local istrash = data.istrash or false
        local pack = data.pack or nil
        local ispackage = false
        if (pack ~= nil) then ispackage = true end

        if (not data.desc and ispackage) then
        ITEM.description = "This is a package item and can be unpackaged."
        end

        if (not data.desc and istrash) then
            ITEM.description = "This is a trash item, of what once was a package of some sorts."
        end

        if (not istrash and not ispackage) then
            ITEM.functions.Consume = {
                name = "Consume",
                tip = "Consume this item",
                icon = "icon16/add.png",
                OnRun = function(item)
                    local client = item.player
                    local character = client:GetCharacter()
                    local inventory = character:GetInventory()
                    if (!client) then return false end
                    client:SetHealth(math.min(client:Health() + (data.hp or 10), client:GetMaxHealth()))
                    --client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
                    if (data.trash ~= nil) then
                        if (!inventory:Add(data.trash)) then
                            ix.item.Spawn(data.trash, client)
                        end
                    end
                end
            }
        end

        if (ispackage) then
            ITEM.functions.Unpack = {
                name = "Unpack",
                tip = "Unpackage this item",
                icon = "icon16/add.png",
                OnRun = function(item)
                    local client = item.player
                    local character = client:GetCharacter()
                    local inventory = character:GetInventory()
                    if (!client) then return false end
                    for item, amount in pairs(data.pack) do
                        for i=1, amount do
							if (item == "token" or item == "tokens") then
								
							else
								if (!inventory:Add(item)) then
									ix.item.Spawn(item, client)
								end
							end
                        end
                    end
                    client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
                    --client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
                end
            }
        end

    end
end

/* -------------------------------- Includes -------------------------------- */
ix.util.Include("sh_fooditems.lua")
