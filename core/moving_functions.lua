local bdCore, c, f = select(2, ...):unpack()


bdCore.moving = false
bdCore.moveFrames = {}

-- add to our movable list
function bdCore:makeMovable(frame, resize, name)
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