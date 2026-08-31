--[[
	SoundConfig
	Sound effects configuration
]]

local SoundConfig = {}

SoundConfig.SOUNDS = {
	CLICK = { Id = "rbxassetid://12221967", Volume = 0.5 },
	SUCCESS = { Id = "rbxassetid://12221974", Volume = 0.6 },
	ERROR = { Id = "rbxassetid://12221989", Volume = 0.5 },
	STEAL = { Id = "rbxassetid://12221965", Volume = 0.7 },
	HATCH = { Id = "rbxassetid://12221970", Volume = 0.8 },
	RARE = { Id = "rbxassetid://12221975", Volume = 0.9 },
	GUARDIAN_ALERT = { Id = "rbxassetid://12221966", Volume = 0.7 },
	GUARDIAN_CATCH = { Id = "rbxassetid://12221968", Volume = 0.8 },
	UPGRADE = { Id = "rbxassetid://12221973", Volume = 0.6 },
	SPEED_UP = { Id = "rbxassetid://12221976", Volume = 0.7 },
}

function SoundConfig:GetSound(soundKey)
	return self.SOUNDS[soundKey]
end

return SoundConfig
