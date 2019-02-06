local bdCore, c, f = select(2, ...):unpack()

local gmotd = CreateFrame("frame", nil, UIParent)
gmotd:SetSize(350, 150)
gmotd:Hide()
gmotd:SetPoint("TOP", UIParent, "TOP", 0, -140)
bdCore:setBackdrop(gmotd)
gmotd.header = gmotd:CreateFontString(nil)
gmotd.header:SetFont(bdCore.media.font, 14)
gmotd.header:SetPoint("BOTTOM", gmotd, "TOP", 0, 4)

gmotd.text = gmotd:CreateFontString(nil)
gmotd.text:SetHeight(130)
gmotd.text:SetPoint("TOPLEFT", gmotd, "TOPLEFT", 10, -10)
gmotd.text:SetPoint("TOPRIGHT", gmotd, "TOPRIGHT", -10, -10)
gmotd.text:SetJustifyV("TOP")
gmotd.text:SetFont(bdCore.media.font, 13)
gmotd.text:SetTextColor(0, 1, 0)
gmotd.text:CanWordWrap(true)
gmotd.text:SetWordWrap(true)

gmotd.button = CreateFrame("Button", nil, gmotd)
gmotd.button:SetText("Got it");
bdCore:skinButton(gmotd.button,false)
gmotd.button:SetPoint("TOP", gmotd, "BOTTOM", 0, -4)
gmotd.button:SetScript("OnClick",function(self)
	c.persistent.bdAddons.gmotd[gmotd.msg] = true
	gmotd:Hide()
end)

bdCore:hookEvent('loaded_bdcore', function()
	gmotd:RegisterEvent("GUILD_MOTD")
	gmotd:RegisterEvent("GUILD_ROSTER_UPDATE")
	gmotd:SetScript("OnEvent", function(self, event, message)

		if (not c.persistent.bdAddons.skingmotd) then return end
		
		local guild = false
		local msg = false
		if (event == "GUILD_MOTD") then
			msg = message
			guild = select(1, GetGuildInfo("player"))
		else
			msg = GetGuildRosterMOTD()
			guild = select(1, GetGuildInfo("player"))
		end
		
		c.persistent.bdAddons.gmotd = c.persistent.bdAddons.gmotd or {}
		if (msg and guild and not c.persistent.bdAddons.gmotd[msg]) then
			gmotd.msg = msg
			gmotd.text:SetText(msg)
			gmotd.header:SetText(guild.." - Message of the Day")
			gmotd:Show()
			local numlines = gmotd.text:GetNumLines()
			gmotd:SetHeight(20+(12.2*numlines))
		end
	end)
end)