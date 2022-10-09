
ITEM.name = "Clothing Base"
ITEM.model = Model("models/props_c17/paper01.mdl")
ITEM.description = "This item can be worn."

ITEM.bodygroups = {}

ITEM.functions.Wear = {
	OnRun = function(item)
        local client = item.player
        print(client)
        if (IsValid(client) and item.bodygroups) then
            print(#item.bodygroups)
            for k,v in pairs(item.bodygroups) do
                local index = client:FindBodygroupByName(k)
                print(index)
                if (index > -1) then
                    local groups = client:GetData("groups", {})
                    groups[index] = v
                    client:SetData("groups", groups)
                    client:SetBodygroup(k,v or 0)
                end
            end

        end
		return false
	end,

	OnCanRun = function(item)
        local entity = item.entity -- only set if this is function is being ran while the item is in the world
        return !IsValid(entity)
	end
}