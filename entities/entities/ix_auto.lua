AddCSLuaFile()
ENT.Base = "base_entity"
ENT.Type = "point"

if (SERVER) then
    local ix = ix or nil

    hook.Add("InitializedPlugins", "ixAutoExecute", function() 
        timer.Simple(5, function()  -- Wait a bit for everything to be properly loaded.
            for _, v in ipairs(ents.FindByClass("ix_auto")) do
                v:TriggerOutput("OnPluginsLoaded", v)
            end
        end)
    end)

    hook.Add("PostCleanupMap", "ixAutoCleanup", function() 
        timer.Simple(5, function()  -- Wait a bit for everything to be properly loaded.
            for _, v in ipairs(ents.FindByClass("ix_auto")) do
                v:TriggerOutput("OnPluginsLoaded", v)
            end
        end)
    end)
    
    function ENT:KeyValue(key, value)
        if(key == "OnPluginsLoaded") then
            self:StoreOutput(key, value)
        end
    end
end