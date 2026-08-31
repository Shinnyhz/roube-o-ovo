--[[
	EventService
	Manages rare egg events and spawning
]]

local EventService = {}
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))

local Services
local currentEventEgg = nil
local eventActive = false
local eventStartTime = 0

function EventService:Initialize(allServices)
	Services = allServices
	print("[EventService] Initialized")
	self:StartEventLoop()
end

function EventService:StartEventLoop()
	while true do
		wait(GameConfig.EVENT.COOLDOWN)
		self:StartNewEvent()
	end
end

function EventService:StartNewEvent()
	local eventRarities = {"EPIC", "LEGENDARY", "MYTHIC"}
	local randomRarity = eventRarities[math.random(1, #eventRarities)]
	
	currentEventEgg = Services.EggService:CreateEgg(nil, randomRarity, EggConfig.STATES.EVENT)
	currentEventEgg.IsEvent = true
	
	eventActive = true
	eventStartTime = tick()
	
	print("[EventService] Event started: " .. randomRarity .. " egg")
	
	-- Event duration
	wait(GameConfig.EVENT.DURATION)
	
	if currentEventEgg and currentEventEgg.State == EggConfig.STATES.EVENT then
		currentEventEgg.State = EggConfig.STATES.WILD
	end
	
	eventActive = false
	print("[EventService] Event ended")
end

function EventService:GetCurrentEvent()
	if eventActive then
		return currentEventEgg
	end
	return nil
end

function EventService:GetTimeRemaining()
	if eventActive then
		local elapsed = tick() - eventStartTime
		local remaining = GameConfig.EVENT.DURATION - elapsed
		return math.max(0, remaining)
	end
	return 0
end

function EventService:ClaimEventEgg(player)
	if currentEventEgg and currentEventEgg.State == EggConfig.STATES.EVENT then
		currentEventEgg.OwnerUserId = player.UserId
		currentEventEgg.State = EggConfig.STATES.INCUBATING
		eventActive = false
		return true
	end
	return false
end

return EventService
