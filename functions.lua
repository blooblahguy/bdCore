local bdCore, c, f = select(2, ...):unpack()

-- get media
function bdCore:getMedia(type, name)
	if (type == "font") then
		return bdCore.media.fonts[name]
	end
	if (type == "background") then
		return bdCore.media.backgrounds[name]
	end
end

-- return simple arrow buttons for positioners


bdCore.moving = false
bdCore.moveFrames = {}
-- add to our movable list
function bdCore:makeMovable(frame,resize,name)
	if not resize then resize = true end
	local border = c.persistent['General'].border
	if (not name) then
		name = frame:GetName();
	end
	local height = frame:GetHeight()
	local width = frame:GetWidth()
	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	relativeTo = relativeTo:GetName()

	local moveContainer = CreateFrame("frame", "bdCore_"..name, UIParent)
	moveContainer.text = moveContainer:CreateFontString(moveContainer:GetName().."_Text")
	moveContainer.frame = frame
	frame.moveContainer = moveContainer
	if (resize) then
		hooksecurefunc(frame,"SetSize",function() 
			local height = frame:GetHeight()
			local width = frame:GetWidth()
			moveContainer:SetSize(width+2+border, height+2+border)
		end)
	end
	moveContainer:SetSize(width+4, height+4)
	moveContainer:SetBackdrop({bgFile = bdCore.media.flat, edgeFile = bdCore.media.flat, edgeSize = 1})
	moveContainer:SetBackdropColor(0,0,0,.8)
	moveContainer:SetBackdropBorderColor(unpack(bdCore.media.blue))
	moveContainer:SetFrameStrata("BACKGROUND")
	moveContainer:SetClampedToScreen(true)
	moveContainer:SetAlpha(0)

	moveContainer.controls = CreateFrame("frame", nil, moveContainer)
	local cont = moveContainer.controls
	cont:SetSize(150, 25)
	cont:Hide()

	cont.position = function(self)
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()

		local x, y = "RIGHT", "TOP"
		self:ClearAllPoints()
		if (relativePoint == "RIGHT" or relativePoint == "TOPRIGHT" or relativePoint == "BOTTOMRIGHT") then
			x = "RIGHT"
		elseif (relativePoint == "LEFT" or relativePoint == "TOPLEFT" or relativePoint == "BOTTOMLEFT") then
			x = "LEFT"
		end

		if (relativePoint == "TOPLEFT" or relativePoint == "TOP" or relativePoint == "TOPRIGHT") then
			y = "BOTTOM"
		elseif (relativePoint == "BOTTOMLEFT" or relativePoint == "BOTTOM" or relativePoint == "BOTTOMRIGHT") then
			y = "TOP"
		end

		sy = "TOP"
		if (y == "TOP") then
			sy = "BOTTOM"
		end

		self:SetPoint(sy..x, moveContainer, y..x, 0, 0)
	end
	local function makeButton()
		local button = CreateFrame("button", nil, cont)
		button:SetSize(25,25)
		button:SetBackdrop({bgFile = bdCore.media.flat, edgeFile = bdCore.media.flat, edgeSize = 1})
		button:SetBackdropColor(unpack(bdCore.media.backdrop))
		button:SetBackdropBorderColor(unpack(bdCore.media.border))

		button.tex = button:CreateTexture(nil, "OVERLAY")
		button.tex:SetTexture(bdCore.media.arrowdown)
		button.tex:SetPoint("CENTER")
		button.tex:SetSize(12, 12)

		button:SetScript("OnEnter", function()
			button:SetBackdropColor(unpack(bdCore.media.blue))
			cont:Show()
		end)
		button:SetScript("OnLeave", function()
			button:SetBackdropColor(unpack(bdCore.media.backdrop))
			cont:Hide()
		end)

		return button
	end

	cont.left = makeButton()
	cont.left:SetPoint("LEFT", cont, "LEFT", 0, 0)
	cont.left.tex:SetRotation(-1.5708)
	cont.left:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		if (IsShiftKeyDown()) and IsControlKeyDown() then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs-20, yOfs)
		elseif (IsShiftKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs-5, yOfs)
		else
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs-1, yOfs)
		end
		moveContainer:dragStop()
	end)

	cont.up = makeButton()
	cont.up:SetPoint("LEFT", cont.left, "RIGHT", 0, 0)
	cont.up.tex:SetRotation(3.14159)
	cont.up:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		if (IsShiftKeyDown() and IsControlKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs+20)
		elseif (IsShiftKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs+5)
		else
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs+1)
		end
		moveContainer:dragStop()
	end)

	cont.down = makeButton()
	cont.down:SetPoint("LEFT", cont.up, "RIGHT", 0, 0)
	cont.down.tex:SetRotation(0)
	cont.down:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		if (IsShiftKeyDown() and IsControlKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-20)
		elseif (IsShiftKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-5)
		else
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-1)
		end
		moveContainer:dragStop()
	end)

	

	cont.right = makeButton()
	cont.right:SetPoint("LEFT", cont.down, "RIGHT", 0, 0)
	cont.right.tex:SetRotation(1.5708)
	cont.right:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		if (IsShiftKeyDown() and IsControlKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs+20, yOfs)
		elseif (IsShiftKeyDown()) then
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs+5, yOfs)
		else
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs+1, yOfs)
		end
		moveContainer:dragStop()
	end)

	cont.center_h = makeButton()
	cont.center_h:SetPoint("LEFT", cont.right, "RIGHT", 0, 0)
	cont.center_h.tex2 = cont.center_h:CreateTexture(nil, "OVERLAY")
	cont.center_h.tex2:SetTexture(bdCore.media.arrowdown)
	cont.center_h.tex2:SetPoint("RIGHT", -4, 0)
	cont.center_h.tex2:SetSize(8, 12)
	cont.center_h.tex2:SetRotation(-1.5708)
	cont.center_h.tex:SetSize(8, 12)
	cont.center_h.tex:ClearAllPoints()
	cont.center_h.tex:SetPoint("LEFT", 4, 0)
	cont.center_h.tex:SetRotation(1.5708)
	cont.center_h:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		local width, height = moveContainer:GetSize()
		local s_width, s_height = GetPhysicalScreenSize()

		moveContainer:ClearAllPoints()
		if (point == "LEFT" or point == "TOPLEFT" or point == "BOTTOMLEFT") then
			moveContainer:SetPoint(point, UIParent, point, ((s_width / 2) - (width / 2)), yOfs)
		elseif (point == "CENTER" or point == "TOP" or point == "BOTTOM") then
			moveContainer:SetPoint(point, UIParent, point, 0, yOfs)
		elseif (point == "RIGHT" or point == "TOPRIGHT" or point == "BOTTOMRIGHT") then
			moveContainer:SetPoint(point, UIParent, point, -((s_width / 2) - (width / 2)), yOfs)
		end

		moveContainer:dragStop()
	end)


	cont.center_v = makeButton()
	cont.center_v:SetPoint("LEFT", cont.center_h, "RIGHT", 0, 0)
	cont.center_v.tex2 = cont.center_v:CreateTexture(nil, "OVERLAY")
	cont.center_v.tex2:SetTexture(bdCore.media.arrowdown)
	cont.center_v.tex2:SetPoint("BOTTOM", 0, 4)
	cont.center_v.tex2:SetSize(12, 8)
	cont.center_v.tex2:SetRotation(3.14159)
	cont.center_v.tex:SetSize(12, 8)
	cont.center_v.tex:ClearAllPoints()
	cont.center_v.tex:SetPoint("TOP", 0, -4)
	cont.center_v.tex:SetRotation(0)

	cont.center_v:SetScript("OnClick", function()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		local width, height = moveContainer:GetSize()
		local s_width, s_height = GetPhysicalScreenSize()

		yOfs = ((s_height / 2) - (height / 2))

		moveContainer:ClearAllPoints()
		if (point == "TOPLEFT" or point == "TOP" or point == "TOPRIGHT") then
			moveContainer:SetPoint(point, UIParent, point, xOfs, -yOfs)
		elseif (point == "LEFT" or point == "CENTER" or point == "RIGHT") then
			moveContainer:SetPoint(point, UIParent, point, xOfs, 0)
		elseif (point == "BOTTOMLEFT" or point == "BOTTOM" or point == "BOTTOMRIGHT") then
			moveContainer:SetPoint(point, UIParent, point, xOfs, yOfs)
		end
		
		moveContainer:dragStop()
	end)



	bdCore:hookEvent("frames_resized,bdcore_redraw", function()
		local border = c.persistent['General'].border
		local height = frame:GetHeight()
		local width = frame:GetWidth()
		moveContainer:SetSize(width+border, height+border)
	end)
	 
	function moveContainer.dragStop(self)
		self:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = moveContainer:GetPoint()
		if (not relativeTo) then relativeTo = UIParent end
		relativeTo = relativeTo:GetName()
		self.controls:Show()

		self.controls:position()

		c.profile.positions[self.frame:GetName()] = {point, relativeTo, relativePoint, xOfs, yOfs}
	end
	
	moveContainer.text:SetFont(bdCore.media.font, 16)
	moveContainer.text:SetPoint("CENTER", moveContainer, "CENTER", 0, 0)
	moveContainer.text:SetText(name)
	moveContainer.text:SetJustifyH("CENTER")
	moveContainer.text:SetAlpha(0.8)
	moveContainer.text:Hide()

	-- show controller bars
	moveContainer:SetScript("OnEnter", function(self)
		self.controls:Show()
	end)
	moveContainer:SetScript("OnLeave", function(self)
		self.controls:Hide()
	end)
	
	-- on profile swaps
	moveContainer.position = function(self)
		moveContainer:ClearAllPoints()
		if (c.profile.positions[name]) then
			local point, relativeTo, relativePoint, xOfs, yOfs = unpack(c.profile.positions[name])
			relativeTo = _G[relativeTo]

			if (not point or not relativeTo or not relativePoint or not xOfs or not yOfs) then
				c.profile.positions[name] = nil
				moveContainer:position()
			else
				moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
			end
		else
			moveContainer:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
		end
	end
	moveContainer:position()
	bdCore:hookEvent("bd_reconfig", moveContainer.position)

	frame:ClearAllPoints()
	frame:SetPoint("TOPRIGHT", moveContainer, "TOPRIGHT", -2, -2)
	
	bdCore.moveFrames[#bdCore.moveFrames+1] = moveContainer

	cont:position()

	moveContainer:EnableMouse(false)

	return moveContainer
end

function bdCore:toggleLock()

	if (bdCore.moving == true) then
		bdCore.moving = false
		print(bdCore.colorString.."Core: Addons locked")
		bdCore.aligngrid:Hide()
	else
		bdCore.moving = true
		print(bdCore.colorString.."Core: Addons unlocked")
		bdCore.aligngrid:Show()
	end
	
	bdCore:triggerEvent("bd_toggle_lock")

	for k, v in pairs(bdCore.moveFrames) do
		local frame = v
		if (bdCore.moving) then
			frame:SetAlpha(1)
			frame.text:Show()
			frame:EnableMouse(true)
			frame:SetMovable(true)
			frame:SetUserPlaced(false)
			frame:RegisterForDrag("LeftButton","RightButton")
			frame:SetScript("OnDragStart", function(self) self:StartMoving(); if (self.controls) then self.controls:Hide() end end)
			frame:SetScript("OnDragStop", function(self) self:dragStop(self) end)
			frame:SetFrameStrata("TOOLTIP")

		elseif (not bdCore.moving) then
			frame:SetAlpha(0)
			frame.text:Hide()
			frame:EnableMouse(false)
			frame:SetScript("OnDragStart", function(self) self:StopMovingOrSizing() end)
			frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
			frame:SetUserPlaced(false)
			frame:SetMovable(false)
			frame:SetFrameStrata("BACKGROUND")
			
		end
	end
end


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
	
	f:SetSize(f:GetTextWidth()+16,24)
	
	--if (f:GetWidth() < 24) then
	if (small and f:GetWidth() <= 24 ) then
		f:SetWidth(20)
	end
	
	if (small) then
		f:SetHeight(18)
	end
	
	f:HookScript("OnEnter", function(f) 
		f:SetBackdropColor(unpack(hovercolors)) 
	end)
	f:HookScript("OnLeave", function(f) 
		f:SetBackdropColor(unpack(colors)) 
	end)
	
	return true
end



-- custom events/hooks
bdCore.events = {}
function bdCore:hookEvent(event, func)
	local events = split(event,",") or {event}
	for i = 1, #events do
		e = events[i]
		if (not bdCore.events[e]) then
			bdCore.events[e] = {}
		end
		bdCore.events[e][#bdCore.events[e]+1] = func
	end
end

function bdCore:triggerEvent(event,...)
	if (bdCore.events[event]) then
		for k, v in pairs(bdCore.events[event]) do
			v(...)
		end
	end
end

function bdCore:redraw()
	bdCore:triggerEvent("bdcore_redraw")
end

--
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
		g = r.g
		b = r.b
		r = r.r
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

-- make it purdy
function bdCore:setBackdrop(frame,resize)
	if (frame.background) then return end

	
	frame.background = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
	frame.background:SetTexture(bdCore.media.flat)
	frame.background:SetAllPoints(frame)
	frame.background:SetVertexColor(unpack(bdCore.media.backdrop))
	frame.background.protected = true
	
	frame.border = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
	frame.border:SetTexture(bdCore.media.flat)
	frame.border:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, 2)
	frame.border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 2, -2)
	frame.border:SetVertexColor(unpack(bdCore.media.border))
	frame.border.protected = true
	
	if (resize ~= false) then
		bdCore:hookEvent("bdcore_redraw",function()
			local background = bdCore:getMedia("background", c.persistent['General'].background)
			local font = bdCore:getMedia("font", c.persistent['General'].font)

			local border = c.persistent['General'].border or bdCore.general.border
			frame.background:SetTexture(background)			
			frame.border:SetPoint("TOPLEFT", frame, "TOPLEFT", -border, border)
			frame.border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", border, -border)
		end)
	end
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

