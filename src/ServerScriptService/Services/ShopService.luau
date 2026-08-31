--[[
	ShopService
	Manages shop transactions
]]

local ShopService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local ShopConfig = require(Shared:WaitForChild("ShopConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))

local Services

function ShopService:Initialize(allServices)
	Services = allServices
	print("[ShopService] Initialized")
end

function ShopService:BuyItem(player, itemId)
	local item = ShopConfig:GetItem(itemId)
	if not item then return false end
	
	local data = Services.DataService:GetPlayerData(player)
	if data.Coins < item.Price then
		return false
	end
	
	-- Remove coins
	if not Services.DataService:RemoveCoins(player, item.Price) then
		return false
	end
	
	-- Handle specific item purchases
	if itemId == "random_egg" then
		local rarity = EggConfig:GenerateRarity()
		local egg = Services.EggService:CreateEgg(player.UserId, rarity, EggConfig.STATES.INCUBATING)
		print("[ShopService] " .. player.Name .. " bought " .. rarity .. " egg")
		return true, egg
	elseif itemId:find("upgrade") then
		local upgradeKey = itemId:upper():gsub("_UPGRADE", "")
		return Services.UpgradeService:PurchaseUpgrade(player, upgradeKey)
	end
	
	return false
end

return ShopService
