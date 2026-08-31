--[[
	SpeedService
	Manages speed progression and levels
]]

local SpeedService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local Services

function SpeedService:Initialize(allServices)
	Services = allServices
	print("[SpeedService] Initialized")
end

function SpeedService:GetPlayerWalkSpeed(player)
	local data = Services.DataService:GetPlayerData(player)
	local speedLevel = data.SpeedLevel or 0
	local baseSpeed = GameConfig.SPEED.BASE_WALK_SPEED
	local increment = GameConfig.SPEED.PER_LEVEL_INCREMENT
	
	return baseSpeed + (speedLevel * increment)
end

function SpeedService:AddSpeedXP(player, amount)
	local data = Services.DataService:GetPlayerData(player)
	data.SpeedXP = (data.SpeedXP or 0) + amount
	
	while data.SpeedXP >= GameConfig.SPEED.XP_TO_LEVEL and data.SpeedLevel < GameConfig.SPEED.MAX_LEVEL do
		data.SpeedXP = data.SpeedXP - GameConfig.SPEED.XP_TO_LEVEL
		data.SpeedLevel = data.SpeedLevel + 1
		print("[SpeedService] " .. player.Name .. " reached Speed level " .. data.SpeedLevel)
	end
	
	Services.DataService:UpdatePlayerData(player, "SpeedLevel", data.SpeedLevel)
	Services.DataService:UpdatePlayerData(player, "SpeedXP", data.SpeedXP)
end

function SpeedService:CanPlayerStealFromSpot(player, spotKey)
	local spot = require(ReplicatedStorage.Shared.AreaConfig):GetSpot(spotKey)
	if not spot then return false end
	
	local data = Services.DataService:GetPlayerData(player)
	return data.SpeedLevel >= spot.SpeedRequired
end

return SpeedService
