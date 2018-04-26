local bdCore, c, f = select(2, ...):unpack()
local media = bdCore.media

bdCore:hookEvent("loaded_bdcore", function()
	local powerbar = CreateFrame('StatusBar', 'bdCore Alt Power', UIParent)
	powerbar:SetStatusBarTexture(media.flat)
	powerbar:SetMinMaxValues(0,200)
	powerbar:SetSize(200, 20)
	powerbar:SetStatusBarColor(.2, .4, 0.8, 1)
	powerbar:SetPoint("CENTER",UIParent,"CENTER", 0, 0)
	powerbar:Hide()
	bdCore:setBackdrop(powerbar)
	bdCore:makeMovable(powerbar)
	
	powerbar.text = powerbar:CreateFontString(nil,"OVERLAY")
	powerbar.text:SetFont(media.font, 13, "THINOUTLINE")
	powerbar.text:SetPoint("CENTER", powerbar, "CENTER")
	powerbar.text:SetJustifyH("CENTER")

	--Event handling
	if (bdCore.isBFA) then
		powerbar:RegisterEvent("UNIT_POWER_UPDATE")
	else
		powerbar:RegisterEvent("UNIT_POWER")
	end
	-- powerbar:RegisterEvent("UNIT_POWER_BAR_SHOW")
	-- powerbar:RegisterEvent("UNIT_POWER_BAR_HIDE")
	powerbar:RegisterEvent("PLAYER_ENTERING_WORLD")
	powerbar:EnableMouse(false)
	powerbar:SetScript("OnEvent", function(self, event, arg1)
		-- print(CombatLogGetCurrentEventInfo())
		if (not c.persistent.General.alteratepowerbar) then 
			PlayerPowerBarAlt:RegisterEvent("UNIT_POWER_BAR_SHOW")
			PlayerPowerBarAlt:RegisterEvent("UNIT_POWER_BAR_HIDE")
			PlayerPowerBarAlt:RegisterEvent("PLAYER_ENTERING_WORLD")
			if (event == "UNIT_POWER_BAR_SHOW") then
				PlayerPowerBarAlt:Show()
			end
			
			self:Hide()
			
			return
		else
			PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
			PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
			PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")
			PlayerPowerBarAlt:Hide()
			if UnitAlternatePowerInfo("player") or UnitAlternatePowerInfo("target") then
				self:Show()
				
				self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
				local power = UnitPower("player", ALTERNATE_POWER_INDEX)
				local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
				self:SetValue(power)
				self.text:SetText(power.."/"..mpower)
			else
				self:Hide()
			end
		end
	end)
end)