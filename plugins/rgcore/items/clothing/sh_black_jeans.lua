ITEM.name = "Black Jeans"
ITEM.model = Model("models/fty/items/pants_citizen.mdl")
ITEM.description = "Your standard citizen attires."

function ITEM:GetSkin()
    return 2
end

ITEM.bodygroups = {
    ["legs"] = 1
}
