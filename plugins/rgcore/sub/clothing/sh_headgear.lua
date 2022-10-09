/* -------------------------------------------------------------------------- */
/*                                  Headgear                                  */
/* -------------------------------------------------------------------------- */

local items = {
    ["beanie1"] = {
        name = "Beanie (Variant 1)",
        model = "models/fty/items/beanie.mdl",
        skin = 0,
        groups = {
            ["headgear"] = 1
        }
    },
    ["beanie2"] = {
        name = "Beanie (Variant 2)",
        model = "models/fty/items/beanie.mdl",
        skin = 1,
        groups = {
            ["headgear"] = 2
        }
    },
    ["volkshat"] = {
        name = "Volk's Hat",
        desc = "God damnit Hans! We are panzergrenadiers! NOT PANZERS!",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["headgear"] = 3
        }
    },
    ["buckethat"] = {
        name = "Fisherman's Hat",
        desc = "Also known as Bucket Hat",
        model =  "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["headgear"] = 4
        }
    },
    ["green_cap"] = {
        name = "Green Cap",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["headgear"] = 5
        }
    },
    ["beret"] = {
        name = "Beret",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["headgear"] = 6
        }
    },
    ["gasmask"] = {
        name = "Gasmask",
        model = "models/props_c17/BriefCase001a.mdl",
        groups = {
            ["headstrap"] = 5,
            ["glasses"] = 0
        }
    }
}

PLUGIN:AddClothingItemTable(items)