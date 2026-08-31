--[[
	BaseMarkerController
	Manages visual indicators for bases and important locations
]]

local BaseMarkerController = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local markers = {}

function BaseMarkerController:Initialize(controllers)
	print("[BaseMarkerController] Initialized")
	self:CreateBaseMarkers()
end

-- Create visual markers for bases
function BaseMarkerController:CreateBaseMarkers()
	local basesFolder = Workspace:FindFirstChild("Bases")
	if not basesFolder then return end
	
	for _, baseFolder in pairs(basesFolder:GetChildren()) do
		if baseFolder:IsA("Folder") then
			local platform = baseFolder:FindFirstChild("Platform")
			if platform then
				-- Create a marker above each base
				local marker = Instance.new("Part")
				marker.Name = "BaseMarker"
				marker.Shape = Enum.PartType.Cylinder
				marker.Size = Vector3.new(1, 0.1, 12)
				marker.Color = Color3.fromRGB(100, 200, 100)
				marker.Material = Enum.Material.Neon
				marker.CanCollide = false
				marker.CanQuery = false
				marker.Transparency = 0.5
				
				local baseIndex = baseFolder:GetAttribute("BaseIndex") or 1
				local baseX = baseFolder:GetAttribute("X") or 0
				local baseY = baseFolder:GetAttribute("Y") or 100
				local baseZ = baseFolder:GetAttribute("Z") or 0
				
				marker.CFrame = CFrame.new(baseX, baseY + 15, baseZ)
				marker.Parent = baseFolder
				
				-- Add label
				local label = Instance.new("BillboardGui")
				label.Size = UDim2.new(0, 100, 0, 30)
				label.MaxDistance = 150
				label.Parent = marker
				
				local text = Instance.new("TextLabel")
				text.BackgroundTransparency = 1
				text.Size = UDim2.new(1, 0, 1, 0)
				text.TextColor3 = Color3.fromRGB(100, 200, 100)
				text.TextSize = 14
				text.Font = Enum.Font.GothamBold
				text.Text = "Base " .. baseIndex
				text.Parent = label
				
				table.insert(markers, marker)
			end
		end
	end
end

return BaseMarkerController
