--[[
	RemoteEventConnections
	Client-side handlers for remote events
]]

local RemoteEventConnections = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local remoteFolder = ReplicatedStorage:WaitForChild("Remotes")

function RemoteEventConnections:Initialize(controllers)
	print("[RemoteEventConnections] Setting up remote event handlers...")
	
	local stealEggRemote = remoteFolder:WaitForChild("StealEgg")
	stealEggRemote.OnClientEvent:Connect(function(success, message)
		if success then
			controllers.PromptController:ShowNotification("🔓 OVO ROUBADO!", Color3.fromRGB(255, 100, 100), 2)
			controllers.FXController:CreateStealEffect(player.Character.HumanoidRootPart.Position)
		else
			controllers.PromptController:ShowNotification("❌ " .. message, Color3.fromRGB(255, 100, 100), 2)
		end
	end)
	
	local deliverEggRemote = remoteFolder:WaitForChild("DeliverEgg")
	deliverEggRemote.OnClientEvent:Connect(function(success, message)
		if success then
			controllers.PromptController:ShowNotification("✅ OVO ENTREGUE!", Color3.fromRGB(100, 200, 100), 2)
		else
			controllers.PromptController:ShowNotification("❌ " .. message, Color3.fromRGB(255, 100, 100), 2)
		end
	end)
	
	local dropEggRemote = remoteFolder:WaitForChild("DropEgg")
	dropEggRemote.OnClientEvent:Connect(function(success)
		if success then
			controllers.PromptController:ShowNotification("🤷 OVO CAIU!", Color3.fromRGB(200, 200, 0), 2)
		end
	end)
	
	local recoverEggRemote = remoteFolder:WaitForChild("RecoverEgg")
	recoverEggRemote.OnClientEvent:Connect(function(success)
		if success then
			controllers.PromptController:ShowNotification("🔓 OVO RECUPERADO!", Color3.fromRGB(100, 200, 100), 2)
		end
	end)
	
	local buyItemRemote = remoteFolder:WaitForChild("BuyItem")
	buyItemRemote.OnClientEvent:Connect(function(success, message)
		if success then
			controllers.PromptController:ShowNotification("✅ Compra realizada!", Color3.fromRGB(100, 200, 100), 2)
		else
			controllers.PromptController:ShowNotification("❌ " .. message, Color3.fromRGB(255, 100, 100), 2)
		end
	end)
	
	local claimEventRemote = remoteFolder:WaitForChild("ClaimEventEgg")
	claimEventRemote.OnClientEvent:Connect(function(success, rarity)
		if success then
			controllers.PromptController:ShowNotification("🌟 " .. rarity .. " RARO!", Color3.fromRGB(255, 200, 0), 3)
			controllers.FXController:CreateHatchEffect(player.Character.HumanoidRootPart.Position)
		end
	end)
	
	local speedXPRemote = remoteFolder:WaitForChild("AddSpeedXP")
	speedXPRemote.OnClientEvent:Connect(function(newLevel)
		controllers.PromptController:ShowNotification("⚡ SPEED LEVEL " .. newLevel .. "!", Color3.fromRGB(100, 150, 255), 2)
	end)
	
	print("[RemoteEventConnections] All handlers connected")
end

return RemoteEventConnections
