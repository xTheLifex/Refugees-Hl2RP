-- -------------------------------------------------------------------------- --
--                                    Armor                                   --
-- -------------------------------------------------------------------------- --

local items = {
    ["kevlar_cp"] = {
        name = "CP Kevlar Vest",
        desc = "Standard Civil Protection-issue kevlar vest, covering the entire upper torso.\nProvides NIJ-rated level IIA protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 20,
        groups = {
            ["kevlar"] = 1
        }
    },
    ["kevlar_cp_medic"] = {
        name = "Medic Kevlar Vest",
        desc = "A modified Civil Protection kevlar vest adorned with various medical instruments, covering the entire upper torso.\nProvides NIJ-rated level II protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 40,
        groups = {
            ["kevlar"] = 2
        }
    },
    ["kevlar_cp_bag"] = {
        name = "Rebel Kevlar Vest",
        desc = "A modified Civil Protection kevlar vest adorned with bandoliers for holding ammunition and grenades, covering the entire upper torso.\nProvides NIJ-rated level II protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 40,
        groups = {
            ["kevlar"] = 3
        }
    },
    ["kevlar_black"] = {
        name = "Ballistic Vest",
        desc = "A sturdy aftermarket kevlar ballistic vest, covering the entire upper torso.\nProvides NIJ-rated level IIIA protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 60,
        groups = {
            ["kevlar"] = 4
        }
    },
    ["kevlar_black_heavy"] = {
        name = "Plate Carrier",
        desc = "A MOLLE-system plate carrier fitted with two metal plates, covering the entire torso and abdomen.\nProvides NIJ-rated level III protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 80,
        groups = {
            ["kevlar"] = 5
        }
    },
    ["kevlar_ota"] = {
        name = "Overwatch Bodypack",
        desc = "Standard Overwatch-issue plate carrier issued to Combine Soldiers, consisting of a series of overlapping metal plates inspired by pre-war scale armour.\nProvides NIJ-rated level IV protection.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 80,
        groups = {
            ["kevlar"] = 6
        }
    },
    ["vest_black"] = {
        name = "Hiking Vest",
        desc = "A black hiking vest that hangs over your shirt.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 5,
        groups = {
            ["kevlar"] = 7
        }
    },
    ["belt_single"] = {
        name = "Toolbelt",
        desc = "A single canvas toolbelt designed to hold a variety of hand tools.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 5,
        groups = {
            ["belt"] = 2
        }
    },
    ["belt_double"] = {
        name = "Tactical Belts",
        desc = "A pair of tactical belts fitted with slots for containing radios, holsters, grenades and other combat accessories.",
        model = "models/props_c17/BriefCase001a.mdl",
        armor = 5,
        groups = {
            ["belt"] = 1
        }
    }
}

PLUGIN:AddClothingItemTable(items)