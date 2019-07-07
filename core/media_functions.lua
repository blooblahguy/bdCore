local bdCore, c, f = select(2, ...):unpack()

-- load oUF
local engine = select(2, ...)
bdCore.oUF = engine.oUF


-- viewports
local function createViewport() 
	local frame = CreateFrame("frame", "bdCore Top Viewport", nil)
	frame:SetBackdrop({bgFile = bdCore.media.flat})
	frame:SetBackdropBorderColor(0,0,0,0)
	frame:SetFrameStrata("BACKGROUND")

	return frame
end
bdCore:hookEvent("bdcore_redraw",function()
	local config = c.persistent.bdAddons

	local screenWidth, screenHeight = GetPhysicalScreenSize()
	local scale = min(1.15, 768/screenHeight)

	local top = 0
	local bottom = 0

	bdCore.topViewport = bdCore.topViewport or createViewport()
	bdCore.topViewport:SetBackdropColor(unpack(config.topViewportBGColor))
	bdCore.topViewport:SetPoint("TOPLEFT", UIParent, "TOPLEFT")
	bdCore.topViewport:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT")
	bdCore.topViewport:SetHeight(config.topViewport)
	if (config.topViewport <= 0) then
		bdCore.topViewport:Hide()
	end

	top = config.topViewport

	bdCore.bottomViewport = bdCore.bottomViewport or createViewport()
	bdCore.bottomViewport:SetBackdropColor(unpack(config.bottomViewportBGColor))
	bdCore.bottomViewport:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT")
	bdCore.bottomViewport:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
	bdCore.bottomViewport:SetHeight(config.bottomViewport)
	if (config.bottomViewport <= 0) then
		bdCore.bottomViewport:Hide()
	end

	bottom = config.bottomViewport


	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT", 0, -( top * scale ) )
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, ( bottom * scale ) )
end)

-- get media
function bdCore:getMedia(type, name)
	if (type == "font") then
		return bdCore.media.fonts[name]
	end
	if (type == "background") then
		return bdCore.media.backgrounds[name]
	end
end

-- Skin Button
function bdCore:skinButton(f,small,color)
	local colors = bdCore.media.backdrop
	local hovercolors = {0,0.55,.85,1}
	if (color == "red") then
		colors = {.6,.1,.1,0.6}
		hovercolors = {.6,.1,.1,1}
	elseif (color == "blue") then
		colors = {0,0.55,.85,0.6}
		hovercolors = {0,0.55,.85,1}
	elseif (color == "dark") then
		colors = bdCore.backdrop
		hovercolors = {.1,.1,.1,1}
	end
	f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2, insets = {left=2,top=2,right=2,bottom=2}})
	f:SetBackdropColor(unpack(colors)) 
    f:SetBackdropBorderColor(unpack(bdCore.media.border))
    f:SetNormalFontObject("bdCore.font")
	f:SetHighlightFontObject("bdCore.font")
	f:SetPushedTextOffset(0,-1)
	f:SetScale(1)
	
	f:SetWidth(f:GetTextWidth()+22)
	
	--if (f:GetWidth() < 24) then
	if (small and f:GetWidth() <= 24 ) then
		f:SetWidth(20)
	end
	
	if (small) then
		f:SetHeight(18)
	else
		f:SetHeight(28)
	end
	
	f:HookScript("OnEnter", function(f) 
		f:SetBackdropColor(unpack(hovercolors)) 
	end)
	f:HookScript("OnLeave", function(f) 
		f:SetBackdropColor(unpack(colors)) 
	end)
	
	return true
end

function bdCore:colorGradient(perc)
	if perc > 1 then perc = 1 end

	local segment, realperc = math.modf(perc*2)
	r1, g1, b1, r2, g2, b2 = unpack({1, 0, 0,1, 1, 0,0, 1, 0,0, 0, 0}, (segment * 3) + 1)
	return r1 + (r2-r1)*realperc, g1 + (g2-g1)*realperc, b1 + (b2-b1)*realperc
end

-- return class color
function bdCore:unitColor(unitToken)
	if not UnitExists(unitToken) then
		return unpack(bUI.media.unitColors.tapped)
	end
	
	if UnitIsPlayer(unitToken) then
		return unpack(bUI.media.unitColors.class[select(2, UnitClass(unitToken))])
	elseif UnitIsTapped(unitToken) and not UnitIsTappedByPlayer(unitToken) then
		return unpack(bUI.media.unitColors.tapped)
	else
		return unpack(bUI.media.unitColors.reaction[UnitReaction(unitToken, 'player')])
	end
end

-- xform r, g, b into rrggbb
function bdCore:RGBToHex(r, g, b)
	if type(r) ~= 'number' then
		r, g, b = unpack(r)
	end
	
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format('%02x%02x%02x', r*255, g*255, b*255)
end

function bdCore:RGBPercToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

-- borders / spacing
function bdCore:get_border(frame)
	local borderSize = c.persistent.bdAddons.border
	local screenheight = select(2, GetPhysicalScreenSize())
	local scale = 768 / screenheight
	local frame_scale = frame:GetEffectiveScale()
	local pixel = scale / frame_scale
	local border = pixel * borderSize

	return border
