/* -------------------------------------------------------------------------- */
/*                                   Shirts                                   */
/* -------------------------------------------------------------------------- */

local items = {
    ["jumpsuit"] = {
        name = "Citizen Jumpsuit", -- Item's display name
        model = "models/fty/items/shirt_citizen1.mdl", -- Model path to use
        skin = 0, -- The skin of the above model. Not a skin to set.
        groups = {
            ["torso"] = 0
        }
    },
    ["cwu_jumpsuit"] = {
        name = "CWU Jumpsuit",
        model = "models/fty/items/shirt_citizen2.mdl",
        skin = 2,
        groups = {
            ["torso"] = 3
        }
    },
    ["cmu_jumpsuit"] = {
        name = "Civil Medical Union Jumpsuit",
        skin = 2,
        groups = {
            ["torso"] = 2
        }
    },
    ["green_jumpsuit"] = {
        name = "Green Jumpsuit",
        skin = 1,
        groups = {
            ["torso"] = 4
        }
    },
    ["camo_shirt"] = {
        name = "Camo Shirt",
        model = "models/fty/items/shirt_citizen2.mdl",
        skin = 1,
        groups = {
            ["torso"] = 5
        }
    },
    ["black_jacket"] = {
        name = "Black Jacket",
        skin = 3,
        groups = {
            ["torso"] = 6
        }
    },
    ["jacket"] = {
        name = "Jacket",
        skin = 3,
        groups = {
            ["torso"] = 7
        }
    },
    ["green_wintercoat"] = {
        name = "Green Wintercoat",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 8
        }
    },
    ["brown_suit"] = {
        name = "Brown Suit",
        groups = {
            ["torso"] = 9
        }
    },
    ["blue_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 10
        }
    },
    ["cyan_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 11
        }
    },
    ["red_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 12
        }
    },
    ["tactical_outfit"] = {
        name = "Tactical Outfit",
        model = "models/fty/items/shirt_rebel1.mdl",
        groups = {
            ["torso"] = 13
        }
    },
    ["green_industrial_jumpsuit"] = {
        name = "Green Industrial Jumpsuit",
        groups = {
            ["torso"] = 14
        }
    },
    ["blue_industrial_jumpsuit"] = {
        name = "Blue Industrial Jumpsuit",
        groups = {
            ["torso"] = 15
        }
    },
    ["blue_jumpsuit"] = {
        name = "Blue Citizen Jumpsuit",
        groups = {
            ["torso"] = 16
        }
    },
    ["white_labcoat"] = {
        name = "White Labcoat",
        groups = {
            ["torso"] = 17
        }
    },
    ["black_jeans_jacket"] = {
        name = "Black Jeans Jacket",
        skin = 3,
        groups = {
            ["torso"] = 18
        }
    }
}
PLUGIN:AddClothingItemTable(items)