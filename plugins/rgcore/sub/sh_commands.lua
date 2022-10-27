do
    ix.command.Add("GetMaxCharacters", {
        description = "Gets the maximum amount of characters a certain player can have.",
        adminOnly = true,
        arguments = {
            ix.type.player
        },
        OnRun = function(self, client, target) 
            return "Target has " .. target:GetData("customMaxCharacters", ix.config.Get("maxCharacters", 5)) .. " max characters."
        end
    })
end

do
    ix.command.Add("Gesture", {
        description = "Plays a gesture.",
        arguments = {
            ix.type.string
        },
        OnRun = function(self, client, str) 
            if (!SERVER) then return end
            local rgcore = ix.plugin.Get("rgcore")
            if (!rgcore) then return end

            local gestures = {}
            gestures["look"] = {"g_look"}
            gestures["looksmall"] = {"g_look_small"}
            gestures["comehere"] = {"g_lookatthis"}
            gestures["punct"] = {"g_medpuct_mid"}
            gestures["punct2"] = {"g_medurgent_mid"}
            gestures["punct3"] = {"g_puncuate"}
            gestures["righthand"] = {"g_righthandheavy"}
            gestures["rightpointback"] = {"g_righthandmotion"}
            gestures["rightpoint"] = {"g_righthandpoint"}
            gestures["righthandroll"] = {"g_righthandroll"}
            gestures["nowaybig"] = {"g_noway_big"}
            gestures["noway"] = {"g_noway_small"}
            gestures["fear"] = {"fear_reaction_gesture"}
            gestures["what"] = {"g_what"}
            gestures["shrug"] = {"g_shrug"}
            -- TODO: Finish
            local tab = gestures[str]
            if (!tab) then return end
            local sequence = tab[math.random(1,#tab)]
            if (!sequence) then return end
            gesture = client:LookupSequence(sequence)
            rgcore:DoPlayerGesture(client, gesture, GESTURE_SLOT_VCD, false)

        end
    })
end

do
    ix.command.Add("SetMaxCharacters", {
        description = "Sets the maximum amount of characters a certain player can have.",
        superAdminOnly = true,
        arguments = {
            ix.type.player, ix.type.number
        },
        OnRun = function(self, client, target, amount) 
            amount = math.Clamp(amount, 1, 15)
            target:SetData("customMaxCharacters", amount)
            return "Target now has " .. target:GetData("customMaxCharacters", ix.config.Get("maxCharacters", 5)) .. " max characters."
        end
    })
end

do
    ix.command.Add("SetHostile", {
        description = "Sets someone as hostile for CP NPCs.",
        superAdminOnly = true,
        arguments = {
            ix.type.player
        },
        OnRun = function(self, client, target) 
            local rgcore = ix.plugin.Get("rgcore")
            rgcore:FlagAsResistance(target, 2000)
        end
    })
end

do
    ix.command.Add("SetFriendly", {
        description = "Sets someone as hostile for CP NPCs.",
        superAdminOnly = true,
        arguments = {
            ix.type.player
        },
        OnRun = function(self, client, target) 
            local rgcore = ix.plugin.Get("rgcore")
            rgcore:FlagAsResistance(target, 0)
        end
    })
end



function PLUGIN:GetMaxPlayerCharacter(client)
    return client:GetData("customMaxCharacters", ix.config.Get("maxCharacters", 5))
end

