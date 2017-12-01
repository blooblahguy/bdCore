local bdCore, c, s = select(2, ...):unpack()

--[[
local oh = CreateFrame("frame","bd Quest Holder", )
ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint()
--]]

bdCore:hookEvent("loaded_bdcore", function()
	local config = c.persistent.General

	setglobal("MAX_EQUIPMENT_SETS_PER_PLAYER", 100)
end)