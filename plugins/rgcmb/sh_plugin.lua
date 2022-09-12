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
        
        local players = player.GetAll()
        for _, p in ipairs(players) do
            p:AddCombineDisplayMessage(msg, color)
        end
    end)
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

ix.util.Include("sub/sh_assistant.lua")
