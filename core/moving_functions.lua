local bdCore, c, f = select(2, ...):unpack()

-----------------------------------------------
-- align grid
-- only do this if its not on windowed mode
-----------------------------------------------
bdCore.aligngrid = CreateFrame("frame", "bd_align", UIParent)
local ag = bdCore.aligngrid

ag:SetFrameStrata("BACKGROUND")
ag:SetAllPoints(UIParent)

local s_width, s_height = GetPhysicalScreenSize()
		
local grid_size_x = math.floor( s_width / 40)
local grid_size_y = math.floor(s_height / 32)

local x = math.floor(s_width / grid_size_x)
local y = math.floor(s_height / grid_size_y)

for i = 1, x do
	local tex = ag:CreateTexture(nil,'overlay')
	tex:SetTexture(bdCore.media.flat)
	tex:SetVertexColor(0,0,0)
	if (i == (x/2)) then
		tex:SetVertexColor(unpack(bdCore.media.blue))
	end
	tex:SetWidth(1)
	tex:SetPoint("TOPLEFT", UIParent, "TOPLEFT", i*grid_size_x, 0)
	tex:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", i*grid_size_x, 0)
end

for i = 1, y do
	local tex = ag:CreateTexture(nil,'overlay')
	tex:SetTexture(bdCore.media.flat)
	tex:SetVertexColor(0,0,0)
	if (i == (y/2)) then
		tex:SetVertexColor(unpack(bdCore.media.blue))
	end
	tex:SetHeight(1)
	tex:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -i*grid_size_y)
	tex:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, -i*grid_size_y)
end

ag:Hide()

-- some javascript i'm going to use to create snap functionality
--[[
	window.canvas = new fabric.Canvas('fabriccanvas');
	window.counter = 0;
	var newleft = 0,
		edgedetection = 20, //pixels to snap
		canvasWidth = document.getElementById('fabriccanvas').width,
		canvasHeight = document.getElementById('fabriccanvas').height;

	canvas.selection = false;
	plusrect();
	plusrect();
	plusrect();

	function plusrect(top, left, width, height, fill) {
		window.canvas.add(new fabric.Rect({
			top: 300,
			name: 'rectangle ' + window.counter,
			left: 0 + newleft,
			width: 100,
			height: 100,
			fill: 'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ', 0.75)',
			lockRotation: true,
			originX: 'left',
			originY: 'top',
			cornerSize: 15,
			hasRotatingPoint: false,
			perPixelTargetFind: true,
			minScaleLimit: 1,
			maxHeight: document.getElementById("fabriccanvas").height,
			maxWidth: document.getElementById("fabriccanvas").width,
		}));
		window.counter++;
		newleft += 200;
	}
	this.canvas.on('object:moving', function (e) {
		var obj = e.target;
		obj.setCoords(); //Sets corner position coordinates based on current angle, width and height

		if(obj.getLeft() < edgedetection) {
			obj.setLeft(0);
		}

		if(obj.getTop() < edgedetection) {
			obj.setTop(0);
		}

		if((obj.getWidth() + obj.getLeft()) > (canvasWidth - edgedetection)) {
			obj.setLeft(canvasWidth - obj.getWidth());
		}

		if((obj.getHeight() + obj.getTop()) > (canvasHeight - edgedetection)) {
			obj.setTop(canvasHeight - obj.getHeight());
		}

		canvas.forEachObject(function (targ) {
			activeObject = canvas.getActiveObject();

			if (targ === activeObject) return;


			if (Math.abs(activeObject.oCoords.tr.x - targ.oCoords.tl.x) < edgedetection) {
				activeObject.left = targ.left - activeObject.currentWidth;
			}
			if (Math.abs(activeObject.oCoords.tl.x - targ.oCoords.tr.x) < edgedetection) {
				activeObject.left = targ.left + targ.currentWidth;
			}
			if (Math.abs(activeObject.oCoords.br.y - targ.oCoords.tr.y) < edgedetection) {
				activeObject.top = targ.top - activeObject.currentHeight;
			}
			if (Math.abs(targ.oCoords.br.y - activeObject.oCoords.tr.y) < edgedetection) {
				activeObject.top = targ.top + targ.currentHeight;
			}
			if (activeObject.intersectsWithObject(targ) && targ.intersectsWithObject(activeObject)) {
				targ.strokeWidth = 10;
				targ.stroke = 'red';
			} else {
				targ.strokeWidth = 0;
				targ.stroke = false;
			}
			if (!activeObject.intersectsWithObject(targ)) {
				activeObject.strokeWidth = 0;
				activeObject.stroke = false;
			}
		});
	});
 ]]
