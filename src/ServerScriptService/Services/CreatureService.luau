--[[
	CreatureService
	Manages pet creatures and hatching
]]

local CreatureService = {}
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local CreatureConfig = require(Shared:WaitForChild("CreatureConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))

local Creatures = {}
local CreatureCounter = 0

function CreatureService:Initialize()
	print("[CreatureService] Initialized")
end

function CreatureService:GenerateCreatureId()
	CreatureCounter = CreatureCounter + 1
	return "creature_" .. tostring(CreatureCounter)
end

function CreatureService:HatchEgg(eggId, rarity, player)
	local creatureId = self:GenerateCreatureId()
	local creatureConfig = CreatureConfig:GetCreature(rarity)
	local rarityConfig = EggConfig:GetRarityConfig(rarity)
	
	local creature = {
		Id = creatureId,
		Rarity = rarity,
		EggId = eggId,
		OwnerUserId = player.UserId,
		Name = creatureConfig.Name,
		Color = creatureConfig.Color,
		Size = creatureConfig.Size,
		IncomePerSecond = rarityConfig.IncomePerSecond,
		HatchedAt = tick(),
	}
	
	Creatures[creatureId] = creature
	return creature
end

function CreatureService:GetCreature(creatureId)
	return Creatures[creatureId]
end

function CreatureService:GetPlayerCreatures(userId)
	local playerCreatures = {}
	for creatureId, creature in pairs(Creatures) do
		if creature.OwnerUserId == userId then
			table.insert(playerCreatures, creature)
		end
	end
	return playerCreatures
end

function CreatureService:CalculatePlayerIncome(userId)
	local creatures = self:GetPlayerCreatures(userId)
	local totalIncome = 0
	
	for _, creature in pairs(creatures) do
		totalIncome = totalIncome + creature.IncomePerSecond
	end
	
	return totalIncome
end

return CreatureService
