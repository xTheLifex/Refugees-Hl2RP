-- -------------------------------------------------------------------------- --
--                                    Armor                                   --
-- -------------------------------------------------------------------------- --

local items = {
    ["armor_rebelcp_medic"] = {
        name = "Repurposed CP Kevlar - Medic",
        model = "models/fty/items/shirt_rebelmetrocop.mdl",
        armor = 40,
        groups = {
            ["kevlar"] = 1
        }
    },
    ["armor_rebelcp_bag"] = {
        name = "Repurposed CP Kevlar - Bag",
        model = "models/fty/items/shirt_rebelmetrocop.mdl",
        armor = 40,
        groups = {
            ["kevlar"] = 2
        }
    },
    ["armor_rebelsoldier"] = {
        name = "Repurposed Overwatch Armor",
        model = "models/fty/items/shirt_rebelmetrocop.mdl",
        armor = 80,
        groups = {
            ["kevlar"] = 3
        }
    },
    ["armor_rebelcp"] = {
        name = "Repurposed CP Kevlar",
        model = "models/fty/items/shirt_rebelmetrocop.mdl",
        armor = 40
        groups = {
            ["kevlar"] = 4
        }
    },
    ["armor_kevlar"] = {
        name = "Heavy Kevlar",
        model = "models/fty/items/shirt_rebelmetrocop.mdl",
        armor = 70
        groups = {
            ["kevlar"] = 5
        }
    },
    ["armor_cp"] = {
        name = "Civil Protection Kevlar",
        model = "models/fty/items/shirt_rebelbag.mdl"
    }
}

PLUGIN:AddClothingItemTable(items)