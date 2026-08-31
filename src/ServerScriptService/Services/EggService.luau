--[[
	EggService
	Manages egg creation, state, and lifecycle
]]

local EggService = {}
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local EggConfig = require(Shared:WaitForChild("EggConfig"))
local AreaConfig = require(Shared:WaitForChild("AreaConfig"))

local Eggs = {}
local EggCounter = 0
local EggFolder

function EggService:Initialize()
	print("[EggService] Initializing...")
	
	local eggsFolder = Workspace:FindFirstChild("Eggs")
	if not eggsFolder then
		eggsFolder = Instance.new("Folder")
		eggsFolder.Name = "Eggs"
		eggsFolder.Parent = Workspace
	end
	EggFolder = eggsFolder
end

function EggService:GenerateEggId()
	EggCounter = EggCounter + 1
	return "egg_" .. tostring(EggCounter)
end

function EggService:CreateEgg(ownerUserId, rarity, state, areaKey)
	local eggId = self:GenerateEggId()
	local rarityConfig = EggConfig:GetRarityConfig(rarity)
	
	local egg = {
		Id = eggId,
		Rarity = rarity,
		OwnerUserId = ownerUserId,
		CarrierUserId = nil,
		State = state or EggConfig.STATES.CREATED,
		RemainingTime = rarityConfig.IncubationTime,
		AreaKey = areaKey,
		IsEvent = false,
		OriginalOwnerUserId = ownerUserId,
		CreatedAt = tick(),
	}
	
	Eggs[eggId] = egg
	return egg
end

function EggService:GetEgg(eggId)
	return Eggs[eggId]
end

function EggService:UpdateEggState(eggId, newState)
	local egg = self:GetEgg(eggId)
	if egg then
		egg.State = newState
		return true
	end
	return false
end

function EggService:TransferEgg(eggId, fromUserId, toUserId)
	local egg = self:GetEgg(eggId)
	if egg and egg.OwnerUserId == fromUserId then
		egg.OwnerUserId = toUserId
		egg.State = EggConfig.STATES.INCUBATING
		return true
	end
	return false
end

function EggService:SetEggCarrier(eggId, carrierUserId)
	local egg = self:GetEgg(eggId)
	if egg then
		egg.CarrierUserId = carrierUserId
		egg.State = EggConfig.STATES.CARRIED
		return true
	end
	return false
end

function EggService:DropEgg(eggId)
	local egg = self:GetEgg(eggId)
	if egg then
		egg.CarrierUserId = nil
		egg.State = EggConfig.STATES.DROPPED
		egg.DropTime = tick()
		return true
	end
	return false
end

function EggService:GetPlayerEggs(userId)
	local playerEggs = {}
	for eggId, egg in pairs(Eggs) do
		if egg.OwnerUserId == userId then
			table.insert(playerEggs, egg)
		end
	end
	return playerEggs
end

return EggService
