PLUGIN.name = "Refugees - Combine Module"
PLUGIN.description = "The Refugees Hl2RP Combine module, contains features shared between OTA and CP."
PLUGIN.author = "TheLife"
PLUGIN.maxLength = 512

ix.util.Include("sub/sh_voices.lua")
ix.util.Include("sub/sh_assistant.lua")
ix.util.Include("sub/sh_commands.lua")

if (SERVER) then
    util.AddNetworkString("RGcmbVM") -- RG COMBINE VISOR MESSAGE

    
    function PLUGIN:CanPlayerInteractEntity(client, entity, option, data)
        local combine_ents = {
            ["item_healthcharger"] = true,
            ["item_suitcharger"] = true,
            ["sim_fphys_combineapc_armed"] = true
        }

        if (combine_ents[entity:GetClass()] == true) then
            if (!client:IsCombine()) then return false end
        end
    end
    
    net.Receive("RGcmbVM", function (len, ply)
        local msg = net.ReadString()
        local color = net.ReadColor()
        if (!msg or msg == "") then return end
        
        local self = ix.plugin.Get("rgcmb")
        if (self) then
            self:VisorMessage(msg, color)
        end
    end)

    function PLUGIN:VisorMessage(message, color)
        local players = player.GetAll()
        local sounds = {"buttons/combine_button3.wav", "buttons/combine_button2.wav", "buttons/combine_button1.wav"}
        local snd = sounds[math.random(1,#sounds)]
        for _, p in ipairs(players) do
            p:AddCombineDisplayMessage(message, color)
            p:EmitSound(snd, 50, 100, 0.5, CHAN_ITEM, 0, 1)
        end
    end
end

if (CLIENT) then
    function PLUGIN:VisorMessage(message, color) 
        local color = color or Color(255, 255, 255)
        net.Start("RGcmbVM")
        net.WriteString(message)
        net.WriteColor(color)
        net.SendToServer()
    end

    function PLUGIN:ShouldShowPlayerOnScoreboard(client)
        local char = client:GetCharacter()
        if (char) then
            if (char:GetFaction() == FACTION_OTA) then return false end
        end
    end
end

ix.config.Add("shoveTime", 20, "How long should a character be unconscious after being knocked out?", nil, {
    data = {min = 5, max = 60},
})

ix.command.Add("shove", {
    description = "Knock someone out.",
    OnRun = function(self, ply)
        if not ( ply:Team() == FACTION_OTA ) then
            return false, "You need to be a Overwatch Soldier to run this command."
        end

        local ent = ply:GetEyeTraceNoCursor().Entity
        local target

        if ( ent:IsPlayer() ) then 
            target = ent
        else
            return false, "You must be looking at someone!"     
        end

        if ( target ) and ( target:GetPos():Distance(ply:GetPos()) >= 50 ) then
            return false, "You need to be close to your target!"
        end 

        ply:ForceSequence("melee_gunhit")
        timer.Simple(0.3, function()
            target:SetVelocity(ply:GetAimVector() * 300)
        end)
        timer.Simple(0.4, function()
            ply:EmitSound("physics/body/body_medium_impact_hard6.wav")
            target:SetRagdolled(true, ix.config.Get("shoveTime", 20))
        end)
    end,
})

