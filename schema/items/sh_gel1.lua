
ITEM.name = "Geletanized Calorie Paste"
ITEM.model = "models/hlvr/food/biscuits_box_1_combine.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A box filled with some kind of gel. Tastes like lukewarm hotdog water."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}