-- also comma values
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end
-- not crazy about the built in split function
function split(str, del)
	local t = {}
	local index = 0;
	while (string.find(str, del)) do
		local s, e = string.find(str, del)
		t[index] = string.sub(str, 1, s-1)
		str = string.sub(str, s+#del)
		index = index + 1;
	end
	table.insert(t, str)
	return t;
end

-- lua doesn't have a good function for round
function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

-- lua doesn't have a good function for finding a value in a table
function in_table ( e, t )
	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

-- set up slash commands
function bdCore:setSlashCommand(name, func, ...)
    SlashCmdList[name] = func
    for i = 1, select('#', ...) do
        _G['SLASH_'..name..i] = '/'..select(i, ...)
    end
end

function bdCore:isBlacklisted(name,caster)
	local blacklist = c.persistent["Auras"]["blacklist"]
	
	if (blacklist[name]) then
		return true
	end
	return false
end

-- filter debuffs/buffs
function bdCore:filterAura(name, caster, invert)
	--local name = string.lower(name)
	local blacklist = BD_persistent["Auras"]["blacklist"]
	local whitelist = BD_persistent["Auras"]["whitelist"]
	local mine = BD_persistent["Auras"]["mine"]
	local class = BD_persistent["Auras"][bdCore.class]
	
	-- raid variables are set in a file, they can be blacklisted though, and added to through whitelist
	local raid = bdCore.auras.raid

	-- everything is blacklisted by default
	local allow = false
	if (invert) then
		allow = true
	end
	
	
	if (whitelist and whitelist[name]) then
		allow = true
	elseif (raid and raid[name]) then
		allow = true
	elseif (mine and mine[name] and caster and caster == "player") then
		allow = true
	elseif (class and class[name]) then
		allow = true
	elseif (blacklist and blacklist[name]) then
		allow = false
	end
	
	return allow
end

function bdCore:addOption(name, opts, var)
	local index = #var or 0
	var[index] = var[index] or {}
	var[index][name] = opts
	
	return var
end

bdCore:setSlashCommand('ReloadUI', ReloadUI, 'rl', 'reset')


SLASH_READYCHECK1 = "/rc"
SlashCmdList["READYCHECK"] = function()
	DoReadyCheck()
end

SLASH_BDCORE1, SLASH_BDCORE2 = "/bdcore", '/bd'
SlashCmdList["BDCORE"] = function(msg, editbox)
	if (msg == "" or msg == " ") then
		print(bdCore.colorString.." Options:")
		print("   /"..bdCore.colorString.." lock - unlocks/locks moving bd addons")
		print("   /"..bdCore.colorString.." config - opens the configuration for bd addons")
		print("   /"..bdCore.colorString.." reset - reset the saved settings account-wide (careful)")
		--print("-- /bui lock - locks the UI")
	elseif (msg == "unlock" or msg == "lock") then
		bdCore.toggleLock()
	elseif (msg == "reset") then
		BD_user = nil
		BD_profiles = nil

		ReloadUI()
	elseif (msg == "config") then
		bdCore:toggleConfig()
	else
		print(bdCore.colorString.." "..msg.." not recognized as a command.")
	end
end
