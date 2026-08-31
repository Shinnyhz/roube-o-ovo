--[[
	PromptController
	Manages interaction prompts
]]

local PromptController = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local activePrompts = {}

function PromptController:Initialize(controllers)
	print("[PromptController] Initialized")
	
	-- Handle proximity prompts
	ProximityPromptService.PromptShown:Connect(function(prompt)
		self:ShowPrompt(prompt)
	end)
	
	ProximityPromptService.PromptHidden:Connect(function(prompt)
		self:HidePrompt(prompt)
	end)
end

-- Create a custom prompt display
function PromptController:ShowPrompt(prompt)
	local gui = Instance.new("BillboardGui")
	gui.Size = UDim2.new(0, 200, 0, 50)
	gui.MaxDistance = 100
	gui.Parent = playerGui
	
	local label = Instance.new("TextLabel")
	label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	label.BackgroundTransparency = 0.5
	label.Size = UDim2.new(1, 0, 1, 0)
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 16
	label.Font = Enum.Font.GothamBold
	label.Text = prompt.ActionText or "Interagir"
	label.Parent = gui
	
	activePrompts[prompt] = gui
end

function PromptController:HidePrompt(prompt)
	if activePrompts[prompt] then
		activePrompts[prompt]:Destroy()
		activePrompts[prompt] = nil
	end
end

-- Show notification
function PromptController:ShowNotification(text, color, duration)
	duration = duration or 3
	color = color or Color3.fromRGB(200, 200, 200)
	
	local notifGui = Instance.new("TextLabel")
	notifGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	notifGui.BackgroundTransparency = 0.2
	notifGui.Size = UDim2.new(0, 300, 0, 50)
	notifGui.Position = UDim2.new(0.5, -150, 0, 100)
	notifGui.TextColor3 = color
	notifGui.TextSize = 16
	notifGui.Font = Enum.Font.Gotham
	notifGui.Text = text
	notifGui.Parent = playerGui
	
	-- Fade out
	local startTime = tick()
	game:GetService("RunService").Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		if elapsed < duration then
			if elapsed > duration - 0.5 then
				notifGui.TextTransparency = (elapsed - (duration - 0.5)) / 0.5
			end
		else
			notifGui:Destroy()
		end
	end)
end

return PromptController
