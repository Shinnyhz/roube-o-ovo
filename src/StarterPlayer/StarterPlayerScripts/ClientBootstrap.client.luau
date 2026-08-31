--[[
	ClientBootstrap
	Initializes client-side controllers
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Wait for Rojo sync
while not ReplicatedStorage:FindFirstChild("Shared") do
	wait(0.1)
end

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local Controllers = {}
local ControllersFolder = StarterPlayer:WaitForChild("StarterPlayerScripts"):WaitForChild("Controllers")

-- Initialize controllers
local function InitializeControllers()
	print("[CLIENT] Initializing controllers...")
	
	local controllerOrder = {
		"UIController",
		"FXController",
		"AnimationController",
		"PromptController",
		"BaseMarkerController",
	}
	
	for _, controllerName in ipairs(controllerOrder) do
		local controllerModule = ControllersFolder:WaitForChild(controllerName)
		local controller = require(controllerModule)
		
		if controller.Initialize then
			controller:Initialize(Controllers)
		end
		
		Controllers[controllerName] = controller
		print("[CLIENT] " .. controllerName .. " initialized")
	end
	
	print("[CLIENT] All controllers ready!")
end

-- Dev commands
local function ProcessDevCommands(input)
	if game:GetService("RunService"):IsStudio() then
		local message = input.UserInputString
		
		if message:sub(1, 1) == ";" then
			local command = message:sub(2)
			print("[CLIENT] Dev command: " .. command)
			-- Can add more dev commands here
		end
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		ProcessDevCommands(input)
	end
end)

-- Main initialization
InitializeControllers()

print("[CLIENT] Game started successfully!")

-- Keep script running
while true do
	wait(1)
end
