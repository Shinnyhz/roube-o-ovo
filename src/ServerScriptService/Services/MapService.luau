--[[
	MapService
	Builds and manages the game world
]]

local MapService = {}
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local AreaConfig = require(Shared:WaitForChild("AreaConfig"))
local EggConfig = require(Shared:WaitForChild("EggConfig"))

function MapService:Initialize()
	print("[MapService] Building world...")
	self:BuildBaseZone()
	self:BuildCorridors()
	self:BuildAreas()
	self:BuildShop()
	self:BuildEventPedestal()
	self:BuildSpeedTraining()
	print("[MapService] World built successfully")
end

function MapService:CreatePart(name, size, color, material, parent, cframe)
	local part = Instance.new("Part")
	part.Name = name
	part.Shape = Enum.PartType.Block
	part.Size = size
	part.Color = color or Color3.fromRGB(100, 100, 100)
	part.Material = material or Enum.Material.Plastic
	part.CanCollide = true
	part.CanQuery = true
	part.CanTouch = true
	part.CFrame = cframe or CFrame.new(0, 10, 0)
	part.TopSurface = Enum.SurfaceType.Studs
	part.BottomSurface = Enum.SurfaceType.Studs
	part.Parent = parent or Workspace
	return part
end

function MapService:BuildBaseZone()
	local baseFolder = Instance.new("Folder")
	baseFolder.Name = "Bases"
	baseFolder.Parent = Workspace
	
	-- Create 6 bases side by side
	for i = 1, 6 do
		local baseX = (i - 3.5) * 20
		local baseY = 100
		local baseZ = 0
		
		local baseGroup = Instance.new("Folder")
		baseGroup.Name = "Base" .. i
		baseGroup.Parent = baseFolder
		
		-- Base platform
		local basePlatform = self:CreatePart(
			"Platform",
			Vector3.new(18, 1, 18),
			Color3.fromRGB(100, 150, 100),
			Enum.Material.Concrete,
			baseGroup,
			CFrame.new(baseX, baseY, baseZ)
		)
		
		-- Nest area (for incubating eggs)
		local nestPlatform = self:CreatePart(
			"NestPlatform",
			Vector3.new(8, 0.5, 8),
			Color3.fromRGB(139, 69, 19),
			Enum.Material.Wood,
			baseGroup,
			CFrame.new(baseX - 4, baseY + 1, baseZ)
		)
		
		-- Pet area (separate from nest)
		local petPlatform = self:CreatePart(
			"PetPlatform",
			Vector3.new(8, 0.5, 8),
			Color3.fromRGB(200, 200, 150),
			Enum.Material.Concrete,
			baseGroup,
			CFrame.new(baseX + 4, baseY + 1, baseZ)
		)
		
		-- Delivery zone
		local deliveryZone = Instance.new("Part")
		deliveryZone.Name = "DeliveryZone"
		deliveryZone.Shape = Enum.PartType.Block
		deliveryZone.Size = Vector3.new(6, 1, 6)
		deliveryZone.CanCollide = false
		deliveryZone.CanTouch = true
		deliveryZone.CanQuery = false
		deliveryZone.Transparency = 1
		deliveryZone.CFrame = CFrame.new(baseX, baseY + 0.5, baseZ + 8)
		deliveryZone.Parent = baseGroup
		
		-- Store base info as attributes
		baseGroup:SetAttribute("BaseIndex", i)
		baseGroup:SetAttribute("OwnerUserId", nil)
		baseGroup:SetAttribute("X", baseX)
		baseGroup:SetAttribute("Y", baseY)
		baseGroup:SetAttribute("Z", baseZ)
	end
end

