local bdCore, c, s = select(2, ...):unpack()



-- Load all quality of life modules in one place
bdCore:hookEvent("loaded_bdcore", function()
	local config = bdConfigLib.persistent.General

	-- increase equipment sets per player
	setglobal("MAX_EQUIPMENT_SETS_PER_PLAYER", 100)
end)