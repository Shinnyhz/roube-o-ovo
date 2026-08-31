--[[
	UpgradeService
	Manages player upgrades and their effects
]]

local UpgradeService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local UpgradeConfig = require(Shared:WaitForChild("UpgradeConfig"))

local Services

function UpgradeService:Initialize(allServices)
	Services = allServices
	print("[UpgradeService] Initialized")
end

function UpgradeService:GetUpgradeLevel(player, upgradeKey)
	local data = Services.DataService:GetPlayerData(player)
	local levelKey = upgradeKey:lower() .. "Level"
	return data[levelKey] or 0
end

function UpgradeService:CanUpgrade(player, upgradeKey)
	local upgrade = UpgradeConfig:GetUpgrade(upgradeKey)
	if not upgrade then return false end
	
	local currentLevel = self:GetUpgradeLevel(player, upgradeKey)
	if currentLevel >= upgrade.MaxLevel then return false end
	
	local cost = UpgradeConfig:GetUpgradeCost(upgradeKey, currentLevel + 1)
	local data = Services.DataService:GetPlayerData(player)
	
	return data.Coins >= cost
end

function UpgradeService:PurchaseUpgrade(player, upgradeKey)
	if not self:CanUpgrade(player, upgradeKey) then
		return false
	end
	
	local upgrade = UpgradeConfig:GetUpgrade(upgradeKey)
	local currentLevel = self:GetUpgradeLevel(player, upgradeKey)
	local cost = UpgradeConfig:GetUpgradeCost(upgradeKey, currentLevel + 1)
	
	if Services.DataService:RemoveCoins(player, cost) then
		local levelKey = upgradeKey:lower() .. "Level"
		local data = Services.DataService:GetPlayerData(player)
		data[levelKey] = currentLevel + 1
		Services.DataService:UpdatePlayerData(player, levelKey, data[levelKey])
		print("[UpgradeService] " .. player.Name .. " upgraded " .. upgradeKey .. " to level " .. data[levelKey])
		return true
	end
	
	return false
end

function UpgradeService:GetIncubationTimeMultiplier(player)
	local level = self:GetUpgradeLevel(player, "INCUBATOR")
	local upgrade = UpgradeConfig:GetUpgrade("INCUBATOR")
	if level > 0 then
		return upgrade.Levels[level].TimeMultiplier
	end
	return 1.0
end

return UpgradeService
