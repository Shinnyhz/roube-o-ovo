--[[
	EconomyService
	Manages coin generation and player income
]]

local EconomyService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local Services
local UpdateConnections = {}

function EconomyService:Initialize(allServices)
	Services = allServices
	print("[EconomyService] Initializing...")
	
	Players.PlayerAdded:Connect(function(player)
		self:StartPlayerIncomeLoop(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:StopPlayerIncomeLoop(player)
	end)
end

function EconomyService:StartPlayerIncomeLoop(player)
	if UpdateConnections[player.UserId] then
		UpdateConnections[player.UserId]:Disconnect()
	end
	
	local lastTick = tick()
	UpdateConnections[player.UserId] = game:GetService("RunService").Heartbeat:Connect(function()
		local now = tick()
		if now - lastTick >= GameConfig.ECONOMY.INCOME_TICK_RATE then
			lastTick = now
			self:ProcessPlayerIncome(player)
		end
	end)
end

function EconomyService:StopPlayerIncomeLoop(player)
	if UpdateConnections[player.UserId] then
		UpdateConnections[player.UserId]:Disconnect()
		UpdateConnections[player.UserId] = nil
	end
end

function EconomyService:ProcessPlayerIncome(player)
	if not Services.CreatureService or not Services.DataService then return end
	
	local income = Services.CreatureService:CalculatePlayerIncome(player.UserId)
	if income > 0 then
		Services.DataService:AddCoins(player, income)
	end
end

return EconomyService
