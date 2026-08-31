--[[
	InteractionPrompts
	Client-side interaction system
]]

local InteractionPrompts = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remoteFolder = ReplicatedStorage:WaitForChild("Remotes")

local nearbyEggs = {}
local nearbyNPCs = {}
local character
local humanoidRootPart

function InteractionPrompts:Initialize(controllers)
	print("[InteractionPrompts] Initialized")
	
	if player.Character then
		self:SetupCharacter(player.Character, controllers)
	end
	
	player.CharacterAdded:Connect(function(newCharacter)
		self:SetupCharacter(newCharacter, controllers)
	end)
end

function InteractionPrompts:SetupCharacter(newCharacter, controllers)
	character = newCharacter
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	
	self:StartProximityDetection(controllers)
end

function InteractionPrompts:StartProximityDetection(controllers)
	local updateInterval = 0.5
	local lastUpdate = tick()
	
	game:GetService("RunService").Heartbeat:Connect(function()
		local now = tick()
		if now - lastUpdate >= updateInterval then
			lastUpdate = now
			self:UpdateNearbyObjects(controllers)
		end
	end)
end

function InteractionPrompts:UpdateNearbyObjects(controllers)
	if not humanoidRootPart then return end
	
	local playerPos = humanoidRootPart.Position
	local detectionRange = 50
	
	-- Check for nearby NPCs
	local shopFolder = Workspace:FindFirstChild("Shop")
	if shopFolder then
		local shopStand = shopFolder:FindFirstChild("ShopStand")
		if shopStand then
			local distance = (shopStand.Position - playerPos).Magnitude
			if distance < detectionRange then
				self:ShowShopPrompt(controllers)
			end
		end
	end
	
	local trainingFolder = Workspace:FindFirstChild("SpeedTraining")
	if trainingFolder then
		local treadmill = trainingFolder:FindFirstChild("Treadmill")
		if treadmill then
			local distance = (treadmill.Position - playerPos).Magnitude
			if distance < detectionRange then
				self:ShowTrainingPrompt(controllers)
			end
		end
	end
end

function InteractionPrompts:ShowShopPrompt(controllers)
	-- Show shop interaction prompt
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
			controllers.UIController:ShowShop()
		end
	end)
end

function InteractionPrompts:ShowTrainingPrompt(controllers)
	-- Show training interaction prompt
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
			self:StartTraining(controllers)
		end
	end)
end

function InteractionPrompts:StartTraining(controllers)
	print("[InteractionPrompts] Training started")
	controllers.PromptController:ShowNotification("💪 TREINAMENTO INICIADO!", Color3.fromRGB(100, 200, 100), 2)
end

return InteractionPrompts
