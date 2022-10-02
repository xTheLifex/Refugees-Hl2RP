AddCSLuaFile()
ENT.Base = "base_entity"
ENT.Type = "brush"
ENT.areaname = "Area"
ENT.areacolor = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
}
ENT.areatype = "area"
ENT.display = true
ENT.forcearea = false

function ENT:Initialize()
    self:SetSolid(SOLID_BBOX)
end


if (SERVER) then
    local ix = ix or nil

    hook.Add("InitializedPlugins", "ixAreaEntInit", function() 
        timer.Simple(5, function()  -- Wait a bit for everything to be properly loaded.
            for _, v in ipairs(ents.FindByClass("ix_area")) do
                v:Setup()
            end
        end)
    end)
    
    hook.Add("SetupAreaProperties", "ixAreaAddProperties", function()
        ix.area.AddProperty("restricted", ix.type.bool, false)
    end)

    function ENT:KeyValue(key, value)
        if (key  == "areaname") then
            self.areaname = value
        elseif(key == "restricted") then
            self.restricted = tobool(value)
        elseif(key == "areacolor") then
            local values = string.Explode(" ", value)
            local red = tonumber(values[1])
            local green = tonumber(values[2])
            local blue = tonumber(values[3])
            self.areacolor = {
                r = red,
                g = green,
                b = blue,
                a = 255
            }
        elseif(key == "areatype") then
            if (value == 0) then
                self.areatype = "area"
            end
            -- Add more area types here, if you want.
        elseif(key == "display") then
            if (value == 0) then
                self.display = false
            else
                self.display = true
            end
        elseif(key == "forcearea") then
            if (value == 0) then
                self.forcearea = false
            else
                self.forcearea = true
            end
        end
    end

    function ENT:Setup()
        if (self.forcearea) then
            if (ix.area.stored[self.areaname]) then
                ix.area.stored[self.areaname] = nil
            end
        end

        local function SortVector(first, second)
            return Vector(math.min(first.x, second.x), math.min(first.y, second.y), math.min(first.z, second.z)),
                Vector(math.max(first.x, second.x), math.max(first.y, second.y), math.max(first.z, second.z))
        end

        
        local properties = {}
        properties["color"] = self.areacolor
        properties["display"] = self.display
        properties["restricted"] = self.restricted

        local sp, ep = self:GetModelBounds()
        local min, max = SortVector(sp, ep)

        ix.area.Create(self.areaname, self.areatype, min, max, false, properties)
        self:Remove()
    end

end