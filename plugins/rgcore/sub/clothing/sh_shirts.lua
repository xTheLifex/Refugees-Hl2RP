/* -------------------------------------------------------------------------- */
/*                                   Shirts                                   */
/* -------------------------------------------------------------------------- */

local items = {
    ["jumpsuit"] = {
        name = "Citizen Jumpsuit", -- Item's display name
        model = "models/props_c17/BriefCase001a.mdl", -- Model path to use
        desc = "Your standard citizen jumpsuit. Wearing this item will make you pull the sleeves, and unwearing will make your jumpsuit go back to normal.", -- Item description
        skin = 0, -- The skin of the above model. Not a skin to set.
        groups = {
            ["torso"] = 1
        }
    },
    ["jumpsuit_cwu_w"] = {
        name = "CWU Jumpsuit - W",
        model = "models/props_c17/BriefCase001a.mdl",
        desc = "A beige worker-class uniform top.",
        skin = 2,
        groups = {
            ["torso"] = 2
        }
    },
    ["jumpsuit_cmu_m"] = {
        name = "CMU Jumpsuit - M",
        desc = "A beige medic-class uniform top.",
        skin = 2,
        groups = {
            ["torso"] = 3
        }
    },
    ["jumpsuit_cmu_d"] = {
        name = "CMU Jumpsuit - D",
        desc = "A beige director-class uniform top.",
        skin = 2,
        groups = {
            ["torso"] = 4
        }
    },
    ["jumpsuit_cwu_a"] = {
        name = "CWU Jumpsuit - A",
        desc = "A beige associate-class uniform top.",
        skin = 1,
        groups = {
            ["torso"] = 5
        }
    },
    ["jumpsuit_cwu_l"] = {
        name = "CWU Jumpsuit - L",
        desc = "A beige labourer-class uniform top.",
        skin = 1,
        groups = {
            ["torso"] = 6
        }
    },
    ["jumpsuit_cwu_d"] = {
        name = "CWU Jumpsuit - D",
        desc = "A beige director-class uniform top.",
        skin = 1,
        groups = {
            ["torso"] = 7
        }
    },
    ["jumpsuit_green"] = {
        name = "Green Jumpsuit Shirt",
        desc = "A green variant of the standard citizen uniform shirt.",
        skin = 3,
        groups = {
            ["torso"] = 8
        }
    },
    ["shirt_camo"] = {
        name = "Short-Sleeved Camo Shirt",
        model = "models/props_c17/BriefCase001a.mdl",
        desc = "A camouflaged variant of the standard citizen uniform shirt minus the forearms.",
        groups = {
            ["torso"] = 9
        }
    },
    ["shirt_beige"] = {
        name = "Beige Sweater",
        desc = "A beige microfleece sweater.",
        groups = {
            ["torso"] = 10
        }
    },
    ["shirt_lightgreen"] = {
        name = "Green Sweater",
        desc = "A green microfleece sweater.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 11
        }
    },
    ["shirt_greysweater"] = {
        name = "Grey Sweater",
        desc = "A grey microfleece sweater.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 12
        }
    },
    ["shirt_turqsweater"] = {
        name = "Turquoise Sweater",
        desc = "A turquoise microfleece sweater.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 13
        }
    },
    ["jacket_closed"] = {
        name = "Leather Jacket",
        desc = "A heavy leather jacket emblazoned with a Combine symbol.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 14
        }
    },
    ["jacket_open"] = {
        name = "Short-Sleeved Black Jacket",
        desc = "An unbuttoned black jacket and undershirt emblazoned with a Combine symbol.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 15
        }
    },
    ["shirt_striped"] = {
        name = "Short-Sleeved Plaid Shirt",
        desc = "Cotton plaid shirt that will make you feel more Canadian. Warm and cozy.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["torso"] = 16
        }
    },
    ["shirt_formal_white"] = {
        name = "White Dress Shirt",
        desc = "A simple white-collar cotton button-down shirt you'd wear to a boring office job.",
        groups = {
            ["torso"] = 17
        }
    },
    ["shirt_formal_blue"] = {
        name = "Blue Dress Shirt",
        desc = "A simple blue-collar cotton button-down shirt you'd wear in a machine shop.",
        groups = {
            ["torso"] = 18
        }
    },
    ["shirt_medic"] = {
        name = "Medic Shirt",
        desc = "A teal shirt adorned with two red cross armbands.",
        groups = {
            ["torso"] = 19
        }
    },
    ["wintercoat_beige"] = {
        name = "Grey Parka",
        desc = "A down-filled parka that will definitely keep you warm.",
        groups = {
            ["torso"] = 20
        }
    },
    ["wintercoat_green"] = {
        name = "Brown Parka",
        desc = "A down-filled parka that will definitely keep you warm.",
        groups = {
            ["torso"] = 21
        }
    },
    ["wintercoat_blue"] = {
        name = "Blue Windbreaker",
        desc = "A cheap nylon shell that's good for blocking the wind and that's about it.",
        groups = {
            ["torso"] = 22
        }
    },
    ["wintercoat_teal"] = {
        name = "Green Windbreaker",
        desc = "A cheap nylon shell that's good for blocking the wind and that's about it.",
        groups = {
            ["torso"] = 23
        }
    },
    ["wintercoat_red"] = {
        name = "Red Windbreaker",
        desc = "A cheap nylon shell that's good for blocking the wind and that's about it.",
        groups = {
            ["torso"] = 24
        }
    },
    ["wintercoat_olive"] = {
        name = "Green Industrial Jacket",
        desc = "A flashproof canvas jacket typically worn by construction workers.",
        groups = {
            ["torso"] = 25
        }
    },
    ["wintercoat_grey"] = {
        name = "Grey Industrial Jacket",
        desc = "A flashproof canvas jacket typically worn by construction workers.",
        groups = {
            ["torso"] = 26
        }
    },
    ["jacket"] = {
        name = "Black Tactical Jacket",
        desc = "A clandestine black tactical jacket articulated for good mobility.",
        groups = {
            ["torso"] = 27
        }
    },
    ["shirt_pc"] = {
        name = "Prisoner Shirt",
        desc = "Uniform issued to all prisoners - or as they like to call it- Political Conscripts of the combine.",
        groups = {
            ["torso"] = 28
        }
    },
    ["labcoat_white"] = {
        name = "White Labcoat",
        desc = "A white labcoat that has seen its fair share of Science.",
        groups = {
            ["torso"] = 29
        }
    },
    ["labcoat_teal"] = {
        name = "Grey Labcoat",
        desc = "A grey labcoat that will definitely make you feel smarter.",
        groups = {
            ["torso"] = 30
        }
    },
    ["wintercoat_brown"] = {
        name = "Bomber Jacket",
        desc = "An insulated brown flight jacket with a wool-lined collar.",
        groups = {
            ["torso"] = 31
        }
    },
    ["wintercoat_security"] = {
        name = "Security Jacket",
        desc = "A thick blue jacket emblazoned with 'SECURITY'.",
        groups = {
            ["torso"] = 32
        }
    },
    ["shirt_military"] = {
        name = "Military Jacket",
        desc = "A former-service battle dress uniform top.",
        groups = {
            ["torso"] = 33
        }
    },
    ["bandit_brown"] = {
        name = "Brown Trenchcoat",
        desc = "A ratty leather trenchcoat that keeps the dust off your boots.",
        groups = {
            ["torso"] = 34
        }
    },
    ["bandit_black"] = {
        name = "Black Trenchcoat",
        desc = "A ratty leather trenchcoat that keeps the dust off your boots.",
        groups = {
            ["torso"] = 35
        }
    },
    ["suit_brown"] = {
        name = "Brown Suit Top",
        desc = "An especialy dashing custom-fit brown blazer, tie and dress shirt.",
        groups = {
            ["torso"] = 36
        }
    },
    ["suit_black"] = {
        name = "Black Suit Top",
        desc = "A cheap baggy black suit jacket, tie and dress shirt.",
        groups = {
            ["torso"] = 37
        }
    },
    ["armband_lambda"] = {
        name = "Lambda Armband",
        desc = "A protective metal armband marked with a yellow insignia.",
        groups = {
            ["armband"] = 1
        }
    },
    ["armband_combine"] = {
        name = "Armband",
        desc = "A protective metal armband used to identify members of a group.",
        groups = {
            ["armband"] = 2
        }
    }
    
}
PLUGIN:AddClothingItemTable(items)