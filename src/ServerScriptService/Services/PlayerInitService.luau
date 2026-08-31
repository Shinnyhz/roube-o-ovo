--[[
	PlayerInitService
	Handles new player setup and starter mechanics
]]

local PlayerInitService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))

local Services

function PlayerInitService:Initialize(allServices)
	Services = allServices
	print("[PlayerInitService] Initialized")
	
	Players.PlayerAdded:Connect(function(player)
		self:SetupNewPlayer(player)
	end)
end

function PlayerInitService:SetupNewPlayer(player)
	wait(1) -- Wait for character to load
	
	if player.Character then
		self:SetupCharacterSpawn(player)
	end
	
	-- Give starter egg if not claimed
	local data = Services.DataService:GetPlayerData(player)
	if not data.StarterClaimed then
		self:GiveStarterEgg(player)
		data.StarterClaimed = true
		Services.DataService:UpdatePlayerData(player, "StarterClaimed", true)
	end
	
	print("[PlayerInitService] Setup complete for " .. player.Name)
end

function PlayerInitService:SetupCharacterSpawn(player)
	local character = player.Character
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end
	
	-- Get player base and spawn at it
	local playerBase = Services.BaseService:GetPlayerBase(player)
	if playerBase then
		local basePivot = Services.BaseService:GetBasePivot(player)
		if basePivot then
			character:PivotTo(basePivot)
		end
	end
	
	-- Set initial speed
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		local speedLevel = Services.DataService:GetPlayerData(player).SpeedLevel or 0
		local walkSpeed = GameConfig.SPAWN.DEFAULT_SPEED + (speedLevel * GameConfig.SPEED.PER_LEVEL_INCREMENT)
		humanoid.WalkSpeed = walkSpeed
	end
end

function PlayerInitService:GiveStarterEgg(player)
	local egg = Services.EggService:CreateEgg(player.UserId, "COMMON", EggConfig.STATES.INCUBATING)
	print("[PlayerInitService] " .. player.Name .. " received starter egg")
end

return PlayerInitService
