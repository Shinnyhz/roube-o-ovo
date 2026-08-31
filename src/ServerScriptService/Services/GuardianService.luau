--[[
	GuardianService
	Manages guardians and pursuit logic
]]

local GuardianService = {}
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local AreaConfig = require(Shared:WaitForChild("AreaConfig"))

local Guardians = {}

function GuardianService:Initialize()
	print("[GuardianService] Initializing...")
	self:CreateAllGuardians()
end

function GuardianService:CreateAllGuardians()
	local guardiansFolder = Instance.new("Folder")
	guardiansFolder.Name = "Guardians"
	guardiansFolder.Parent = Workspace
	
	for areaKey, area in pairs(AreaConfig.AREAS) do
		for _, spot in pairs(area.Spots) do
			local guardian = {
				GuardianKey = spot.Key .. "_Guardian",
				NestKey = spot.Key,
				AreaKey = area.Key,
				TargetUserId = nil,
				State = "Idle",
				Position = Vector3.new(spot.X, 105, spot.Z),
				HomePivot = CFrame.new(spot.X, 105, spot.Z),
				AreaMinX = area.MinX,
				AreaMaxX = area.MaxX,
				AreaNorthZ = area.NorthZ,
				AreaSouthZ = area.SouthZ,
			}
			
			Guardians[guardian.GuardianKey] = guardian
		end
	end
	
	print("[GuardianService] Created " .. table.getn(Guardians) .. " guardians")
end

function GuardianService:GetGuardian(guardianKey)
	return Guardians[guardianKey]
end

function GuardianService:GetGuardiansByArea(areaKey)
	local areaGuardians = {}
	for guardianKey, guardian in pairs(Guardians) do
		if guardian.AreaKey == areaKey then
			table.insert(areaGuardians, guardian)
		end
	end
	return areaGuardians
end

function GuardianService:SetGuardianTarget(guardianKey, targetUserId)
	local guardian = self:GetGuardian(guardianKey)
	if guardian then
		guardian.State = "Chasing"
		guardian.TargetUserId = targetUserId
		return true
	end
	return false
end

function GuardianService:ResetGuardian(guardianKey)
	local guardian = self:GetGuardian(guardianKey)
	if guardian then
		guardian.State = "Idle"
		guardian.TargetUserId = nil
		guardian.Position = guardian.HomePivot.Position
		return true
	end
	return false
end

function GuardianService:PlayerEscapedArea(player, areaKey)
	print("[GuardianService] " .. player.Name .. " escaped " .. areaKey)
	local areaGuardians = self:GetGuardiansByArea(areaKey)
	for _, guardian in pairs(areaGuardians) do
		if guardian.TargetUserId == player.UserId then
			self:ResetGuardian(guardian.GuardianKey)
		end
	end
end

return GuardianService
