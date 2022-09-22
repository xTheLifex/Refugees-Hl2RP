do
    ix.command.Add("VisorMessage", {
        description = "Sends a message through combine visor.",
        adminOnly = true,
        arguments = {
            ix.type.text
        },
        OnRun = function(self, client, message) 
            if (!client:IsCombine()) then return "You must be a part of the Combine to do this!" end
            local rgcmb = ix.plugin.Get("rgcmb")
            rgcmb:VisorMessage(client:GetName() .. ": " .. message .. " ::>", Color(93,122,175))
            return
        end
    })
end
