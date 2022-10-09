
ITEM.name = "Spam"
ITEM.model = "models/hlvr/food/spam_3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Good ol' spam."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}

function ITEM:PopulateTooltip(tooltip)
    local warning = tooltip:AddRow("warning")
    warning:SetBackgroundColor(Color(255, 0, 0))
    warning:SetText("Any form of non UU-Approved food is disallowed.")
    warning:SetFont("BudgetLabel")
    warning:SetExpensiveShadow(0.5)
    warning:SizeToContents()
end