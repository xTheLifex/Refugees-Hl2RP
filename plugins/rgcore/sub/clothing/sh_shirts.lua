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
        },
        canUnwear = function() return false end
    },
    ["cwu_jumpsuit"] = {
        name = "CWU Jumpsuit",
        model = "models/fty/items/shirt_citizen2.mdl",
        skin = 2,
        groups = {
            ["torso"] = 3
        },
        canUnwear = function() return false end
    },
    ["cmu_jumpsuit"] = {
        name = "Civil Medical Union Jumpsuit",
        skin = 2,
        groups = {
            ["torso"] = 2
        },
        canUnwear = function() return false end
    },
    ["green_jumpsuit"] = {
        name = "Green Jumpsuit",
        skin = 1,
        groups = {
            ["torso"] = 4
        },
        canUnwear = function() return false end
    },
    ["camo_shirt"] = {
        name = "Camo Shirt",
        model = "models/fty/items/shirt_citizen2.mdl",
        skin = 1,
        groups = {
            ["torso"] = 5
        },
        canUnwear = function() return false end
    },
    ["black_jacket"] = {
        name = "Black Jacket",
        skin = 3,
        groups = {
            ["torso"] = 6
        },
        canUnwear = function() return false end
    },
    ["jacket"] = {
        name = "Jacket",
        skin = 3,
        groups = {
            ["torso"] = 7
        },
        canUnwear = function() return false end
    },
    ["green_wintercoat"] = {
        name = "Green Wintercoat",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 8
        },
        canUnwear = function() return false end,
    },
    ["brown_suit"] = {
        name = "Brown Suit",
        groups = {
            ["torso"] = 9
        },
        canUnwear = function() return false end
    },
    ["blue_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 10
        },
        canUnwear = function() return false end
    },
    ["cyan_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 11
        },
        canUnwear = function() return false end
    },
    ["red_winterjacket"] = {
        name = "Blue Winter Jacket",
        model = "models/fty/items/wintercoat.mdl",
        groups = {
            ["torso"] = 12
        },
        canUnwear = function() return false end
    },
    ["tactical_outfit"] = {
        name = "Tactical Outfit",
        model = "models/fty/items/shirt_rebel1.mdl",
        groups = {
            ["torso"] = 13
        },
        canUnwear = function() return false end
    },
    ["green_industrial_jumpsuit"] = {
        name = "Green Industrial Jumpsuit",
        groups = {
            ["torso"] = 14
        },
        canUnwear = function() return false end
    },
    ["blue_industrial_jumpsuit"] = {
        name = "Blue Industrial Jumpsuit",
        groups = {
            ["torso"] = 15
        },
        canUnwear = function() return false end
    },
    ["blue_jumpsuit"] = {
        name = "Blue Citizen Jumpsuit",
        groups = {
            ["torso"] = 16
        },
        canUnwear = function() return false end
    },
    ["white_labcoat"] = {
        name = "White Labcoat",
        groups = {
            ["torso"] = 17
        },
        canUnwear = function() return false end
    },
    ["black_jeans_jacket"] = {
        name = "Black Jeans Jacket",
        skin = 3,
        groups = {
            ["torso"] = 18
        },
        canUnwear = function() return false end
    }
}
PLUGIN:AddClothingItemTable(items)