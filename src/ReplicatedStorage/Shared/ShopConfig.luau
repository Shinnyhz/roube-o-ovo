--[[
	ShopConfig
	Shop items and pricing
]]

local ShopConfig = {}

ShopConfig.SHOP_ITEMS = {
	{
		Id = "random_egg",
		Name = "Ovo Aleatório",
		Description = "Compre um ovo com raridade aleatória",
		Price = 300,
		Icon = "📦",
	},
	{
		Id = "incubator_upgrade",
		Name = "Upgrade Incubadora",
		Description = "Melhore sua incubadora",
		Price = 1000,
		Icon = "🔥",
	},
	{
		Id = "barrier_upgrade",
		Name = "Upgrade Barreira",
		Description = "Fortaleça suas defesas",
		Price = 1500,
		Icon = "🛡️",
	},
	{
		Id = "alarm_upgrade",
		Name = "Upgrade Alarme",
		Description = "Melhore seu sistema de alerta",
		Price = 800,
		Icon = "🔔",
	},
	{
		Id = "shock_upgrade",
		Name = "Upgrade Ninho Elétrico",
		Description = "Aumente poder elétrico",
		Price = 1200,
		Icon = "⚡",
	},
}

function ShopConfig:GetItem(itemId)
	for _, item in pairs(self.SHOP_ITEMS) do
		if item.Id == itemId then
			return item
		end
	end
	return nil
end

return ShopConfig
