--[[
	Main Server Script
	Initializes all services and game loop
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

-- Wait for Rojo sync
while not ReplicatedStorage:FindFirstChild("Shared") do
	wait(0.1)
end

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

-- Service registry
local Services = {}
local ServiceModules = ServerScriptService:WaitForChild("Services")

-- Load all services
local function InitializeServices()
	print("[MAIN] Initializing services...")
	
	local serviceOrder = {
		"DataService",
		"MapService",
		"BaseService",
		"EggService",
		"GuardianService",
		"CreatureService",
		"EconomyService",
		"SpeedService",
		"UpgradeService",
		"ShopService",
		"DiagnosticsService",
	}
	
	for _, serviceName in ipairs(serviceOrder) do
		local serviceModule = ServiceModules:WaitForChild(serviceName)
		local service = require(serviceModule)
		
		if service.Initialize then
			service:Initialize(Services)
		end
		
		Services[serviceName] = service
		print("[MAIN] " .. serviceName .. " initialized")
	end
	
	print("[MAIN] All services ready!")
end

-- Run diagnostics
local function RunDiagnostics()
	if GameConfig.DEV.DIAGNOSTICS_ENABLED then
		local DiagnosticsService = Services.DiagnosticsService
		if DiagnosticsService then
			DiagnosticsService:RunDiagnostics()
		end
	end
end

-- Main initialization
InitializeServices()
RunDiagnostics()

print("[MAIN] Game started successfully!")

-- Keep script running
while true do
	wait(1)
end