end

function bdCore:set_border(frame, type)
	local border = bdNameplates:get_border(frame)

	if (not frame.background) then
		frame.background = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
		frame.background:SetTexture(bdCore.media.flat)
		frame.background:SetVertexColor(unpack(bdCore.media.backdrop))
		frame.background.SetFrameLevel = bdCore.noop
		frame.border = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
		frame.border:SetTexture(bdCore.media.flat)
		frame.border:SetVertexColor(unpack(bdCore.media.border))
		frame.border.SetFrameLevel = bdCore.noop
	end

	frame.border:SetPoint("TOPLEFT", frame, "TOPLEFT", -border, border)
	frame.border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", border, -border)
	frame.background:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	frame.background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
end

-- make it purdy
function bdCore:setBackdrop(frame, resize, padding)
	if (frame.background) then return end
	padding = padding or 0
	local border = 2
	if (c and c.persistent and not c.persistent.bdAddons.forcescale) then
		border = bdCore.pixel * border
		-- print("useful border")
	end

	frame.background = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
	frame.background:SetTexture(bdCore.media.flat)
	frame.background:SetPoint("TOPLEFT", frame, "TOPLEFT", -padding, padding)
	frame.background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", padding, -padding)
	frame.background:SetVertexColor(unpack(bdCore.media.backdrop))
	frame.background.protected = true
	frame.background.SetFrameLevel = bdCore.noop
	
	frame.border = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
	frame.border:SetTexture(bdCore.media.flat)
	frame.border:SetPoint("TOPLEFT", frame, "TOPLEFT", -(padding + border), (padding + border))
	frame.border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", (padding + border), -(padding + border))
	frame.border:SetVertexColor(unpack(bdCore.media.border))
	frame.border.SetFrameLevel = bdCore.noop
	frame.border.protected = true

	bd_add_action("bdcore_redraw,addon_loaded", function()
		border = c.persistent.bdAddons.border
		local background = bdCore:getMedia("background", c.persistent.bdAddons.background)
		if (c and c.persistent and not c.persistent.bdAddons.forcescale) then
			border = bdCore.pixel * border
		end
		-- local font = bdCore:getMedia("font", c.persistent.bdAddons.font)

		frame.background:SetTexture(background)
		frame.border:ClearAllPoints()
		frame.border:SetPoint("TOPLEFT", frame, "TOPLEFT", -(padding + border), (padding + border))
		frame.border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", (padding + border), -(padding + border))
	end)
end

function bdCore:createShadow(f,offset)
	if f.Shadow then return end
	
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -offset, offset)
	shadow:SetPoint("BOTTOMLEFT", -offset, -offset)
	shadow:SetPoint("TOPRIGHT", offset, offset)
	shadow:SetPoint("BOTTOMRIGHT", offset, -offset)
	shadow:SetAlpha(0.7)
	
	shadow:SetBackdrop( { 
		edgeFile = bdCore.media.shadow, edgeSize = offset,
		insets = {left = offset, right = offset, top = offset, bottom = offset},
	})
	
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.8)
	f.Shadow = shadow
end

function bdCore:StripTextures(Object, Text)
	for i = 1, Object:GetNumRegions() do
		local region = select(i, Object:GetRegions())

		if (not region.protected) then
			if region:GetObjectType() == "Texture" then
				region:SetTexture(nil)
				region.Show = function() end
				region:SetAlpha(0)
			elseif (Text) then
				region:Hide(0)
				region.Show = function() end
				region:SetAlpha(0)
			end
		end
	end	
end

function bdCore:SkinButton(Frame, Strip)
	if Frame:GetName() then
		local Left = _G[Frame:GetName().."Left"]
		local Middle = _G[Frame:GetName().."Middle"]
		local Right = _G[Frame:GetName().."Right"]


		if Left then Left:SetAlpha(0) end
		if Middle then Middle:SetAlpha(0) end
		if Right then Right:SetAlpha(0) end
	end

	if Frame.Left then Frame.Left:SetAlpha(0) end
	if Frame.Right then Frame.Right:SetAlpha(0) end	
	if Frame.Middle then Frame.Middle:SetAlpha(0) end
	if Frame.SetNormalTexture then Frame:SetNormalTexture("") end	
	if Frame.SetHighlightTexture then Frame:SetHighlightTexture("") end
	if Frame.SetPushedTexture then Frame:SetPushedTexture("") end	
	if Frame.SetDisabledTexture then Frame:SetDisabledTexture("") end
	
	if Strip then StripTextures(Frame) end
	
	--Frame:SetTemplate()
	
	Frame:HookScript("OnEnter", function(self)
		local Color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		
		self:SetBackdropColor(Color.r * .15, Color.g * .15, Color.b * .15)
		self:SetBackdropBorderColor(Color.r, Color.g, Color.b)	
	end)
	
	Frame:HookScript("OnLeave", function(self)
		local Color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		
		self:SetBackdropColor(unpack(bdCore.media.backdrop))
		self:SetBackdropBorderColor(unpack(bdCore.media.border))	
	end)
end
