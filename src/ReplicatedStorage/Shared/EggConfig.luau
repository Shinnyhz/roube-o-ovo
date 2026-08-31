--[[
	EggConfig
	Egg rarities, stats, and mechanics
]]

local EggConfig = {}

EggConfig.RARITIES = {
	COMMON = {
		Color = Color3.fromRGB(200, 200, 200),
		AccentColor = Color3.fromRGB(150, 150, 150),
		Value = 100,
		IncomePerSecond = 2,
		IncubationTime = 30,
		Scale = 1.0,
		Probability = 0.55,
	},
	UNCOMMON = {
		Color = Color3.fromRGB(100, 200, 100),
		AccentColor = Color3.fromRGB(50, 150, 50),
		Value = 250,
		IncomePerSecond = 4,
		IncubationTime = 45,
		Scale = 1.1,
		Probability = 0.25,
	},
	RARE = {
		Color = Color3.fromRGB(100, 150, 255),
		AccentColor = Color3.fromRGB(50, 100, 200),
		Value = 500,
		IncomePerSecond = 6,
		IncubationTime = 60,
		Scale = 1.2,
		Probability = 0.12,
	},
	EPIC = {
		Color = Color3.fromRGB(200, 100, 255),
		AccentColor = Color3.fromRGB(150, 50, 200),
		Value = 1000,
		IncomePerSecond = 10,
		IncubationTime = 90,
		Scale = 1.35,
		Probability = 0.05,
	},
	LEGENDARY = {
		Color = Color3.fromRGB(255, 200, 50),
		AccentColor = Color3.fromRGB(255, 150, 0),
		Value = 2500,
		IncomePerSecond = 15,
		IncubationTime = 120,
		Scale = 1.5,
		Probability = 0.025,
	},
	MYTHIC = {
		Color = Color3.fromRGB(100, 200, 255),
		AccentColor = Color3.fromRGB(200, 100, 255),
		Value = 5000,
		IncomePerSecond = 25,
		IncubationTime = 180,
		Scale = 1.7,
		Probability = 0.005,
	},
}

EggConfig.STATES = {
	CREATED = "Created",
	WILD = "Wild",
	EVENT = "Event",
	INCUBATING = "Incubating",
	CARRIED = "Carried",
	DROPPED = "Dropped",
	HATCHING = "Hatching",
}

function EggConfig:GenerateRarity()
	local roll = math.random()
	local cumulative = 0
	
	for rarity, config in pairs(self.RARITIES) do
		cumulative = cumulative + config.Probability
		if roll <= cumulative then
			return rarity
		end
	end
	
	return "COMMON"
end

function EggConfig:GetRarityConfig(rarity)
	return self.RARITIES[rarity] or self.RARITIES.COMMON
end

return EggConfig
