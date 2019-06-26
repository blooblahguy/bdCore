local parent, ns = ...
local oUF = ns.oUF or oUF
 
local function Update(self, event, unit)
	--print(self,event,unit,arg1)
	if(self.unit ~= unit) then return end
	
	local ta = self.TotalAbsorb
	local ha = self.HealAbsorb
	if(ta.PreUpdate) then ta:PreUpdate(unit) end
	if(ha and ha.PreUpdate) then ha:PreUpdate(unit) end
 
	local allAbsorbs = UnitGetTotalAbsorbs(unit) or 0
	local healAbsorbs = UnitGetTotalHealAbsorbs(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
 
	--[[if(health + allAbsorbs > maxHealth * ta.maxOverflow) then
		allAbsorbs = maxHealth * ta.maxOverflow - health
	end--]]
 
	ta:SetMinMaxValues(0, maxHealth)
	ta:SetValue(allAbsorbs)
	ta:Show()
	if (ha) then
		ha:SetMinMaxValues(0, maxHealth)
		ha:SetValue(healAbsorbs)
		ha:SetReverseFill(true)
		ha:Show()
	end
 
	if(ta.PostUpdate) then
		return ta:PostUpdate(unit)
	end
end
 
local function Path(self, ...)
	return (self.TotalAbsorb.Override or Update) (self, ...)
end
 
local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end
 
local function Enable(self)
	local ta = self.TotalAbsorb
	local ha = self.HealAbsorb
	if(ta) then
		ta.__owner = self
		ta.ForceUpdate = ForceUpdate
		if (ha) then
			ha.__owner = self
			ha.ForceUpdate = ForceUpdate
		end
 
		self:RegisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:RegisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)
		self:RegisterEvent('UNIT_HEALTH', Path)
 
		if(ta and ta:IsObjectType'StatusBar' and not ta:GetStatusBarTexture()) then
			ta:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
 
		return true
	end
end
 
local function Disable(self)
	local ta = self.TotalAbsorb
	local ha = self.HealAbsorb
	if(ta) then
		self:UnregisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH', Path)
	end
end
 
oUF:AddElement('TotalAbsorb', Path, Enable, Disable)
