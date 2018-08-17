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

-- Open new communities pane to roster rather than chat
-- Credit to Nnogga
local commOpen = CreateFrame("frame", nil, UIParent)
commOpen:RegisterEvent("ADDON_LOADED")
commOpen:RegisterEvent("CHANNEL_UI_UPDATE")
commOpen:SetScript("OnEvent", function(self, event, addonName)    
    if event == "ADDON_LOADED" and addonName == "Blizzard_Communities" then
        --create overlay
        local f = CreateFrame("Button",nil,UIParent)
        f:SetFrameStrata("HIGH")
        f.tex = f:CreateTexture(nil, "BACKGROUND")
        f.tex:SetAllPoints()
        f.tex:SetColorTexture(0.1,0.1,0.1,1)
        f.text = f:CreateFontString()
        f.text:SetFontObject("GameFontNormalMed3")
        f.text:SetText("Chat Hidden. Click to show")
        f.text:SetTextColor(1, 1, 1, 1)
        f.text:SetJustifyH("CENTER")
        f.text:SetJustifyV("CENTER")
        f.text:SetHeight(20)
        f.text:SetPoint("CENTER",f,"CENTER",0,0)
        f:EnableMouse(true)
        f:RegisterForClicks("AnyUp")
        f:SetScript("OnClick",function(...)
                f:Hide()
        end)
        --toggle
        local function toggleOverlay()       
            if CommunitiesFrame:GetDisplayMode() == COMMUNITIES_FRAME_DISPLAY_MODES.CHAT then
                f:SetAllPoints(CommunitiesFrame.Chat.InsetFrame)
                f:Show()
            else
                f:Hide()
            end
        end
        local function hideOverlay()
            f:Hide()  
        end        
        toggleOverlay() --run once
        
        --hook        
        hooksecurefunc(CommunitiesFrame,"SetDisplayMode", toggleOverlay)
        hooksecurefunc(CommunitiesFrame,"Show",toggleOverlay)
        hooksecurefunc(CommunitiesFrame,"Hide",hideOverlay)
        hooksecurefunc(CommunitiesFrame,"OnClubSelected", toggleOverlay)        
    end
end)