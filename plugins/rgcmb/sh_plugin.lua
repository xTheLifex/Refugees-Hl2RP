PLUGIN.name = "Refugees - Combine Module"
PLUGIN.description = "The Refugees Hl2RP Combine module, contains features shared between OTA and CP."
PLUGIN.author = "TheLife"
PLUGIN.maxLength = 512

if (SERVER) then
    util.AddNetworkString("RGcmbVM") -- RG COMBINE VISOR MESSAGE

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
end

ix.util.Include("sub/sh_voices.lua")
ix.util.Include("sub/sh_assistant.lua")
ix.util.Include("sub/sh_commands.lua")
