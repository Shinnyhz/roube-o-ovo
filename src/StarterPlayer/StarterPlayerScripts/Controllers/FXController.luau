--[[
	FXController
	Manages visual effects and animations
]]

local FXController = {}
local Workspace = game:GetService("Workspace")

function FXController:Initialize(controllers)
	print("[FXController] Initialized")
end

-- Create floating number effect
function FXController:CreateFloatingNumber(position, text, color)
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Size = UDim2.new(0, 100, 0, 40)
	billboardGui.MaxDistance = 100
	billboardGui.Parent = Workspace
	
	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 20
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Text = text
	textLabel.Parent = billboardGui
	
	billboardGui.Adornee = Workspace:FindFirstChildOfClass("Part") or Workspace
	
	-- Animate up and fade
	local startTime = tick()
	game:GetService("RunService").Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		if elapsed < 1 then
			billboardGui.StudsOffset = billboardGui.StudsOffset + Vector3.new(0, 0.1, 0)
			textLabel.TextTransparency = elapsed
		else
			billboardGui:Destroy()
		end
	end)
end

-- Create egg hatch effect
function FXController:CreateHatchEffect(position)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(2, 2, 2)
	part.Color = Color3.fromRGB(255, 200, 0)
	part.CanCollide = false
	part.CFrame = CFrame.new(position)
	part.Parent = Workspace
	
	-- Scale animation
	local startTime = tick()
	game:GetService("RunService").Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		if elapsed < 0.3 then
			part.Size = Vector3.new(2 + elapsed * 3, 2 + elapsed * 3, 2 + elapsed * 3)
			part.Transparency = elapsed / 0.3
		else
			part:Destroy()
		end
	end)
end

-- Create steal effect
function FXController:CreateStealEffect(position)
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Block
	part.Size = Vector3.new(1, 1, 1)
	part.Color = Color3.fromRGB(255, 100, 100)
	part.CanCollide = false
	part.CFrame = CFrame.new(position)
	part.Parent = Workspace
	
	local startTime = tick()
	game:GetService("RunService").Heartbeat:Connect(function()
		local elapsed = tick() - startTime
		if elapsed < 0.5 then
			part.Size = Vector3.new(1 - elapsed * 2, 1 - elapsed * 2, 1 - elapsed * 2)
			part.Transparency = elapsed / 0.5
		else
			part:Destroy()
		end
	end)
end

return FXController
