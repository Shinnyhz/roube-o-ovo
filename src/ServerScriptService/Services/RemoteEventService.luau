--[[
	RemoteEventService
	Manages network communication between client and server
]]

local RemoteEventService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local remoteFolder

function RemoteEventService:Initialize()
	print("[RemoteEventService] Initializing...")
	
	-- Create remotes folder
	remoteFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remoteFolder then
		remoteFolder = Instance.new("Folder")
		remoteFolder.Name = "Remotes"
		remoteFolder.Parent = ReplicatedStorage
	end
	
	-- Create remote events
	self:CreateRemoteEvent("StealEgg")
	self:CreateRemoteEvent("DeliverEgg")
	self:CreateRemoteEvent("DropEgg")
	self:CreateRemoteEvent("RecoverEgg")
	self:CreateRemoteEvent("BuyItem")
	self:CreateRemoteEvent("ClaimEventEgg")
	self:CreateRemoteEvent("AddSpeedXP")
	
	print("[RemoteEventService] " .. #remoteFolder:GetChildren() .. " remote events created")
end

function RemoteEventService:CreateRemoteEvent(eventName)
	if not remoteFolder:FindFirstChild(eventName) then
		local remote = Instance.new("RemoteEvent")
		remote.Name = eventName
		remote.Parent = remoteFolder
	end
end

function RemoteEventService:GetRemote(eventName)
	return remoteFolder:FindFirstChild(eventName)
end

return RemoteEventService