bdCore.moving = false
bdCore.moveFrames = {}

bdCore.MoverSettings = {
	snapToEdges = true -- snap to t/r/b/l of objects
	, snapToCorners = true -- snap to corner of objects
	, snapToGrid = true -- snap to the alignment grid
	, snapThreshold = 20 -- pixels to snap
}

-- add to our movable list
function bdCore:makeMovable(frame, resize, rename)
	-- setting default variables
	if resize == nil then resize = true end
	if rename == nil then rename = frame:GetName() end

	local Mover = CreateFrame("frame", "bdCore_"..rename, UIParent)
	function Mover:startMoving()
		local x, y = GetCursorPosition();
	end
	function Mover:stopMoving()
		local x, y = GetCursorPosition();
	end

	-- This builds the majority of our control buttons
	Mover.lastController = nil
	function Mover:controllerButton(moveX, moveY)
		local cont = self.controls
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

		button:SetScript("OnClick", function()
			local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
			if (IsShiftKeyDown()) and IsControlKeyDown() then
				self:SetPoint(point, relativeTo, relativePoint, xOfs+(moveX*20), yOfs+(moveY*20))
			elseif (IsShiftKeyDown()) then
				self:SetPoint(point, relativeTo, relativePoint, xOfs+(moveX*5), yOfs+(moveY*5))
			else
				self:SetPoint(point, relativeTo, relativePoint, xOfs+(moveX*1), yOfs+(moveY*1))
			end
			self:dragStop()
		end)

		if (self.lastController) then
			button:SetPoint("LEFT", self.lastController, "RIGHT", 0, 0)
		else
			button:SetPoint("LEFT", cont, "LEFT", 0, 0)
		end

		self.lastController = button
		return button
	end

	local border = c.persistent['General'].border
	local height = frame:GetHeight()
	local width = frame:GetWidth()
	local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	relativeTo = relativeTo:GetName()

	
	Mover.text = Mover:CreateFontString(Mover:GetName().."_Text")
	Mover.frame = frame
	frame.Mover = Mover
	if (resize) then
		hooksecurefunc(frame,"SetSize",function() 
			local height = frame:GetHeight()
			local width = frame:GetWidth()
			Mover:SetSize(width+2+border, height+2+border)
		end)
	end
	Mover:SetSize(width+4, height+4)
	Mover:SetBackdrop({bgFile = bdCore.media.flat, edgeFile = bdCore.media.flat, edgeSize = 1})
	Mover:SetBackdropColor(0,0,0,.6)
	Mover:SetBackdropBorderColor(unpack(bdCore.media.blue))
	Mover:SetFrameStrata("BACKGROUND")
	Mover:SetClampedToScreen(true)
	Mover:SetAlpha(0)

	Mover.controls = CreateFrame("frame", nil, Mover)
	local cont = Mover.controls
	cont:SetSize(150, 25)
	cont:Hide()

	cont.position = function(self)
		local point, relativeTo, relativePoint, xOfs, yOfs = Mover:GetPoint()

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

		self:SetPoint(sy..x, Mover, y..x, 0, 0)
	end
	local function makeButton()
		
	end

	-- push left
	cont.left = Mover:controllerButton(-1, 0)
	cont.left.tex:SetRotation(-1.5708)
	
	-- push up
	cont.up = Mover:controllerButton(0, 1)
	cont.up.tex:SetRotation(3.14159)

	-- push down
	cont.down = Mover:controllerButton(0, -1)
	cont.down.tex:SetRotation(0)

	-- push right
	cont.right = Mover:controllerButton(1, 0)
	cont.right.tex:SetRotation(1.5708)

	cont.center_h = Mover:controllerButton()
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
		local point, relativeTo, relativePoint, xOfs, yOfs = Mover:GetPoint()
		local width, height = Mover:GetSize()
		local s_width, s_height = GetPhysicalScreenSize()

		Mover:ClearAllPoints()
		if (point == "LEFT" or point == "TOPLEFT" or point == "BOTTOMLEFT") then
			Mover:SetPoint(point, UIParent, point, ((s_width / 2) - (width / 2)), yOfs)
		elseif (point == "CENTER" or point == "TOP" or point == "BOTTOM") then
			Mover:SetPoint(point, UIParent, point, 0, yOfs)
		elseif (point == "RIGHT" or point == "TOPRIGHT" or point == "BOTTOMRIGHT") then
			Mover:SetPoint(point, UIParent, point, -((s_width / 2) - (width / 2)), yOfs)
		end

		Mover:dragStop()
	end)


	cont.center_v = Mover:controllerButton()
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
		local point, relativeTo, relativePoint, xOfs, yOfs = Mover:GetPoint()
		local width, height = Mover:GetSize()
		local s_width, s_height = GetPhysicalScreenSize()

		yOfs = ((s_height / 2) - (height / 2))

		Mover:ClearAllPoints()
		if (point == "TOPLEFT" or point == "TOP" or point == "TOPRIGHT") then
			Mover:SetPoint(point, UIParent, point, xOfs, -yOfs)
		elseif (point == "LEFT" or point == "CENTER" or point == "RIGHT") then
			Mover:SetPoint(point, UIParent, point, xOfs, 0)
		elseif (point == "BOTTOMLEFT" or point == "BOTTOM" or point == "BOTTOMRIGHT") then
			Mover:SetPoint(point, UIParent, point, xOfs, yOfs)
		end
		
		Mover:dragStop()
	end)

	bdCore:hookEvent("frames_resized, bdcore_redraw", function()
		local border = c.persistent['General'].border
		local height = frame:GetHeight()
		local width = frame:GetWidth()
		Mover:SetSize(width+border, height+border)
	end)
	 
	function Mover.dragStop(self)
		self:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = Mover:GetPoint()
		if (not relativeTo) then relativeTo = UIParent end
		relativeTo = relativeTo:GetName()
		self.controls:Show()

		self.controls:position()

		c.profile.positions[self.frame:GetName()] = {point, relativeTo, relativePoint, xOfs, yOfs}
	end
	
	Mover.text:SetFont(bdCore.media.font, 16)
	Mover.text:SetPoint("CENTER", Mover, "CENTER", 0, 0)
	Mover.text:SetText(rename)
	Mover.text:SetJustifyH("CENTER")
	Mover.text:SetAlpha(0.8)
	Mover.text:Hide()

	-- show controller bars
	Mover:SetScript("OnEnter", function(self) self.controls:Show() end)
	Mover:SetScript("OnLeave", function(self) self.controls:Hide() end)
	
	-- on profile swaps
	Mover.position = function(self)
		Mover:ClearAllPoints()
		if (c.profile.positions[rename]) then
			local point, relativeTo, relativePoint, xOfs, yOfs = unpack(c.profile.positions[rename])
			relativeTo = _G[relativeTo]

			if (not point or not relativeTo or not relativePoint or not xOfs or not yOfs) then
				c.profile.positions[rename] = nil
				Mover:position()
			else
				Mover:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
			end
		else
			Mover:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
		end
	end
	Mover:position()
	bdCore:hookEvent("bd_reconfig", Mover.position)

	frame:ClearAllPoints()
	frame:SetPoint("TOPRIGHT", Mover, "TOPRIGHT", -2, -2)
	
	bdCore.moveFrames[#bdCore.moveFrames+1] = Mover

	cont:position()

	Mover:EnableMouse(false)

	return Mover
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