--[[
	GuardianMovementService
	Advanced guardian pathfinding and pursuit logic
]]

local GuardianMovementService = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local RunService = game:GetService("RunService")
local guardianModels = {}

function GuardianMovementService:Initialize(services)
	print("[GuardianMovementService] Initializing...")
	self:CreateGuardianModels()
	self:StartMovementLoop()
end

function GuardianMovementService:CreateGuardianModels()
	local guardiansFolder = Workspace:FindFirstChild("Guardians")
	if not guardiansFolder then
		guardiansFolder = Instance.new("Folder")
		guardiansFolder.Name = "Guardians"
		guardiansFolder.Parent = Workspace
	end
	
	local guardianConfigs = {
		{ Key = "Area1_Meadow_Guardian", Name = "Galinha Brava", X = -20, Z = -130, Color = Color3.fromRGB(200, 100, 50) },
		{ Key = "Area1_Lake_Guardian", Name = "Sapo", X = 20, Z = -130, Color = Color3.fromRGB(100, 200, 100) },
		{ Key = "Area2_Desert_Guardian", Name = "Escorpião", X = -20, Z = -270, Color = Color3.fromRGB(200, 150, 50) },
		{ Key = "Area2_Glacier_Guardian", Name = "Golem de Gelo", X = 20, Z = -270, Color = Color3.fromRGB(150, 200, 255) },
		{ Key = "Area3_Volcano_Guardian", Name = "Lagarto Magma", X = -20, Z = -400, Color = Color3.fromRGB(200, 50, 0) },
		{ Key = "Area3_Celestial_Guardian", Name = "Criatura Astral", X = 20, Z = -400, Color = Color3.fromRGB(150, 100, 200) },
	}
	
	for _, config in pairs(guardianConfigs) do
		local guardian = Instance.new("Part")
		guardian.Name = config.Name
		guardian.Shape = Enum.PartType.Block
		guardian.Size = Vector3.new(2, 3, 2)
		guardian.Color = config.Color
		guardian.Material = Enum.Material.SmoothPlastic
		guardian.CanCollide = true
		guardian.CanQuery = true
		guardian.CanTouch = true
		guardian.CFrame = CFrame.new(config.X, 105, config.Z)
		guardian.TopSurface = Enum.SurfaceType.Smooth
		guardian.BottomSurface = Enum.SurfaceType.Smooth
		guardian.Parent = guardiansFolder
		
		-- Add humanoid for animations
		local humanoid = Instance.new("Humanoid")
		humanoid.Parent = guardian
		
		-- Store data
		guardian:SetAttribute("GuardianKey", config.Key)
		guardian:SetAttribute("State", "Idle")
		guardian:SetAttribute("TargetPlayer", nil)
		guardian:SetAttribute("HomePivot", CFrame.new(config.X, 105, config.Z))
		
		guardianModels[config.Key] = guardian
	end
end

function GuardianMovementService:StartMovementLoop()
	RunService.Heartbeat:Connect(function()
		for guardianKey, guardian in pairs(guardianModels) do
			if guardian and guardian.Parent then
				local state = guardian:GetAttribute("State")
				local targetPlayer = guardian:GetAttribute("TargetPlayer")
				
				if state == "Chasing" and targetPlayer then
					local player = Players:FindFirstChild(targetPlayer)
					if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local targetPos = player.Character.HumanoidRootPart.Position
						self:MoveGuardianToward(guardian, targetPos)
					else
						self:ResetGuardian(guardian)
					end
				elseif state == "Returning" then
					local homePivot = guardian:GetAttribute("HomePivot")
					self:MoveGuardianToward(guardian, homePivot.Position)
				end
			end
	end)
end

function GuardianMovementService:MoveGuardianToward(guardian, targetPosition)
	local guardianPos = guardian.Position
	local direction = (targetPosition - guardianPos).Unit
	
	-- Raycast to find ground
	local rayOrigin = guardian.Position + Vector3.new(0, 2, 0)
	local rayDirection = Vector3.new(0, -1, 0)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {guardian}
	
	local rayResult = Workspace:Raycast(rayOrigin, rayDirection * 10, raycastParams)
	local groundY = guardianPos.Y
	
	if rayResult then
		groundY = rayResult.Position.Y + 1.5
	end
	
	-- Move guardian
	local moveSpeed = guardian:GetAttribute("State") == "Chasing" and 1.5 or 0.5
	local newPos = guardianPos + direction * moveSpeed
	newPos = Vector3.new(newPos.X, groundY, newPos.Z)
	
	guardian.CFrame = CFrame.new(newPos)
end

function GuardianMovementService:ResetGuardian(guardian)
	local homePivot = guardian:GetAttribute("HomePivot")
	if homePivot then
		guardian:SetAttribute("State", "Returning")
		guardian:SetAttribute("TargetPlayer", nil)
	end
end

return GuardianMovementService
