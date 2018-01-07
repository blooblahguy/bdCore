local bdCore, c, f = select(2, ...):unpack()

local wa_skin = CreateFrame("Frame")
wa_skin:RegisterEvent("ADDON_LOADED")
wa_skin:SetScript("OnEvent", function(self, event,addon)
    if (event == "ADDON_LOADED" and not addon == "WeakAuras") then return end
	
	local flat = "Interface\\Buttons\\WHITE8x8"
	local font = bdCore.media.font --"fonts\\ARIALN.ttf"

	local function Skin_WeakAuras(frame)
		--[[if (frame.SetBackdropColor) then
			frame:SetBackdrop({bgFile = flat, edgeFile = flat, edgeSize = 2})
			frame:SetBackdropColor(0,0,0,0.1)
			frame:SetBackdropBorderColor(0,0,0,1)
		end--]]

		if frame.icon then
			frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			frame.icon.SetTexCoord = function() return end
			if frame.border and not frame.bar then
				frame.border:Hide()
			end
		end

		--[[
		if frame.bar then
			if (frame.bar.fg:GetTexture()) then
				frame.bar.fg:SetTexture(flat)

				frame.bar.fg.SetColor = frame.bar.fg.SetVertexColor
				frame.bar.fg.SetNewColor = function(self, r, g, b)
					frame.bar.fg:SetColor(r/2, g/2, b/2)
				end

				local r, g, b = frame.bar.fg:GetVertexColor()
				frame.bar.fg:SetNewColor(r, g, b)

			end

			if (frame.bar.bg:GetTexture()) then
			end
		end--]]

		if frame.stacks then
			local fontHeight = select(3, frame.stacks:GetFont())
			if (not tonumber(fontHeight) or not fontHeight >0) then fontHeight = 14 end
			frame.stacks:SetFont(font, fontHeight, "OUTLINE")
		end

		if frame.timer then
			local fontHeight = select(3, frame.timer:GetFont())
			if (not tonumber(fontHeight) or not fontHeight >0) then fontHeight = 14 end
			frame.timer:SetFont(font, fontHeight, "OUTLINE")
		end

		if frame.text then
			local fontHeight = select(3, frame.text:GetFont())
			if (not tonumber(fontHeight) or not fontHeight >0) then fontHeight = 18 end
			frame.text:SetFont(font, fontHeight, "OUTLINE")
		end
		if frame.cooldown then
			local fontHeight = select(3, frame.cooldown:GetRegions():GetFont())
			if (not tonumber(fontHeight) or not fontHeight >0) then fontHeight = 14 end
			frame.cooldown:GetRegions():SetFont(font, fontHeight, "OUTLINE")
		end
	end

	if (WeakAuras) then
		for weakAura, v in pairs(WeakAuras.regions) do
			if (c.persistent.General.skinwas) then
				if (WeakAuras.regions[weakAura].regionType == "icon" or WeakAuras.regions[weakAura].regionType == "aurabar") then
					--print(WeakAuras.regions[weakAura].region)
					Skin_WeakAuras(WeakAuras.regions[weakAura].region)
				end
			end
		end
	end
	
end)
