--[[
	UpgradeConfig
	Upgrade tiers and mechanics
]]

local UpgradeConfig = {}

UpgradeConfig.UPGRADES = {
	INCUBATOR = {
		Name = "Incubadora",
		Description = "Reduz tempo de incubação",
		MaxLevel = 4,
		Levels = {
			{ Cost = 1000, TimeMultiplier = 0.85 },
			{ Cost = 2500, TimeMultiplier = 0.70 },
			{ Cost = 5000, TimeMultiplier = 0.55 },
			{ Cost = 10000, TimeMultiplier = 0.40 },
		},
	},
	BARRIER = {
		Name = "Barreira",
		Description = "Defende contra invasores",
		MaxLevel = 3,
		Levels = {
			{ Cost = 1500, PushForce = 50 },
			{ Cost = 3500, PushForce = 75 },
			{ Cost = 7500, PushForce = 100 },
		},
	},
	ALARM = {
		Name = "Alarme",
		Description = "Alerta quando invadido",
		MaxLevel = 2,
		Levels = {
			{ Cost = 800 },
			{ Cost = 2000 },
		},
	},
	SHOCK = {
		Name = "Ninho Elétrico",
		Description = "Choca ladrão com eletricidade",
		MaxLevel = 4,
		Levels = {
			{ Cost = 1200, SpeedReduction = 0.20, Duration = 3 },
			{ Cost = 2800, SpeedReduction = 0.35, Duration = 4 },
			{ Cost = 5500, SpeedReduction = 0.50, Duration = 5 },
			{ Cost = 10000, SpeedReduction = 0.70, Duration = 6 },
		},
	},
}

function UpgradeConfig:GetUpgrade(upgradeKey)
	return self.UPGRADES[upgradeKey]
end

function UpgradeConfig:GetUpgradeCost(upgradeKey, level)
	local upgrade = self:GetUpgrade(upgradeKey)
	if not upgrade or level > upgrade.MaxLevel then
		return nil
	end
	return upgrade.Levels[level].Cost
end

return UpgradeConfig
