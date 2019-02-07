local bdCore, c, f = select(2, ...):unpack()


local addonName, addon = ...
local _G = _G
local version = 11

if _G.bdMoveLib and _G.bdMoveLib.version >= version then
	bdMoveLib = _G.bdMoveLib
	return -- a newer or same version has already been created, ignore this file
end

_G.bdMoveLib = {}
bdMoveLib = _G.bdMoveLib
bdMoveLib.version = version

--========================================================
-- Helpers
--========================================================
function IsMouseOverFrame(self)
	if MouseIsOver(self) then return true end
	if not SpellFlyout:IsShown() then return false end
	if not SpellFlyout.__faderParent then return false end
	if SpellFlyout.__faderParent == self and MouseIsOver(SpellFlyout) then return true end

	return false
end

local function EnterLeaveHandle(self)
	if (self.__faderParent) then
		self = self.__faderParent
	end

	if IsMouseOverFrame(self) then
		self:Show()
	else
		self:Hide()
	end
end

--========================================================
-- Mover
--========================================================
--========================================================
-- Frames / Faders
--========================================================

-- fade out animation, basically mirrors itself onto the given frame
local function CreateFaderAnimation(frame)
	local animFrame = CreateFrame("Frame", nil, frame)
	frame.fader = animFrame:CreateAnimationGroup()
	frame.fader.__owner = frame
	frame.fader.__animFrame = animFrame
	frame.fader.anim = frame.fader:CreateAnimation("Alpha")
	frame.fader:HookScript("OnFinished", function(self)
		self.__owner:SetAlpha(self.finAlpha)
	end)
	frame.fader:HookScript("OnUpdate", function(self)
		self.__owner:SetAlpha(self.__animFrame:GetAlpha())
	end)
end

-- fade in animation
local function StartFadeIn(frame)
	if (not frame.enableFader) then return end
	if (frame.fader.direction == "in") then return end
	frame.fader:Pause()
	frame.fader.anim:SetFromAlpha(frame.outAlpha)
	frame.fader.anim:SetToAlpha(frame.inAlpha)
	frame.fader.anim:SetDuration(frame.duration)
	frame.fader.anim:SetSmoothing("OUT")
	frame.fader.anim:SetStartDelay(frame.outDelay)
	frame.fader.finAlpha = frame.inAlpha
	frame.fader.direction = "in"
	frame.fader:Play()
end

-- fade out animation
local function StartFadeOut(frame)
	if (not frame.enableFader) then return end
	if (frame.fader.direction == "out") then return end
	frame.fader:Pause()
	frame.fader.anim:SetFromAlpha(frame.inAlpha)
	frame.fader.anim:SetToAlpha(frame.outAlpha)
	frame.fader.anim:SetDuration(frame.duration)
	frame.fader.anim:SetSmoothing("OUT")
	frame.fader.anim:SetStartDelay(frame.outDelay)
	frame.fader.finAlpha = frame.outAlpha
	frame.fader.direction = "out"
	frame.fader:Play()
end

-- Allows us to mouseover show a frame, with animation
function bdMoveLib:CreateFader(frame, children, inAlpha, outAlpha, duration, outDelay)
	if (frame.fader) then return end

	-- set variables
	frame.inAlpha = inAlpha or 1
	frame.outAlpha = outAlpha or 0
	frame.duration = duration or 0
	frame.outDelay = outDelay or 0
	frame.enableFader = true

	-- Create Animation Frame
	CreateFaderAnimation()

	-- Hook Events / Listeners
	frame:HookScript("OnEnter", EnterLeaveHandle)
    frame:HookScript("OnLeave", EnterLeaveHandle)

	-- Hook all animation into these events
	frame:HookScript("OnShow", StartFadeIn)
	frame:HookScript("OnHide", StartFadeOut)

	-- Hook Children
	for i, button in next, children do
		if not button.__faderParent then
			button.__faderParent = frame
			button:HookScript("OnEnter", EnterLeaveHandle)
			button:HookScript("OnLeave", EnterLeaveHandle)
		end
  	end
end

-- Allows us to track is mouse is over SpellFlyout child
local function SpellFlyoutHook(self)
	local topParent = self:GetParent():GetParent():GetParent()
	if (not topParent.__fader) then return end

	-- toplevel
	if (not self.__faderParent) then
		self.__faderParent = topParent
		SpellFlyout:HookScript("OnEnter", EnterLeaveHandle)
    	SpellFlyout:HookScript("OnLeave", EnterLeaveHandle)
	end

	-- children
	for i=1, NUM_ACTIONBAR_BUTTONS do
		local button = _G["SpellFlyoutButton"..i]
		if not button then break end

		if not button.__faderParent then
			button.__faderParent = topParent
			button:HookScript("OnEnter", EnterLeaveHandle)
			button:HookScript("OnLeave", EnterLeaveHandle)
		end
	end
end
SpellFlyout:HookScript("OnShow", SpellFlyoutHook)