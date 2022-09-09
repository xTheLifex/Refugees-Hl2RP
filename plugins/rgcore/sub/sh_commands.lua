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

function PLUGIN:GetMaxPlayerCharacter(client)
    return client:GetData("customMaxCharacters", ix.config.Get("maxCharacters", 5))
end