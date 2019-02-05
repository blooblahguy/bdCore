local bdCore, c, s = select(2, ...):unpack()
-- bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)


-- Load all quality of life modules in one place
bdCore:hookEvent("loaded_bdcore", function()
	-- local config = c
	-- config = c.persistent.bdAddons

	-- increase equipment sets per player
	setglobal("MAX_EQUIPMENT_SETS_PER_PLAYER", 100)
end)