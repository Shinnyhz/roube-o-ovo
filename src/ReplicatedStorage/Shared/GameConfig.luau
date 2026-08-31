--[[
	GameConfig
	Global game configuration
]]

local GameConfig = {}

-- Map dimensions
GameConfig.MAP = {
	BASE_ZONE_Y = 100,
	BASE_ZONE_LENGTH = 120,
	BASE_ZONE_WIDTH = 40,
	
	CORRIDOR_WIDTH = 30,
	CORRIDOR_LENGTH = 50,
	
	AREA_WIDTH = 80,
	AREA_LENGTH = 80,
}

-- Player spawning
GameConfig.SPAWN = {
	DEFAULT_SPEED = 20,
	SPAWN_HEIGHT = 105,
}

-- Coins and economy
GameConfig.ECONOMY = {
	STARTER_COINS = 500,
	INCOME_TICK_RATE = 1, -- seconds
}

-- Speed progression
GameConfig.SPEED = {
	BASE_WALK_SPEED = 20,
	PER_LEVEL_INCREMENT = 1.5,
	CARRY_PENALTY = 0.7, -- multiplier when carrying egg
	XP_PER_SECOND = 10,
	XP_TO_LEVEL = 100,
	MIN_LEVEL = 0,
	MAX_LEVEL = 12,
}

-- Event system
GameConfig.EVENT = {
	DURATION = 60, -- seconds
	COOLDOWN = 45, -- seconds between events
}

-- Guardian behavior
GameConfig.GUARDIAN = {
	ACCELERATION = 1.5,
	MAX_SPEED = 35,
	DETECTION_RANGE = 60,
	CHASE_SPEED = 30,
	RETURN_SPEED = 15,
	WAYPOINT_DISTANCE = 2,
}

-- Egg mechanics
GameConfig.EGG = {
	MAX_SLOTS = 4, -- incubating slots per base
	CARRY_SPEED_PENALTY = 0.65,
	DROP_TIMEOUT = 30, -- seconds before returning to owner
}

-- DataStore
GameConfig.DATASTORE = {
	ENABLE_IN_STUDIO = false,
	AUTO_SAVE_INTERVAL = 30,
}

-- Dev mode
GameConfig.DEV = {
	DIAGNOSTICS_ENABLED = true,
}

return GameConfig
