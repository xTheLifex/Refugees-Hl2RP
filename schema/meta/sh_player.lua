local playerMeta = FindMetaTable("Player")

function playerMeta:IsCombine()
	local faction = self:Team()
	return faction == FACTION_MPF or faction == FACTION_OTA
end

function playerMeta:IsDispatch()
	local name = self:Name()
	local faction = self:Team()

	for k, v in ipairs({ "SCN", "DISP" }) do
		if (Schema:IsCombineRank(name, v)) then
			return true
		end
	end


	return false
end
