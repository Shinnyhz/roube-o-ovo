--[[
	UIController
	Manages all user interface elements
]]

local UIController = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))
local ShopConfig = require(Shared:WaitForChild("ShopConfig"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui
local hudFrame
local coinsLabel
local petsLabel
local incomeLabel
local speedLabel
local xpLabel

function UIController:Initialize(controllers)
	print("[UIController] Initializing...")
	self:CreateHUD()
	self:CreateShopUI()
	self:StartUIUpdates()
end

function UIController:CreateHUD()
	-- Main screen GUI
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "GameHUD"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- HUD Frame (top left corner)
	hudfFrame = Instance.new("Frame")
	hudfFrame.Name = "HUDFrame"
	hudfFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	hudfFrame.BackgroundTransparency = 0.3
	hudfFrame.BorderSizePixel = 0
	hudfFrame.Size = UDim2.new(0, 250, 0, 150)
	hudfFrame.Position = UDim2.new(0, 10, 0, 10)
	hudfFrame.Parent = screenGui
	
	-- Coins label
	coinsLabel = Instance.new("TextLabel")
	coinsLabel.Name = "CoinsLabel"
	coinsLabel.BackgroundTransparency = 1
	coinsLabel.Size = UDim2.new(1, 0, 0, 30)
	coinsLabel.Position = UDim2.new(0, 0, 0, 5)
	coinsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
	coinsLabel.TextSize = 18
	coinsLabel.Font = Enum.Font.GothamBold
	coinsLabel.Text = "💰 Coins: 0"
	coinsLabel.Parent = hudFrame
	
	-- Pets label
	petsLabel = Instance.new("TextLabel")
	petsLabel.Name = "PetsLabel"
	petsLabel.BackgroundTransparency = 1
	petsLabel.Size = UDim2.new(1, 0, 0, 25)
	petsLabel.Position = UDim2.new(0, 0, 0, 35)
	petsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	petsLabel.TextSize = 14
	petsLabel.Font = Enum.Font.Gotham
	petsLabel.Text = "🐾 Pets: 0"
	petsLabel.Parent = hudFrame
	
	-- Income label
	incomeLabel = Instance.new("TextLabel")
	incomeLabel.Name = "IncomeLabel"
	incomeLabel.BackgroundTransparency = 1
	incomeLabel.Size = UDim2.new(1, 0, 0, 25)
	incomeLabel.Position = UDim2.new(0, 0, 0, 60)
	incomeLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
	incomeLabel.TextSize = 14
	incomeLabel.Font = Enum.Font.Gotham
	incomeLabel.Text = "💵 Income: 0/s"
	incomeLabel.Parent = hudFrame
	
	-- Speed label
	speedLabel = Instance.new("TextLabel")
	speedLabel.Name = "SpeedLabel"
	speedLabel.BackgroundTransparency = 1
	speedLabel.Size = UDim2.new(1, 0, 0, 25)
	speedLabel.Position = UDim2.new(0, 0, 0, 85)
	speedLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
	speedLabel.TextSize = 14
	speedLabel.Font = Enum.Font.Gotham
	speedLabel.Text = "⚡ Speed: 0"
	speedLabel.Parent = hudFrame
	
	-- XP label
	xpLabel = Instance.new("TextLabel")
	xpLabel.Name = "XPLabel"
	xpLabel.BackgroundTransparency = 1
	xpLabel.Size = UDim2.new(1, 0, 0, 25)
	xpLabel.Position = UDim2.new(0, 0, 0, 110)
	xpLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
	xpLabel.TextSize = 14
	xpLabel.Font = Enum.Font.Gotham
	xpLabel.Text = "✨ XP: 0/100"
	xpLabel.Parent = hudFrame
end

function UIController:CreateShopUI()
	-- Shop Frame (hidden by default)
	local shopFrame = Instance.new("Frame")
	shopFrame.Name = "ShopFrame"
	shopFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	shopFrame.Size = UDim2.new(0, 400, 0, 500)
	shopFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
	shopFrame.Visible = false
	shopFrame.Parent = screenGui
	
	-- Shop title
	local shopTitle = Instance.new("TextLabel")
	shopTitle.Name = "ShopTitle"
	shopTitle.BackgroundTransparency = 1
	shopTitle.Size = UDim2.new(1, 0, 0, 40)
	shopTitle.Position = UDim2.new(0, 0, 0, 0)
	shopTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
	shopTitle.TextSize = 24
	shopTitle.Font = Enum.Font.GothamBold
	shopTitle.Text = "🏪 Loja - Dona Casca"
	shopTitle.Parent = shopFrame
	
	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -40, 0, 5)
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 18
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Text = "✕"
	closeButton.Parent = shopFrame
	
	closeButton.MouseButton1Click:Connect(function()
		shopFrame.Visible = false
	end)
	
	-- Items container
	local itemsContainer = Instance.new("ScrollingFrame")
	itemsContainer.Name = "ItemsContainer"
	itemsContainer.BackgroundTransparency = 1
	itemsContainer.Size = UDim2.new(1, -20, 1, -60)
	itemsContainer.Position = UDim2.new(0, 10, 0, 50)
	itemsContainer.CanvasSize = UDim2.new(0, 0, 0, #ShopConfig.SHOP_ITEMS * 80)
	itemsContainer.ScrollBarThickness = 8
	itemsContainer.Parent = shopFrame
	
	-- Add shop items
	for i, item in pairs(ShopConfig.SHOP_ITEMS) do
		local itemButton = Instance.new("TextButton")
		itemButton.Name = item.Id
		itemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		itemButton.Size = UDim2.new(1, -10, 0, 70)
		itemButton.Position = UDim2.new(0, 5, 0, (i - 1) * 80)
		itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		itemButton.TextSize = 14
		itemButton.Font = Enum.Font.Gotham
		itemButton.Text = item.Icon .. " " .. item.Name .. " - " .. item.Price .. "💰"
		itemButton.Parent = itemsContainer
		
		itemButton.MouseButton1Click:Connect(function()
			print("[UIController] Clicked item: " .. item.Id)
		end)
	end
	
	screenGui:SetAttribute("ShopFrame", shopFrame)
end

function UIController:UpdateHUD(coinsAmount, petsAmount, income, speedLevel, xpCurrent, xpMax)
	if coinsLabel then
		coinsLabel.Text = "💰 Coins: " .. tostring(coinsAmount)
	end
	if petsLabel then
		petsLabel.Text = "🐾 Pets: " .. tostring(petsAmount)
	end
	if incomeLabel then
		incomeLabel.Text = "💵 Income: " .. tostring(income) .. "/s"
	end
	if speedLabel then
		speedLabel.Text = "⚡ Speed: " .. tostring(speedLevel)
	end
	if xpLabel then
		xpLabel.Text = "✨ XP: " .. tostring(xpCurrent) .. "/" .. tostring(xpMax)
	end
end

function UIController:StartUIUpdates()
	local updateInterval = 0.5
	local lastUpdate = tick()
	
	game:GetService("RunService").Heartbeat:Connect(function()
		local now = tick()
		if now - lastUpdate >= updateInterval then
			lastUpdate = now
			-- Update HUD with mock data for now
			self:UpdateHUD(500, 2, 5, 3, 45, 100)
		end
	end)
end

return UIController
