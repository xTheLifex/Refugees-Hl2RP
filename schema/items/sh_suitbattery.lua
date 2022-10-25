ITEM.name = "Suit Battery"
ITEM.model = Model("models/items/battery.mdl")
ITEM.description = "A battery to restore your suit's armor."
ITEM.category = "Medical"
ITEM.price = 40

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetArmor(math.min(client:Armor() + 20, client:GetMaxArmor()))
	end
}
