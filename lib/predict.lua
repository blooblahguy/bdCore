local parent, ns = ...
local oUF = ns.oUF or oUF
 
local function Update(self, event, unit)
	--print(self,event,unit,arg1)
	if(self.unit ~= unit) then return end
	
	local predict = self.HealPredict
	if(predict.PreUpdate) then predict:PreUpdate(unit) end
 
	local incoming = UnitGetIncomingHeals(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
	
	local remaining = maxHealth - health
	if (incoming > remaining) then
		incoming = remaining
	end
	
	local location = (health / maxHealth) or 0
	location = self.Health:GetWidth() * location
	predict:ClearAllPoints()
	predict:SetWidth(self.Health:GetWidth())
	predict:SetPoint("LEFT", self.Health, "LEFT", location, 0)
	predict:SetPoint("TOP", self.Health, "TOP")
	predict:SetPoint("BOTTOM", self.Health, "BOTTOM")
	
	predict:SetMinMaxValues(0, maxHealth)
	predict:SetValue(incoming)
	predict:Show()

	if(predict.PostUpdate) then
		return predict:PostUpdate(unit)
	end
end
 
local function Path(self, ...)
	return (self.HealPredict.Override or Update) (self, ...)
end
 
local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end
 
local function Enable(self)
	local predict = self.HealPredict
	if(predict) then
		predict.__owner = self
		predict.ForceUpdate = ForceUpdate
 
		self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
 
		if(predict and predict:IsObjectType'StatusBar' and not predict:GetStatusBarTexture()) then
			predict:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
 
		return true
	end
end
 
local function Disable(self)
	local predict = self.HealPredict
	if(predict) then
		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
		self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
	end
end
 
oUF:AddElement('HealPredict', Path, Enable, Disable)
