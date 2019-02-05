local bdCore, c, f = select(2, ...):unpack()
-- double click buyout
local dcbo = CreateFrame('frame')

local lastClickTime = nil
local lastBrowseClicked = nil

dcbo:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
dcbo:RegisterEvent("ADDON_LOADED")

function dcbo:ADDON_LOADED(event, addon)
	if addon ~= "Blizzard_AuctionUI" then return end
	self:UnregisterEvent(event)

	for i = 1, NUM_BROWSE_TO_DISPLAY do
		local browseButton = _G["BrowseButton"..i]
		local browseButtonOnClick = browseButton:GetScript("OnClick")

		browseButton:SetScript("PostClick", function(self)
			if (not c.persistent.bdAddons.doubleclickbo) then 
				browseButtonOnClick(self)

				lastBrowseClicked = browseClicked
				lastClickTime = currentTime
				return
			end
			
			--browseButtonOnClick(self)
			--[[if (IsShiftKeyDown()) then
				PlaceAuctionBid(AuctionFrame.type, GetSelectedAuctionItem(AuctionFrame.type), AuctionFrame.buyoutPrice)
			end--]]
			
			local currentTime, browseClicked = GetTime(), self:GetID()
			if lastClickTime and (currentTime - lastClickTime) < 0.5 and lastBrowseClicked and lastBrowseClicked == browseClicked then
				PlaceAuctionBid(AuctionFrame.type, GetSelectedAuctionItem(AuctionFrame.type), AuctionFrame.buyoutPrice)

				lastBrowseClicked = nil
				lastClick = nil
			else
				browseButtonOnClick(self)

				lastBrowseClicked = browseClicked
				lastClickTime = currentTime
			end
		end)
	end
end