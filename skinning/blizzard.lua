local bdCore, c, f = select(2, ...):unpack()

-- kill the needlessly long Azerite animations
if not (IsAddOnLoaded("Blizzard_AzeriteUI")) then
    UIParentLoadAddOn("Blizzard_AzeriteUI")
end

local azeriteAnimation = CreateFrame("frame", nil, UIParent)
azeriteAnimation:RegisterEvent("AZERITE_EMPOWERED_ITEM_LOOTED")
azeriteAnimation:SetScript("OnEvent", function(self, event, ...)
	local item = ...
	local itemId = GetItemInfoFromHyperlink(item)
	local bag
	local slot
	
	C_Timer.After(0.4,function() 
		for i = 0, NUM_BAG_SLOTS do
			for j = 1, GetContainerNumSlots(i) do
				local id = GetContainerItemID(i,j)
				if id and id == itemId then
					slot = j
					bag = i
				end
			end
		end
		
		if slot then
			local ItemLocation = AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItemLocation()
			local location = ItemLocation:CreateFromBagAndSlot(bag,slot)
			
			C_AzeriteEmpoweredItem.SetHasBeenViewed(location)
			C_AzeriteEmpoweredItem.HasBeenViewed(location)
		end
	end)

end)

hooksecurefunc(AzeriteEmpoweredItemUI,"OnItemSet",function(self)
	local itemLocation = self.azeriteItemDataSource:GetItemLocation()
	if self:IsAnyTierRevealing() then
		C_Timer.After(0.7,function() 
			OpenAzeriteEmpoweredItemUIFromItemLocation(itemLocation)
		end)
	end
end)