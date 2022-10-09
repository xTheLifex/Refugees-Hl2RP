/* -------------------------------------------------------------------------- */
/*                                   Pants                                    */
/* -------------------------------------------------------------------------- */

local items = {
    ["blue_jeans"] = {
        name = "Blue Jeans",
        model = "models/fty/items/pants_citizen.mdl",
        groups = {
            ["legs"] = 0
        },
        canUnwear = false
    },
    ["jeans"] = {
        name = "Jeans",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 1,
        groups = {
            ["legs"] = 1
        }
    },
    ["black_pants_1"] = {
        name = "Black Pants w/ White Shoes",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 2,
        groups = {
            ["legs"] = 2
        }
    },
    ["black_pants_2"] = {
        name = "Black Pants w/ Black Shoes",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 2,
        groups = {
            ["legs"] = 3
        }
    },
    ["green_padded_jeans"] = {
        name = "Green Padded Jeans",
        model = "models/fty/items/pants_rebel.mdl",
        desc = "This jeans has some light armor on it.",
        groups = {
            ["legs"] = 4
        }
    },
    ["padded_jeans"] = {
        name = "Padded Jeans",
        model = "models/fty/items/pants_rebel.mdl",
        skin = 1,
        desc = "This jeans has some light armor on it",
        groups = {
            ["legs"] = 5
        }
    },
    ["black_jeans"] = {
        name = "Black Jeans",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 2,
        groups = {
            ["legs"] = 6
        }
    },
    ["fancy_brown_pants"] = {
        name = "Fancy Brown Pants",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 2,
        groups = {
            ["legs"] = 7
        }
    },
    ["tactical_pants"] = {
        name = "Tactical Pants",
        model = "models/fty/items/pants_rebel.mdl",
        skin = 1,
        groups = {
            ["legs"] = 8
        }
    },
    ["black_pants_3"] = {
        name = "Black Pants",
        model = "models/fty/items/pants_citizen.mdl",
        skin = 2,
        groups = {
            ["legs"] = 9
        }
    }
}
PLUGIN:AddClothingItemTable(items)