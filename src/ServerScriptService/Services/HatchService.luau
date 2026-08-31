--[[
	HatchService
	Manages egg hatching and creature spawning
]]

local HatchService = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local EggConfig = require(Shared:WaitForChild("EggConfig"))
local CreatureConfig = require(Shared:WaitForChild("CreatureConfig"))

local Services
local hatchingEggs = {}

function HatchService:Initialize(allServices)
	Services = allServices
	print("[HatchService] Initialized")
	self:StartHatchLoop()
end

function HatchService:StartHatchLoop()
	while true do
		wait(1)
		self:ProcessHatching()
	end
end

function HatchService:ProcessHatching()
	local eggs = Services.EggService.Eggs or {}
	
	for eggId, egg in pairs(eggs) do
		if egg.State == EggConfig.STATES.INCUBATING and egg.OwnerUserId then
			-- Get incubation time with upgrades
			local player = Players:FindFirstChild(tostring(egg.OwnerUserId))
			if player then
				local rarityConfig = EggConfig:GetRarityConfig(egg.Rarity)
				local baseTime = rarityConfig.IncubationTime
				local upgradeMultiplier = Services.UpgradeService:GetIncubationTimeMultiplier(player)
				local finalTime = baseTime * upgradeMultiplier
				
				egg.RemainingTime = egg.RemainingTime - 1
				
				if egg.RemainingTime <= 0 then
					self:HatchEgg(player, eggId)
				end
			end
		end
	end
end

function HatchService:HatchEgg(player, eggId)
	local egg = Services.EggService:GetEgg(eggId)
	if not egg then return end
	
	-- Create creature
	local creature = Services.CreatureService:HatchEgg(eggId, egg.Rarity, player)
	
	-- Update egg state
	egg.State = EggConfig.STATES.HATCHING
	
	-- Spawn visual creature
	self:SpawnCreatureModel(player, creature)
	
	print("[HatchService] " .. player.Name .. " hatched " .. egg.Rarity .. " creature")
end

function HatchService:SpawnCreatureModel(player, creature)
	local creatureConfig = CreatureConfig:GetCreature(creature.Rarity)
	
	-- Create visual part
	local creaturePart = Instance.new("Part")
	creaturePart.Name = creature.Name
	creaturePart.Shape = Enum.PartType.Ball
	creaturePart.Size = Vector3.new(1, 1, 1) * creatureConfig.Size
	creaturePart.Color = creatureConfig.Color
	creaturePart.Material = Enum.Material.SmoothPlastic
	creaturePart.CanCollide = false
	creaturePart.CanQuery = false
	
	-- Position at player's base
	local playerBase = Services.BaseService:GetPlayerBase(player)
	if playerBase then
		local petPlatform = playerBase:FindFirstChild("PetPlatform")
		if petPlatform then
			creaturePart.CFrame = petPlatform.CFrame + Vector3.new(0, 2, 0)
		end
	end
	
	creaturePart.Parent = Workspace
	
	-- Add label
	local label = Instance.new("BillboardGui")
	label.Size = UDim2.new(0, 100, 0, 30)
	label.MaxDistance = 50
	label.Parent = creaturePart
	
	local text = Instance.new("TextLabel")
	text.BackgroundTransparency = 1
	text.Size = UDim2.new(1, 0, 1, 0)
	text.TextColor3 = creatureConfig.Color
	text.TextSize = 12
	text.Font = Enum.Font.GothamBold
	text.Text = creature.Name .. " +" .. creature.IncomePerSecond .. "/s"
	text.Parent = label
end

return HatchService
