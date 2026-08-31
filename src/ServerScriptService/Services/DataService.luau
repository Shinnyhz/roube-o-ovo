--[[
	DataService
	Handles DataStore and player data persistence
]]

local DataService = {}
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

-- In-memory cache for temporary data
local PlayerData = {}

local function CreateDefaultPlayerData()
	return {
		Coins = GameConfig.ECONOMY.STARTER_COINS,
		Pets = {},
		SpeedLevel = 0,
		SpeedXP = 0,
		IncubatorLevel = 0,
		BarrierLevel = 0,
		AlarmLevel = 0,
		ShockLevel = 0,
		StarterClaimed = false,
		LastSave = tick(),
	}
end

function DataService:Initialize()
	print("[DataService] Initialized")
	
	-- Handle player join
	Players.PlayerAdded:Connect(function(player)
		self:LoadPlayerData(player)
	end)
	
	-- Handle player leave
	Players.PlayerRemoving:Connect(function(player)
		self:SavePlayerData(player)
		PlayerData[player.UserId] = nil
	end)
end

function DataService:LoadPlayerData(player)
	local defaultData = CreateDefaultPlayerData()
	
	if GameConfig.DATASTORE.ENABLE_IN_STUDIO and game:GetService("RunService"):IsStudio() then
		PlayerData[player.UserId] = defaultData
		return
	end
	
	-- In published game, load from DataStore
	local success, data = pcall(function()
		local dataStore = DataStoreService:GetDataStore("PlayerData")
		return dataStore:GetAsync(player.UserId)
	end)
	
	if success and data then
		PlayerData[player.UserId] = data
	else
		PlayerData[player.UserId] = defaultData
	end
	
	print("[DataService] Loaded data for " .. player.Name)
end

function DataService:SavePlayerData(player)
	if not GameConfig.DATASTORE.ENABLE_IN_STUDIO and game:GetService("RunService"):IsStudio() then
		return
	end
	
	local data = PlayerData[player.UserId]
	if not data then return end
	
	data.LastSave = tick()
	
	local success = pcall(function()
		local dataStore = DataStoreService:GetDataStore("PlayerData")
		dataStore:SetAsync(player.UserId, data)
	end)
	
	if success then
		print("[DataService] Saved data for player " .. player.Name)
	end
end

function DataService:GetPlayerData(player)
	return PlayerData[player.UserId] or CreateDefaultPlayerData()
end

function DataService:UpdatePlayerData(player, key, value)
	local data = self:GetPlayerData(player)
	data[key] = value
	PlayerData[player.UserId] = data
end

function DataService:AddCoins(player, amount)
	local data = self:GetPlayerData(player)
	data.Coins = data.Coins + amount
	PlayerData[player.UserId] = data
end

function DataService:RemoveCoins(player, amount)
	local data = self:GetPlayerData(player)
	if data.Coins >= amount then
		data.Coins = data.Coins - amount
		PlayerData[player.UserId] = data
		return true
	end
	return false
end

return DataService
