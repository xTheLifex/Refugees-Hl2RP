/* -------------------------------------------------------------------------- */
/*                                   Gloves                                   */
/* -------------------------------------------------------------------------- */

local items = {
    ["gloves_fingerless"] = {
        name = "Fingerless Gloves",
        desc = "A pair of gloves with the digits removed for added dexterity.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["hands"] = 1
        }
    },
    ["gloves"] = {
        name = "Gloves",
        desc = "A pair of leather gloves.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["hands"] = 2
        }
    },
    ["gloves_nitrile"] = {
        name = "Latex Gloves",
        desc = "A disposable pair of blue latex gloves.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["hands"] = 3
        }
    },
    ["ring"] = {
        name = "Golden Ring",
        desc = "It's a golden ring. It seems like real gold athough you have no way of knowing - and it probably doesn't matter by now.",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["hands"] = 4
        }
    }
}

PLUGIN:AddClothingItemTable(items)