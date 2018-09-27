-- i'll use this file for organized testing stuff

local start
local total
local function profile(name, fn)
	start = GetTime();

	fn()

	total = GetTime() - start
	print(name.." took: "..total)
end

profile("table_set_loop", function()
	for i = 1, 1000000 do
		local a = {}
		a[1] = 1; a[2] = 2; a[3] = 3
	end
end)

profile("optimized_table_set_loop", function()
	for i = 1, 1000000 do
		local a = {true, true, true}
		a[1] = 1; a[2] = 2; a[3] = 3
	end
end)


profile("aura_loop", function()
	for i = 1, 1000 do
		UnitAura("player", i)
	end
end)

profile("optimized_aura_loop", function()
	local UnitAura = UnitAura
	for i = 1, 1000 do
		UnitAura("player", i)
	end
end)



profile("unit_player", function()
	for i = 1, 1000 do
		local var = UnitIsPlayer('player')
	end
end)
profile("unit_tap_denied", function()
	for i = 1, 1000 do
		local var = UnitIsTapDenied('player')
	end
end)
profile("unit_player_controlled", function()
	for i = 1, 1000 do
		local var = UnitPlayerControlled('player')
	end
end)
profile("unit_unit", function()
	for i = 1, 1000 do
		local var = UnitHealth('player')
	end
end)
profile("unit_health_max", function()
	for i = 1, 1000 do
		local var = UnitHealthMax('player')
	end
end)


profile("optimized_unit_player", function()
	local UnitIsPlayer = UnitIsPlayer
	for i = 1, 1000 do
		local var = UnitIsPlayer('player')
	end
end)
profile("optimized_unit_tap_denied", function()
	local UnitIsTapDenied = UnitIsTapDenied
	for i = 1, 1000 do
		local var = UnitIsTapDenied('player')
	end
end)
profile("optimized_unit_player_controlled", function()
	local UnitPlayerControlled = UnitPlayerControlled
	for i = 1, 1000 do
		local var = UnitPlayerControlled('player')
	end
end)
profile("optimized_unit_unit", function()
	local UnitHealth = UnitHealth
	for i = 1, 1000 do
		local var = UnitHealth('player')
	end
end)
profile("optimized_unit_health_max", function()
	local UnitHealthMax = UnitHealthMax
	for i = 1, 1000 do
		local var = UnitHealthMax('player')
	end
end)