function MapService:BuildCorridors()
	local corridorFolder = Instance.new("Folder")
	corridorFolder.Name = "Corridors"
	corridorFolder.Parent = Workspace
	
	-- Corridor 1 (between bases and Area1)
	local corridor1 = self:CreatePart(
		"Corridor1",
		Vector3.new(30, 1, 50),
		Color3.fromRGB(150, 150, 100),
		Enum.Material.Concrete,
		corridorFolder,
		CFrame.new(0, 100, -65)
	)
	
	-- Corridor 2 (between Area1 and Area2)
	local corridor2 = self:CreatePart(
		"Corridor2",
		Vector3.new(30, 1, 50),
		Color3.fromRGB(150, 150, 100),
		Enum.Material.Concrete,
		corridorFolder,
		CFrame.new(0, 100, -205)
	)
	
	-- Corridor 3 (between Area2 and Area3)
	local corridor3 = self:CreatePart(
		"Corridor3",
		Vector3.new(30, 1, 50),
		Color3.fromRGB(150, 150, 100),
		Enum.Material.Concrete,
		corridorFolder,
		CFrame.new(0, 100, -335)
	)
end

function MapService:BuildAreas()
	local areaFolder = Instance.new("Folder")
	areaFolder.Name = "Areas"
	areaFolder.Parent = Workspace
	
	-- Area 1: Meadow and Lake
	local area1 = Instance.new("Folder")
	area1.Name = "Area1"
	area1.Parent = areaFolder
	
	-- Meadow
	local meadow = self:CreatePart(
		"Meadow",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(100, 200, 100),
		Enum.Material.Grass,
		area1,
		CFrame.new(-20, 100, -140)
	)
	
	-- Lake
	local lake = self:CreatePart(
		"Lake",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(0, 100, 200),
		Enum.Material.Ice,
		area1,
		CFrame.new(20, 100, -140)
	)
	
	-- Area 2: Desert and Glacier
	local area2 = Instance.new("Folder")
	area2.Name = "Area2"
	area2.Parent = areaFolder
	
	local desert = self:CreatePart(
		"Desert",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(200, 150, 50),
		Enum.Material.Sand,
		area2,
		CFrame.new(-20, 100, -280)
	)
	
	local glacier = self:CreatePart(
		"Glacier",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(150, 200, 255),
		Enum.Material.Ice,
		area2,
		CFrame.new(20, 100, -280)
	)
	
	-- Area 3: Volcano and Celestial
	local area3 = Instance.new("Folder")
	area3.Name = "Area3"
	area3.Parent = areaFolder
	
	local volcano = self:CreatePart(
		"Volcano",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(150, 50, 0),
		Enum.Material.Rock,
		area3,
		CFrame.new(-20, 100, -420)
	)
	
	local celestial = self:CreatePart(
		"Celestial",
		Vector3.new(35, 1, 35),
		Color3.fromRGB(100, 50, 200),
		Enum.Material.Neon,
		area3,
		CFrame.new(20, 100, -420)
	)
end

function MapService:BuildShop()
	local shopFolder = Instance.new("Folder")
	shopFolder.Name = "Shop"
	shopFolder.Parent = Workspace
	
	local shopStand = self:CreatePart(
		"ShopStand",
		Vector3.new(10, 3, 10),
		Color3.fromRGB(200, 100, 50),
		Enum.Material.Wood,
		shopFolder,
		CFrame.new(0, 100, 30)
	)
	
	shopFolder:SetAttribute("NPC", "Dona Casca")
end

function MapService:BuildEventPedestal()
	local eventFolder = Instance.new("Folder")
	eventFolder.Name = "EventPedestal"
	eventFolder.Parent = Workspace
	
	local pedestal = self:CreatePart(
		"Pedestal",
		Vector3.new(8, 2, 8),
		Color3.fromRGB(255, 200, 0),
		Enum.Material.Neon,
		eventFolder,
		CFrame.new(0, 100, 60)
	)
	
	eventFolder:SetAttribute("Active", false)
end

function MapService:BuildSpeedTraining()
	local trainingFolder = Instance.new("Folder")
	trainingFolder.Name = "SpeedTraining"
	trainingFolder.Parent = Workspace
	
	local treadmill = self:CreatePart(
		"Treadmill",
		Vector3.new(6, 1, 15),
		Color3.fromRGB(100, 100, 100),
		Enum.Material.Metal,
		trainingFolder,
		CFrame.new(0, 100, 80)
	)
	
	trainingFolder:SetAttribute("NPC", "Teo Turbo")
end

return MapService
