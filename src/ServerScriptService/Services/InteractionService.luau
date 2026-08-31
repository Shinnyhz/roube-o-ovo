--[[
	InteractionService
	Handles player interactions with eggs, bases, and NPCs
]]

local InteractionService = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local EggConfig = require(Shared:WaitForChild("EggConfig"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local Services
local playerCarryingEgg = {}

function InteractionService:Initialize(allServices)
	Services = allServices
	print("[InteractionService] Initialized")
end

function InteractionService:CanPlayerStealEgg(player, egg)
	-- Validate egg ownership
	if egg.OwnerUserId == player.UserId then
		return false, "Seu próprio ovo"
	end
	
	-- Validate egg is incubating
	if egg.State ~= EggConfig.STATES.INCUBATING then
		return false, "Ovo não está incubando"
	end
	
	-- Validate distance
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local distance = (player.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 0)).Magnitude
		if distance > 30 then
			return false, "Muito longe"
		end
	end
	
	-- Validate player not already carrying
	if playerCarryingEgg[player.UserId] then
		return false, "Já está carregando um ovo"
	end
	
	return true
end

function InteractionService:StealEgg(player, egg)
	if not self:CanPlayerStealEgg(player, egg) then
		return false
	end
	
	-- Update egg state
	egg.CarrierUserId = player.UserId
	egg.State = EggConfig.STATES.CARRIED
	playerCarryingEgg[player.UserId] = egg.Id
	
	print("[InteractionService] " .. player.Name .. " stole egg " .. egg.Id)
	return true
end

function InteractionService:DropEgg(player)
	local eggId = playerCarryingEgg[player.UserId]
	if not eggId then return false end
	
	local egg = Services.EggService:GetEgg(eggId)
	if egg then
		egg.CarrierUserId = nil
		egg.State = EggConfig.STATES.DROPPED
		egg.DropTime = tick()
		playerCarryingEgg[player.UserId] = nil
		print("[InteractionService] " .. player.Name .. " dropped egg")
		return true
	end
	return false
end

function InteractionService:DeliverEgg(player)
	local eggId = playerCarryingEgg[player.UserId]
	if not eggId then return false end
	
	local egg = Services.EggService:GetEgg(eggId)
	if not egg then return false end
	
	-- Validate player is at their base
	local playerBase = Services.BaseService:GetPlayerBase(player)
	if not playerBase then return false end
	
	local deliveryZone = playerBase:FindFirstChild("DeliveryZone")
	if not deliveryZone then return false end
	
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local distance = (player.Character.HumanoidRootPart.Position - deliveryZone.Position).Magnitude
		if distance > 10 then
			return false
		end
	end
	
	-- Transfer egg to new owner
	egg.OwnerUserId = player.UserId
	egg.CarrierUserId = nil
	egg.State = EggConfig.STATES.INCUBATING
	playerCarryingEgg[player.UserId] = nil
	
	print("[InteractionService] " .. player.Name .. " delivered egg")
	return true
end

function InteractionService:GetPlayerCarryingEgg(player)
	return playerCarryingEgg[player.UserId]
end

return InteractionService
