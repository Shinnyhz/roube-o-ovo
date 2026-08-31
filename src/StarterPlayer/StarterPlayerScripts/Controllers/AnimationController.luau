--[[
	AnimationController
	Manages character animations and idle behavior
]]

local AnimationController = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character
local humanoid
local rootPart

function AnimationController:Initialize(controllers)
	print("[AnimationController] Initialized")
	
	if player.Character then
		self:SetupCharacter(player.Character)
	end
	
	player.CharacterAdded:Connect(function(newCharacter)
		self:SetupCharacter(newCharacter)
	end)
end

function AnimationController:SetupCharacter(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	
	print("[AnimationController] Character setup complete")
end

-- Play running animation
function AnimationController:PlayRunning()
	if humanoid and humanoid.MoveSpeed > 0 then
		-- Native Roblox running animation plays automatically
	end
end

-- Apply idle animation
function AnimationController:PlayIdle()
	if humanoid then
		humanoid.Parent:PivotTo(rootPart.CFrame)
	end
end

-- Carry animation state
function AnimationController:SetCarryState(isCarrying)
	if character then
		character:SetAttribute("IsCarrying", isCarrying)
	end
end

return AnimationController
