/* -------------------------------------------------------------------------- */
/*                                   Gloves                                   */
/* -------------------------------------------------------------------------- */

local items = {
    ["gloves"] = {
        name = "Gloves",
        model = "models/fty/items/gloves.mdl",
        groups = {
            ["hands"] = 1
        }
    }
}

PLUGIN:AddClothingItemTable(items)