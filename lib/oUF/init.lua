local parent, ns = ...

-- this probably doesn't work, because it's not virtual
oUF_ClickCastUnitTemplate = CreateFrame("Button", "oUF_ClickCastUnitTemplate", nil, "SecureUnitButtonTemplate, SecureHandlerStateTemplate, SecureHandlerEnterLeaveTemplate")
oUF_ClickCastUnitTemplate:SetAttribute("_onenter", [[ local snippet = self:GetAttribute('clickcast_onenter'); if snippet then self:Run(snippet) end ]])
oUF_ClickCastUnitTemplate:SetAttribute("_onleave", [[ local snippet = self:GetAttribute('clickcast_onleave'); if snippet then self:Run(snippet) end ]])
oUF_ClickCastUnitTemplate:SetAttribute("refreshUnitChange", [[ local unit = self:GetAttribute('unit'); if unit then RegisterStateDriver(self, 'vehicleui', ('[@oUF_ClickCastUnitTemplatethasvehicleui]vehicle; novehicle'):format(unit)) else UnregisterStateDriver(self, 'vehicleui') end ]])
oUF_ClickCastUnitTemplate:SetAttribute("_onstate-vehicleui", [[ local unit = self:GetAttribute('unit'); if unit and newstate == 'vehicle' and UnitPlayerOrPetInRaid(unit) and not UnitTargetsVehicleInRaidUI(unit) then self:SetAttribute('toggleForVehicle', false) else self:SetAttribute('toggleForVehicle', true) end ]])

ns.oUF = {}
ns.oUF.Private = {}
