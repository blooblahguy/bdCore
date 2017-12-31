local bdCore, c, f = select(2, ...):unpack()

local font = CreateFrame("Frame")

local function SetFont(self, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	self:SetFont(font, size, style)
	
	if sr and sg and sb then
		self:SetShadowColor(sr, sg, sb)
	end
	
	if sox and soy then
		self:SetShadowOffset(sox, soy)
	end
	
	if r and g and b then
		self:SetTextColor(r, g, b)
	elseif r then
		self:SetAlpha(r)
	end
end

--local NORMAL = C.Medias.Font
--local COMBAT = C.Medias.DamageFont
--local NUMBER = C.Medias.Font


-- local COMBAT = [[Interface\AddOns\bUI\core\font.ttf]]
-- local NUMBER = [[Interface\AddOns\bUI\core\font.ttf]]

UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
CHAT_FONT_HEIGHTS = {12, 13, 14, 15, 16, 17, 18, 19, 20}

local function changeFonts()
	if (not c.persistent.General.changefonts) then return end

	local font = bdCore:getMedia("font", c.persistent.General.font )

	local NORMAL = font
	local COMBAT = font
	local NUMBER = font
	
	UNIT_NAME_FONT = NORMAL
	DAMAGE_TEXT_FONT = COMBAT
	STANDARD_TEXT_FONT = NORMAL

	SetFont(GameTooltipHeader, NORMAL, 14)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, 14, "OUTLINE")
	SetFont(NumberFont_Outline_Huge, NUMBER, 28, "THICKOUTLINE", 28)
	SetFont(NumberFont_Outline_Large, NUMBER, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med, NUMBER, 15, "OUTLINE")
	SetFont(NumberFont_Shadow_Med, NORMAL, 14)
	SetFont(NumberFont_Shadow_Small, NORMAL, 14)
	SetFont(QuestFont, NORMAL, 14)
	SetFont(QuestFont_Large, NORMAL, 14)
	SetFont(SystemFont_Large, NORMAL, 17)
	SetFont(SystemFont_Med1, NORMAL, 14)
	SetFont(SystemFont_Med3, NORMAL, 10)
	SetFont(SystemFont_OutlineThick_Huge2, NORMAL, 22, "THICKOUTLINE")
	SetFont(SystemFont_Outline_Small, NUMBER, 14, "OUTLINE")
	SetFont(SystemFont_Shadow_Large, NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1, NORMAL, 14)
	SetFont(SystemFont_Shadow_Med3, NORMAL, 15)
	SetFont(SystemFont_Shadow_Outline_Huge2, NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small, NORMAL, 13)
	SetFont(SystemFont_Small, NORMAL, 14)
	SetFont(SystemFont_Tiny, NORMAL, 14)
	SetFont(Tooltip_Med, NORMAL, 14)
	SetFont(Tooltip_Small, NORMAL, 14)
	SetFont(CombatTextFont, NORMAL, 200, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1, NORMAL, 22, "THINOUTLINE")
	SetFont(ZoneTextString, NORMAL, 32, "OUTLINE")
	SetFont(SubZoneTextString, NORMAL, 27, "OUTLINE")
	SetFont(PVPInfoTextString, NORMAL, 24, "THINOUTLINE")
	SetFont(PVPArenaTextString, NORMAL, 24, "THINOUTLINE")
	SetFont(FriendsFont_Normal, NORMAL, 14)
	SetFont(FriendsFont_Small, NORMAL, 13)
	SetFont(FriendsFont_Large, NORMAL, 14)
	SetFont(FriendsFont_UserText, NORMAL, 13)
end

-- Base fonts
bdCore:hookEvent("loaded_bdcore", changeFonts)
bdCore:hookEvent("bdcore_redraw", changeFonts)

