local bdCore, c, f = select(2, ...):unpack()
-- bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)

--Cache global variables & functions
local abs, floor, min, max = math.abs, math.floor, math.min, math.max
local GetCVar, SetCVar = GetCVar, SetCVar
local InCombatLockdown = InCombatLockdown

-- Because this is such a freaking bear on larger resolutions, reusing some of the ElvUI code here since they support so many situations
function bdCore:pixelPerfection(event, loginFrame)
	if (not c or not c.persistent.forcescale) then print("won't scale ui") return end

	local width, height = GetPhysicalScreenSize()
	local scale, mult, spacing, border

	local uiScaleCVar = GetCVar('uiScale')

	local minScale = 0.64
	scale = max(minScale, min(1.15, 768 / height))

	mult = 768 / height / scale
	scale = math.floor(scale * 100) / 100
	spacing = mult and mult or 0
	border = (mult) or mult*2
	-- print(scale, event)

	--Set UIScale, NOTE: SetCVar for UIScale can cause taints so only do this when we need to..
	if event == 'PLAYER_LOGIN' and (round(UIParent:GetScale(), 5) ~= round(scale, 5)) then
		SetCVar("useUiScale", 1)
		SetCVar("uiScale", scale)
		SetCVar("uiScaleMultiplier", "-1")
	end

	--SetCVar for UI scale only accepts value as low as 0.64, so scale UIParent if needed
	if scale < 0.64 then
		UIParent:SetScale(scale)
	end

	if event == 'PLAYER_LOGIN' or event == 'UI_SCALE_CHANGED' then


		if loginFrame and event == 'PLAYER_LOGIN' then
			loginFrame:UnregisterEvent('PLAYER_LOGIN')
		end
	end
end

--[[function bdCore:pixelPerfection(event, arg1)
	if (not c or not c.persistent.forcescale) then return end
	

	local screenWidth, screenHeight = GetPhysicalScreenSize()
	local scale = min(1.15, 768/screenHeight)
	-- scale = math.ceil(scale * 10) / 10
	local multiplier = 768/screenHeight/scale
	print(scale, multiplier)

	if ( InCombatLockdown()) then
		bdCore.pixeler:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		-- Alt tabbing in combat breaks scale on large resolutions
		if (event == "PLAYER_REGEN_ENABLED") then
			bdCore.pixeler:UnregisterEvent("PLAYER_REGEN_ENABLED")
			
			-- if scale and (scale < 0.64) then
				-- UIParent:SetScale(scale)
			-- end
		end

		print(event)
		-- Only set these once
		if (event == "PLAYER_LOGIN") then
			bdCore.pixeler:UnregisterEvent(event)
			SetCVar("useUiScale", 1);
			SetCVar("uiScaleMultipler", multiplier);
			SetCVar("uiScale", scale);
		end

		-- blizzard for real, why make this the limit? people have big monitors these days
		-- UIParent:SetScale(scale)
		-- if (scale < 0.64) then
		-- end
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
--]]

bdCore.pixeler = CreateFrame("frame", nil, UIParent)
bdCore.pixeler:RegisterEvent("PLAYER_LOGIN")
bdCore.pixeler:RegisterEvent("UI_SCALE_CHANGED")
-- bdCore.pixeler:RegisterEvent("PLAYER_ENTERING_WORLD")
bdCore.pixeler:SetScript("OnEvent", bdCore.pixelPerfection)