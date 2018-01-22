local bdCore, c, s = select(2, ...):unpack()

--[[
local oh = CreateFrame("frame","bd Quest Holder", )
ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint()
--]]

function bdCore:pixelPerfection() 
	local scale
	local uiParentWidth, uiParentHeight

	local s_width, s_height = GetPhysicalScreenSize()

	bdCore.scale = 768/s_height

	UIParent:SetScale(bdCore.scale)
end

-- Load all quality of life modules in one place
bdCore:hookEvent("loaded_bdcore", function()
	local config = c.persistent.General

	-- increase equipment sets per player
	setglobal("MAX_EQUIPMENT_SETS_PER_PLAYER", 100)


end)