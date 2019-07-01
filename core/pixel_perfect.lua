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
	
	bdCore:calculate_scale()

	if (not c.persistent or not c.persistent.bdAddons.forcescale) then return end
	if (InCombatLockdown()) then return end

	UIParent:SetScale(bdCore.scale)
end)
