
ITEM.name = "Dessicated Sustenance Bar"
ITEM.model = "models/hlvr/food/ration_bar.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A completely dry bar made out of some king of gel. Because it tastes like water, it has no taste at all."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}
