/* -------------------------------------------------------------------------- */
/*                                   Pants                                    */
/* -------------------------------------------------------------------------- */

local items = {
    ["jeans_blue"] = {
        name = "Dark Blue Jeans",
        desc = "Part of your standard citizen attire.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 0
        },
        canUnwear = false -- You can't remove your only pants.
    },
    ["jeans_white"] = {
        name = "Cargo Pants",
        desc = "A sturdy pair of bleached denim cargo pants.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 1
        }
    },
    ["jeans_green"] = {
        name = "Green Trackpants",
        desc = "A pair of green nylon trackpants with a yellow stripe running down the length.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 2
        }
    },
    ["jeans_blue"] = {
        name = "Blue Trackpants",
        desc = "A pair of blue nylon trackpants with a yellow stripe running down the length.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 3
        }
    },
    ["jeans_black"] = {
        name = "Brown Trackpants",
        desc = "A filthy pair of brown nylon trackpants with a faded yellow stripe running down the length.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 4
        }
    },
    ["pants_black"] = {
        name = "Black Tactical Pants",
        desc = "A pair of black tactical pants articulated for good mobility.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 5
        }
    },
    ["pants_camo_black"] = {
        name = "Digital Camo Jeans",
        desc = "A pair of urban camouflaged jeans.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 6
        }
    },
    ["pants_orange"] = {
        name = "Prisoner Pants",
        desc = "An institutionalized set of pants issued to convicts.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 7
        }
    },
    ["pants_military"] = {
        name = "Military Trousers",
        desc = "A pair of former-service battle dress uniform leggings and combat boots.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 8
        }
    },
    ["jeans_dirty"] = {
        name = "Stitched Jeans",
        desc = "An improvised pair of pants, for staying modest with.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 9
        }
    },
    ["jeans_black_dirty"] = {
        name = "Green Jeans",
        desc = "A pair of green denim jeans.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 10
        }
    },
    ["jeans_teal"] = {
        name = "Washed Jeans",
        desc = "A pair of bright, stonewashed denim jeans.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 11
        }
    },
    ["pants_rebel_green"] = {
        name = "Armoured Green Trousers",
        desc = "A modified set of trousers fitted with protective armour plates for each leg.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 12
        }
    },
    ["pants_rebel_camo"] = {
        name = "Armoured Digital Trousers",
        desc = "A modified set of trousers fitted with protective armour plates for each leg.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 13
        }
    },
    ["pants_rebel_blue"] = {
        name = "Armoured Blue Trousers",
        desc = "A modified set of trousers fitted with protective armour plates for each leg.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 14
        }
    },
    ["pants_rebel_black"] = {
        name = "Armoured Black Trousers",
        desc = "A modified set of trousers fitted with protective armour plates for each leg.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 15
        }
    },
    ["jeans_brown"] = {
        name = "Brown Slacks",
        desc = "A loose-fitting pair of canvas pants and sneakers.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 16
        }
    },
    ["jeans_black_alt"] = {
        name = "Black Slacks",
        desc = "A loose-fitting pair of canvas pants and sneakers.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 17
        }
    },
    ["pants_fancy_brown"] = {
        name = "Brown Suit Bottom",
        desc = "A fancy set of custom-tailored brown chinos and smart shoes.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 18
        }
    },
    ["pants_fancy_black"] = {
        name = "Black Suit Bottom",
        desc = "A cheap excuse for a businessman's lower half.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["legs"] = 19
        }
    },
    
}
PLUGIN:AddClothingItemTable(items)