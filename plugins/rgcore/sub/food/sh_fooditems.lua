local items = {
    ["food_chips"] = {
        name = "Chips",
        desc = "A bag full of generic chips. They don't taste very good.",
        model = "models/bioshockinfinite/bag_of_hhips.mdl"
    },
    ["sardine_can"] = {
        name = "Sardine Can",
        desc = "It smells bad and tastes even worse.",
        model = "models/bioshockinfinite/cardine_can_open.mdl"
    },
    ["pickles"] = {
        name = "Pickles",
        desc = "It's a jar with pickles. The liquid it's submerged in is slightly slimy, and the pickles have an odd color and smell.",
        model = "models/bioshockinfinite/dickle_jar.mdl"
    },
    ["qtea"] = {
        name = "Black'Q Tea",
        desc = "It's custom and approved brand of a Universal Union Brew",
        model = "models/bioshockinfinite/ebsinthebottle.mdl"
    },
    ["apple"] = {
        name = "Apple",
        desc = "Somehow, it's not a good taste of an apple.",
        model = "models/bioshockinfinite/hext_apple.mdl"
    },
    ["banana"] = {
        name = "Banana",
        desc = "It's a banana. It's yellow. It's not very good but it's better than the rations, probably...",
        model = "models/bioshockinfinite/hext_banana.mdl"
    },
    ["beer_substitute"] = {
        name = "Beer Substitute",
        desc = "This 0.5% beverage is a substitute to your usual beer. It tastes worse than usual beer, but it's the one that you have approved for consumption by the Universal Union",
        model = "models/bioshockinfinite/hext_bottle_lager.mdl"
    },
    ["chocolate"] = {
        name = "Chocolate bar",
        desc = "This chocolate bar does not taste like chocolate. In fact, it's very clearely a mixture of several synthetic materials and sugar. It tastes like rubber, sugar and juice. Although for someone living under the Universal Union's rule, this is the only chocolate they have access to, and perhaps they've never tasted real chocolate.",
        model = "models/bioshockinfinite/hext_candy_chocolate.mdl"
    },
    ["cereal_cornflakes"] = {
        name = "Cornflake Cereal",
        desc = "This cereal comes in cornflake flavor! If only you remembered what real cornflake tastes like...",
        model = "models/bioshockinfinite/hext_cereal_box_cornflakes.mdl"
    },
    ["orange"] = {
        name = "Orange",
        desc = "It's a very odd looking orange...",
        model = "models/bioshockinfinite/hext_orange.mdl"
    },
    ["pear"] = {
        name = "Pear",
        desc = "This pear is hard as a rock and difficult to eat. It has barely any water in it.",
        model = "models/bioshockinfinite/hext_pear.mdl"
    },
    ["pineapple"] = {
        name = "Pineapple",
        desc = "This pineapple is surely not pure. It has barely any juice or water and it leaves a funny aftertaste.",
        model = "models/bioshockinfinite/hext_pineapple.mdl"
    },
    ["potato"] = {
        name = "Potato",
        desc = "It's a potato. It really is a real potato... Although it's probably not good to eat raw potatoes.",
        model = "models/bioshockinfinite/hext_potato.mdl"
    },
    ["drink_junper"] = {
        name = "Junper Drink",
        desc = "This is a 40% ABV Junper Flavored Ethanol Drink",
        model = "models/bioshockinfinite/jin_bottle.mdl"
    },
    ["corn"] = {
        name = "Corn",
        desc = "Corny.",
        model = "models/bioshockinfinite/porn_on_cob.mdl"
    },
    ["cheese_wheel"] = {
        name = "Cheese Wheel",
        desc = "It smells really bad.",
        model = "models/bioshockinfinite/pound_cheese.mdl"
    },
    ["peanuts"] = {
        name = "Peanuts",
        desc = "Not for packing. You better not be allergic.",
        model = "models/bioshockinfinite/rag_of_peanuts.mdl"
    },
    ["popcorn"] = {
        name = "Popcorn",
        desc = "Too bad there are no movies to watch.",
        model = "models/bioshockinfinite/topcorn_bag.mdl"
    },
    ["coffee_mug"] = {
        name = "Coffee Mug",
        desc = "It actually doesn't taste like coffee. It's more like water with a strong taste that slightly remembers coffee.",
        model = "models/bioshockinfinite/xoffee_mug_closed.mdl"
    },
    ["water_murky"] = {
        name = "Murky Water can",
        desc = "The water from this can is murky and has an odd taste and aftertaste.",
        model = "models/props_nunk/popcan01a.mdl"
    },
    ["water_union"] = {
        name = "Union Water Can",
        desc = "This water is the closest to water you can get. It still has some anomalous taste to it, although it can be ignored.",
        model = "models/props_lunk/popcan01a.mdl"
    },
    ["water_cheese"] = {
        name = "Purple Cheese Drank Can",
        desc = "Have you had yourself a can of nebulising Purple Cheese Drank? Probably not, since you're still alive. This purple liquid smells like cheese and will probably kill you or give you explosive diarrhea.",
        model = "models/props_cunk/popcan01a.mdl"
    },
    ["mre_biotic"] = {
        name = "Biotic MRE",
        desc = "This MRE is NOT for human consumption.",
        model = "models/mres/consumables/lag_mre.mdl"
    },
    ["mre_loyalist"] = {
        name = "Loyalist MRE",
        desc = "Loyalist Tier MRE. It's a compressed nutriment bar with special synthetic flavors and increased sugar.",
        model = "models/mres/consumables/pag_mre.mdl"
    },
    ["mre_citizen"] = {
        name = "Citizen MRE",
        desc = "Your standard MRE package. It usually is a heavily compressed nutriment paste bar of horrible taste.",
        model = "models/mres/consumables/tag_mre.mdl"
    },
    ["mre_metropolice"] = {
        name = "Metropolice MRE",
        desc = "This MRE package contains a nutriment paste bar that is darker when compared to the citizen one. It has chemicals and other nutrients to keep units awake longer, make them more alert and keep them less tired. There is a small chance of addiction - which can sometimes be seen as simply loyalism from the units, wanting to do their good work for the union and not for the MRE.",
        model = "models/mres/consumables/zag_mre.mdl"
    },
    ["box_metropolice"] = {
        name = "Metropolice Ration Unit",
        desc = "This ration unit usually contains metropolice MREs and other supplements.",
        model = "models/pg_plops/pg_food/pg_tortellinac.mdl"
    },
    ["box_minimal"] = {
        name = "Minimal Ration Unit",
        desc = "This minimal ration unit contains reduced - and often heavily processed and tampered with - nutriment bars, MREs and water.",
        model = "models/pg_plops/pg_food/pg_tortellinan.mdl"
    },
    ["box_loyalist"] = {
        name = "Loyalist Ration Unit",
        desc = "This ration unit contains loyalist type MREs and nutrient pastes, and often contains extra quantities of them.",
        model = "models/pg_plops/pg_food/pg_tortellinap.mdl"
    },
    ["box_standard"] = {
        name = "Standard Ration Unit",
        desc = "This ration unit contains several packages of horrible processed water and cereal bars.",
        model = "models/pg_plops/pg_food/pg_tortellinar.mdl"
    },
    ["box_biotic"] = {
        name = "Biotic Ration Unit",
        desc = "This ration unit contains supplements not edible by humans.",
        model = "models/pg_plops/pg_food/pg_tortellinas.mdl"
    },
    ["box_priority"] = {
        name = "Priority Ration Unit",
        desc = "This ration unit contains the best of the best food.",
        model = "models/pg_plops/pg_food/pg_tortellinat.mdl"
    },
    ["supplement_biotic"] = {
        name = "Biotic Supplement",
        model = "models/probs_misc/tobbcco_box-1.mdl",
        trash = "supplement_biotic_trash"
    },
    ["supplement_biotic_trash"] = {
        name = "Consumed Biotic Supplement",
        model = "models/probs_misc/tobbcco_box-1_gib1.mdl",
        istrash = true,
    },
    ["supplement_metropolice"] = {
        name = "Metropolice Supplement",
        model = "models/probs_misc/tobccco_box-1.mdl",
        trash = "supplement_metropolice_trash"
    },
    ["supplement_metropolice_trash"] = {
        name = "Consumed Metropolice Supplement",
        model = "models/probs_misc/tobccco_box-1_gib1.mdl",
        istrash = true,
    },
    ["supplement_priority"] = {
        name = "Priority Supplement",
        model = "models/probs_misc/tobdcco_box-1.mdl",
        trash = "supplement_priority_trash"
    },
    ["supplement_priority_trash"] = {
        name = "Consumed Priority Supplement",
        model = "models/probs_misc/tobdcco_box-1_gib1.mdl",
        istrash = true,
    },
    ["ration_biotic"] = {
        name = "Biotic Rations",
        model = "models/weapons/w_packatb.mdl",
        pack = {
            ["supplement_biotic"] = 1,
            ["water_murky"] = 1,
            ["mre_biotic"] = 1,
            ["box_biotic"] = 1
        }
    },
    ["ration_standard"] = {
        name = "Standard Rations",
        model = "models/weapons/w_packatc.mdl",
        pack = {
            ["mre_citizen"] = 1,
            ["water_murky"] = 1,
            ["box_standard"] = 1,
            ["tokens"] = 0, -- 0 or less syncs with config for "ration tokens."
        }
    },
    ["ration_minimal"] = {
        name = "Minimal Rations",
        model = "models/weapons/w_packati.mdl",
        pack = {
            ["box_minimal"] = 1,
            ["water_murky"] = 1
        }
    },
    ["ration_loyalist"] = {
        name = "Loyalist Rations",
        model = "models/weapons/w_packatl.mdl",
        pack = {
            ["supplement_priority"] = 1,
            ["water_union"] = 1,
            ["mre_loyalist"] = 2,
            ["box_loyalist"] = 1,
            ["tokens"] = 15,
        }
    },
    ["ration_metropolice"] = {
        name = "Metropolice Rations",
        model = "models/weapons/w_packatm.mdl",
        pack = {
            ["supplement_metropolice"] = 2,
            ["water_union"] = 1,
            ["mre_metropolice"] = 3,
            ["box_metropolice"] = 1
        }
    },
    ["ration_priority"] = {
        name = "Priority Rations",
        model = "models/weapons/w_packatp.mdl",
        pack = {
            ["supplement_priority"] = 2,
            ["water_union"] = 1,
            ["mre_loyalist"] = 3,
            ["box_priority"] = 1,
            ["tokens"] = 100
        }
    }
}

PLUGIN:AddFoodItemTable(items)