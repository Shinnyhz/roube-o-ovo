--[[
	CreatureConfig
	Pet creature definitions and visuals
]]

local CreatureConfig = {}

CreatureConfig.CREATURES = {
	COMMON = {
		Name = "Critter",
		Color = Color3.fromRGB(180, 180, 180),
		Size = 1.0,
		BobAmount = 0.2,
		BobSpeed = 0.5,
	},
	UNCOMMON = {
		Name = "Sprout",
		Color = Color3.fromRGB(100, 180, 100),
		Size = 1.15,
		BobAmount = 0.3,
		BobSpeed = 0.6,
	},
	RARE = {
		Name = "Aqua",
		Color = Color3.fromRGB(100, 150, 200),
		Size = 1.3,
		BobAmount = 0.4,
		BobSpeed = 0.7,
	},
	EPIC = {
		Name = "Antler",
		Color = Color3.fromRGB(200, 100, 200),
		Size = 1.45,
		BobAmount = 0.5,
		BobSpeed = 0.8,
	},
	LEGENDARY = {
		Name = "Crown",
		Color = Color3.fromRGB(255, 200, 100),
		Size = 1.6,
		BobAmount = 0.6,
		BobSpeed = 0.9,
	},
	MYTHIC = {
		Name = "Astral",
		Color = Color3.fromRGB(150, 100, 200),
		Size = 1.8,
		BobAmount = 0.7,
		BobSpeed = 1.0,
	},
}

function CreatureConfig:GetCreature(rarity)
	return self.CREATURES[rarity] or self.CREATURES.COMMON
end

return CreatureConfig
