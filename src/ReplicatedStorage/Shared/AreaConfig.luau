--[[
	AreaConfig
	World areas and their properties
]]

local AreaConfig = {}

local BASE_Y = 100
local CORRIDOR_WIDTH = 30
local AREA_WIDTH = 80
local AREA_LENGTH = 80

AreaConfig.AREAS = {
	AREA_1 = {
		Key = "Area1",
		Name = "Prado e Lago",
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
		NorthZ = -100,
		SouthZ = -180,
		Spots = {
			{
				Key = "Area1_Meadow",
				Name = "Prado",
				X = -20,
				Z = -130,
				Theme = "meadow",
				SpeedRequired = 0,
			},
			{
				Key = "Area1_Lake",
				Name = "Lago",
				X = 20,
				Z = -130,
				Theme = "water",
				SpeedRequired = 2,
			},
		},
	},
	AREA_2 = {
		Key = "Area2",
		Name = "Deserto e Geleira",
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
		NorthZ = -230,
		SouthZ = -310,
		Spots = {
			{
				Key = "Area2_Desert",
				Name = "Deserto",
				X = -20,
				Z = -270,
				Theme = "desert",
				SpeedRequired = 4,
			},
			{
				Key = "Area2_Glacier",
				Name = "Geleira",
				X = 20,
				Z = -270,
				Theme = "ice",
				SpeedRequired = 6,
			},
		},
	},
	AREA_3 = {
		Key = "Area3",
		Name = "Vulcão e Celestial",
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
		NorthZ = -360,
		SouthZ = -440,
		Spots = {
			{
				Key = "Area3_Volcano",
				Name = "Vulcão",
				X = -20,
				Z = -400,
				Theme = "volcano",
				SpeedRequired = 8,
			},
			{
				Key = "Area3_Celestial",
				Name = "Celestial",
				X = 20,
				Z = -400,
				Theme = "celestial",
				SpeedRequired = 11,
			},
		},
	},
}

AreaConfig.ESCAPE_ZONES = {
	{
		AreaKey = "Area1",
		NorthZ = -100,
		SouthZ = -110,
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
	},
	{
		AreaKey = "Area2",
		NorthZ = -230,
		SouthZ = -240,
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
	},
	{
		AreaKey = "Area3",
		NorthZ = -360,
		SouthZ = -370,
		MinX = -AREA_WIDTH / 2,
		MaxX = AREA_WIDTH / 2,
	},
}

function AreaConfig:GetArea(areaKey)
	for _, area in pairs(self.AREAS) do
		if area.Key == areaKey then
			return area
		end
	end
	return nil
end

function AreaConfig:GetSpot(spotKey)
	for _, area in pairs(self.AREAS) do
		for _, spot in pairs(area.Spots) do
			if spot.Key == spotKey then
				return spot, area
			end
		end
	end
	return nil, nil
end

return AreaConfig
