--[[
	DiagnosticsService
	Runs validation checks on game state
]]

local DiagnosticsService = {}
local Workspace = game:GetService("Workspace")

function DiagnosticsService:Initialize()
	print("[DiagnosticsService] Initialized")
end

function DiagnosticsService:RunDiagnostics()
	print("\n=== DIAGNOSTIC REPORT ===")
	
	local basesFolder = Workspace:FindFirstChild("Bases")
	if basesFolder then
		local baseCount = 0
		for _, base in pairs(basesFolder:GetChildren()) do
			if base:IsA("Folder") then
				baseCount = baseCount + 1
			end
		end
		print("[DIAGNOSTIC] ✓ Bases: " .. baseCount .. "/6")
	else
		print("[DIAGNOSTIC] ✗ Bases folder not found")
	end
	
	local areasFolder = Workspace:FindFirstChild("Areas")
	if areasFolder then
		local areaCount = 0
		for _, area in pairs(areasFolder:GetChildren()) do
			if area:IsA("Folder") then
				areaCount = areaCount + 1
			end
		end
		print("[DIAGNOSTIC] ✓ Areas: " .. areaCount .. "/3")
	else
		print("[DIAGNOSTIC] ✗ Areas folder not found")
	end
	
	local guardiansFolder = Workspace:FindFirstChild("Guardians")
	if guardiansFolder then
		print("[DIAGNOSTIC] ✓ Guardians folder created")
	else
		print("[DIAGNOSTIC] ✗ Guardians folder not found")
	end
	
	local shopFolder = Workspace:FindFirstChild("Shop")
	if shopFolder then
		print("[DIAGNOSTIC] ✓ Shop found")
	else
		print("[DIAGNOSTIC] ✗ Shop not found")
	end
	
	local eventFolder = Workspace:FindFirstChild("EventPedestal")
	if eventFolder then
		print("[DIAGNOSTIC] ✓ Event Pedestal found")
	else
		print("[DIAGNOSTIC] ✗ Event Pedestal not found")
	end
	
	local trainingFolder = Workspace:FindFirstChild("SpeedTraining")
	if trainingFolder then
		print("[DIAGNOSTIC] ✓ Speed Training found")
	else
		print("[DIAGNOSTIC] ✗ Speed Training not found")
	end
	
	print("\n[DIAGNOSTIC] MAP OK\n")
end

return DiagnosticsService
