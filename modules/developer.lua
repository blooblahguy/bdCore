-- i'll use this file for organized testing stuff

local parent = {}
parent.colors = {}
parent.colors.reaction = {}
parent.colors.reaction[4] = {.1, .2, .3, 1}

function bdCore_profile()
	local total_time = 0



	local function profile(name, fn)
		local start = debugprofilestop()

		local response = fn()

		local finish = debugprofilestop()
		local total = finish - start
		
		print(name..": ")
		print("==== "..total)
		if (response) then
			print("==== "..response)
		end
	end

	if (UnitExists("nameplate1")) then
		profile("unitreaction_color", function()
			for i = 1, 100 do
				local unitreaction = UnitReaction('nameplate1', 'player')
				local color = unpack(parent.colors.reaction[4])
			end
		end)
		profile("optimized_unitreaction_color", function()
			local unpack, UnitReaction = unpack, UnitReaction
			local r_table = parent.colors.reaction
			for i = 1, 100 do
				local unitreaction = UnitReaction('nameplate1', 'player')
				local color = unpack(r_table[4])
			end
		end)

		profile("table_set_loop", function()
			for i = 1, 100000 do
				local a = {}
				a[1] = 1; a[2] = 2; a[3] = 3
			end
			print("ran")
		end)
		profile("optimized_table_set_loop", function()
			for i = 1, 100000 do
				local a = {true, true, true}
				a[1] = 1; a[2] = 2; a[3] = 3
			end
		end)
		print(" ")
	end

	--[[if (UnitExists("nameplate1")) then
		profile("UnitIsConnected", function()
			local var
			for i = 1, 10000 do
				var = UnitIsConnected("nameplate1")
			end
		end)
		profile("optimized_UnitIsConnected", function()
			local UnitIsConnected = UnitIsConnected
			local var
			for i = 1, 10000 do
				var = UnitIsConnected("nameplate1")
			end
		end)
		print(" ")

		profile("UnitExists", function()
			local var
			for i = 1, 10000 do
				var = UnitExists("nameplate1")
			end
		end)
		profile("optimized_UnitExists", function()
			local UnitExists = UnitExists
			local var
			for i = 1, 10000 do
				var = UnitExists("nameplate1")
			end
		end)
		print(" ")

		profile("UnitReaction", function()
			local var
			for i = 1, 10000 do
				var = UnitReaction("player", "nameplate1")
			end
		end)
		profile("optimized_UnitReaction", function()
			local UnitReaction = UnitReaction
			local var
			for i = 1, 10000 do
				var = UnitReaction("player", "nameplate1")
			end
		end)
		print(" ")

		profile("UnitIsUnit", function()
			local var
			for i = 1, 10000 do
				var = UnitIsUnit("player", "nameplate1")
			end
		end)
		profile("optimized_UnitIsUnit", function()
			local UnitIsUnit = UnitIsUnit
			local var
			for i = 1, 10000 do
				var = UnitIsUnit("player", "nameplate1")
			end
		end)
		print(" ")
	

		profile("aura_loop", function()
			local var
			for i = 1, 10000 do
				var = UnitAura("nameplate1", i)
			end
		end)
		profile("optimized_aura_loop", function()
			local UnitAura = UnitAura
			local var
			for i = 1, 10000 do
				var = UnitAura("nameplate1", i)
			end
		end)
		print(" ")

		profile("unit_player", function()
			for i = 1, 10000 do
				local var = UnitIsPlayer('nameplate1')
			end
		end)
		profile("optimized_unit_player", function()
			local UnitIsPlayer = UnitIsPlayer
			local var
			for i = 1, 10000 do
				var = UnitIsPlayer('nameplate1')
			end
		end)
		print(" ")

		profile("unit_tap_denied", function()
			for i = 1, 10000 do
				local var = UnitIsTapDenied('nameplate1')
			end
		end)
		profile("optimized_unit_tap_denied", function()
			local UnitIsTapDenied = UnitIsTapDenied
			local var
			for i = 1, 10000 do
				var = UnitIsTapDenied('nameplate1')
			end
		end)

		print(" ")
		profile("unit_player_controlled", function()
			for i = 1, 10000 do
				local var = UnitPlayerControlled('nameplate1')
			end
		end)
		profile("optimized_unit_player_controlled", function()
			local UnitPlayerControlled = UnitPlayerControlled
			local var
			for i = 1, 10000 do
				var = UnitPlayerControlled('nameplate1')
			end
		end)
		print(" ")

		profile("unit_unit", function()
			for i = 1, 10000 do
				local var = UnitHealth('nameplate1')
			end
		end)
		profile("optimized_unit_unit", function()
			local UnitHealth = UnitHealth
			local var
			for i = 1, 10000 do
				var = UnitHealth('nameplate1')
			end
		end)
		print(" ")

		profile("unit_health_max", function()
			for i = 1, 10000 do
				local var = UnitHealthMax('nameplate1')
			end
		end)
		profile("optimized_unit_health_max", function()
			local UnitHealthMax = UnitHealthMax
			local var
			for i = 1, 10000 do
				var = UnitHealthMax('nameplate1')
			end
		end)
	end--]]
end

local tester = CreateFrame("frame", nil)
tester:RegisterEvent("LOADING_SCREEN_DISABLED")
tester:SetScript("OnEvent", bdCore_profile)