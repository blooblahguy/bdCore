local bdCore, c, f = select(2, ...):unpack()
bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)

--Cache global variables & functions
local abs, floor, min, max = math.abs, math.floor, math.min, math.max
local GetCVar, SetCVar = GetCVar, SetCVar
local InCombatLockdown = InCombatLockdown

-- Because this is such a freaking bear on larger resolutions, reusing some of the ElvUI code here since they support so many situations
local scale, uiParentWidth, uiParentHeight, uiParentScale
function bdCore:pixelPerfection(self, event, arg1)
	dump(c)
	if (not c or not c.persistent.forcescale) then return end
	print("scaling")

	local screenWidth, screenHeight = GetPhysicalScreenSize()
	local scale = min(1.15, 768/screenHeight)
	local multiplier = 768/screenHeight/scale

	if ( InCombatLockdown()) then
		local width, height = UIParent:GetSize()
		uiParentWidth, uiParentHeight, uiParentScale = width, height, scale
		bdCore.pixeler:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		-- Alt tabbing in combat breaks scale on large resolutions
		if (event == "PLAYER_REGEN_ENABLED") then
			bdCore.pixeler:UnregisterEvent("PLAYER_REGEN_ENABLED")
			
			if uiParentScale and (uiParentScale < 0.64) then
				UIParent:SetScale(uiParentScale)
				uiParentWidth, uiParentHeight = UIParent:GetSize()
			end

			UIParent:SetSize(uiParentWidth, uiParentHeight)
		end

		-- Only set these once
		if (event == "PLAYER_LOGIN") then
			bdCore.pixeler:UnregisterEvent('PLAYER_LOGIN')
			SetCVar("useUiScale", 1);
			SetCVar("uiScale", scale);
		end

		-- blizzard for real, why make this the limit? people have big monitors these days
		if (scale < 0.64) then
			UIParent:SetScale(scale)
		end
	end

	-- bdCore.scale = 768/s_height
	-- bdCore.forceScale = true
	-- hooksecurefunc(UIParent, "SetScale", function()
	-- 	if (not bdCore.forceScale) then
	-- 		bdCore:pixelPerfection()
	-- 	end
	-- end)
	-- bdCore.forceScale = false
end

bdCore.pixeler = CreateFrame("frame", nil, UIParent)
bdCore.pixeler:RegisterEvent("PLAYER_LOGIN")
bdCore.pixeler:SetScript("OnEvent", bdCore.pixelPerfection)