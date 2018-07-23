local name, engine = ...
local bdCore, c, f = select(2, ...):unpack()
bdCore.oUF = engine.oUF or oUF

local waiting = CreateFrame("frame",nil,bdCore)
waiting.frames = {}

--[[
waiting:RegisterEvent("PLAYER_LEAVE_COMBAT")
waiting:SetScript("OnEvent", function() 
	for key, pack in pairs(waiting.frames) do
		local func, params = unpack(pack)
		func(params)
		waiting.frames[key] = nil
	end
end)

local function Size(frame, ...)
	frame:SetSize(...)
end

local function Width(frame, ...)
	frame:SetWidth(...)
end

local function Height(frame, ...)
	frame:SetHeight(...)
end

local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = function() return end
	object:Hide()
end

local function FrameStrata(frame, arg1)
	frame:SetFrameStrata(arg1)
end

local function FrameLevel(frame, arg1)
	frame:SetFrameLevel(arg1)
end

local function ClearPoints(frame)
	frame:ClearAllPoints()
end

local function Point(frame, ...)
	frame:SetPoint(...)
end

local function AllPoints(frame, ...)
	frame:ClearAllPoints()
	frame:SetAllPoints(...)
end--]]

--[[
local function hookEvent(self, event, func)
	local events = split(event,",") or {event}
	for i = 1, #events do
		e = events[i]
		if (not bdCore.events[e]) then
			bdCore.events[e] = {}
		end
		bdCore.events[e][#bdCore.events[e]+1] = func(self)
	end
end

local function AddAPI(object)
	local mt = getmetatable(object).__index

	if not object.hookEvent then mt.hookEvent = hookEvent end
end
local Handled = {["Frame"] = true}
local Object = CreateFrame("Frame")
AddAPI(Object)
AddAPI(Object:CreateTexture())
AddAPI(Object:CreateFontString())
Object = EnumerateFrames()
while Object do
	if not Object:IsForbidden() and not Handled[Object:GetObjectType()] then
		AddAPI(Object)
		Handled[Object:GetObjectType()] = true
	end
	Object = EnumerateFrames(Object)
end--]]

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