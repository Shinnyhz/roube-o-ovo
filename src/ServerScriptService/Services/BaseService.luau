--[[
	BaseService
	Manages player bases and ownership
]]

local BaseService = {}
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Bases = {}
local PlayerToBase = {}

function BaseService:Initialize()
	print("[BaseService] Initializing...")
	
	local basesFolder = Workspace:WaitForChild("Bases")
	for i = 1, 6 do
		local base = basesFolder:FindFirstChild("Base" .. i)
		if base then
			Bases[i] = base
		end
	end
	
	-- Assign bases to players
	Players.PlayerAdded:Connect(function(player)
		self:AssignBaseToPlayer(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:RemovePlayerFromBase(player)
	end)
end

function BaseService:AssignBaseToPlayer(player)
	-- Find first available base
	for i = 1, 6 do
		if Bases[i] and not Bases[i]:GetAttribute("OwnerUserId") then
			Bases[i]:SetAttribute("OwnerUserId", player.UserId)
			PlayerToBase[player.UserId] = i
			print("[BaseService] Base " .. i .. " assigned to " .. player.Name)
			return i
		end
	end
	return nil
end

function BaseService:RemovePlayerFromBase(player)
	local baseIndex = PlayerToBase[player.UserId]
	if baseIndex and Bases[baseIndex] then
		Bases[baseIndex]:SetAttribute("OwnerUserId", nil)
		PlayerToBase[player.UserId] = nil
	end
end

function BaseService:GetPlayerBase(player)
	local baseIndex = PlayerToBase[player.UserId]
	if baseIndex then
		return Bases[baseIndex]
	end
	return nil
end

function BaseService:GetBasePivot(player)
	local base = self:GetPlayerBase(player)
	if base then
		return CFrame.new(base:GetAttribute("X"), base:GetAttribute("Y") + 3, base:GetAttribute("Z"))
	end
	return nil
end

return BaseService
