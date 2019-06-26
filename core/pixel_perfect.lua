local bdCore, c, f = select(2, ...):unpack()
-- bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)

--Cache global variables & functions
local abs, floor, min, max = math.abs, math.floor, math.min, math.max
local GetCVar, SetCVar = GetCVar, SetCVar
local InCombatLockdown = InCombatLockdown

bdCore.pixeler = CreateFrame("frame", nil, UIParent)
-- bdCore.pixeler:RegisterEvent("UI_SCALE_CHANGED")
bdCore.pixeler:RegisterEvent("LOADING_SCREEN_DISABLED")
bdCore.pixeler:RegisterEvent("PLAYER_ENTERING_WORLD")
bdCore.pixeler:RegisterEvent("PLAYER_REGEN_ENABLED")
bdCore.pixeler:SetScript("OnEvent",function()
	if (not c.persistent or not c.persistent.bdAddons.forcescale) then return end
	if (InCombatLockdown()) then return end

	bdCore.scale = 768 / select(2, GetPhysicalScreenSize())
	bdCore.ui_scale = GetCVar("uiScale") or 1
	bdCore.pixel = bdCore.scale / bdCore.ui_scale
	bdCore.border = bdCore.pixel * 2

	-- print(GetPhysicalScreenSize())
	-- print(GetScreenResolutions())
	-- print(GetScreenResolutions())
	-- print(({GetScreenResolutions()})[GetCurrentResolution()])
	-- print(bdCore.scale)

	-- print(bdCore.scale)
	-- print(bdCore.border)
	-- print(bdCore.ui_scale)

	-- SetCVar('uiscale', bdCore.scale)
	-- SetCVar('uiScaleMultiplier', 2)
	-- SetCVar('useUIScale', 0)

	UIParent:SetScale(bdCore.scale)
end)
