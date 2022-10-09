ITEM.name = "Green Beanie"
ITEM.model = Model("models/fty/items/beanie.mdl")
ITEM.description = "It's a green beanie!"

function ITEM:GetSkin() return 1 end

ITEM.malegroups = {
    ["headgear"] = 2
}

ITEM.femalegroups = {
    ["headgear"] = 1
}
