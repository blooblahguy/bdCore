-- local bdCore, c, f = select(2, ...):unpack()

-- local bdGameMenu = CreateFrame("frame","bdGameMenu")
-- bdGameMenu:SetFrameStrata("TOOLTIP")
-- bdGameMenu:SetFrameLevel(25)

-- local r,g,b,a = unpack(bdCore.media.border)
-- bdGameMenu:ClearAllPoints()
-- bdGameMenu:SetPoint("TOPLEFT",UIParent,"TOPLEFT")
-- bdGameMenu:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT")
-- bdGameMenu:Hide()
-- bdGameMenu:SetAlpha(0)
-- bdGameMenu:SetScale(.7)

-- bdGameMenu.caret = CreateFrame("frame",nil,bdGameMenu)
-- bdGameMenu.caret:SetBackdrop({bgFile=bdCore.media.flat})
-- bdGameMenu.caret:SetBackdropColor(1,1,1,.9)
-- bdGameMenu.caret:SetSize(4,16)
-- bdGameMenu.caret:Hide()

-- function bdGameMenu:makeFont(text,frame)
-- 	local fontframe = CreateFrame("Button",nil,bdGameMenu)
-- 	fontframe:SetFrameLevel(27)
-- 	fontframe.text = fontframe:CreateFontString(nil)
-- 	fontframe.text:SetFont(bdCore.media.font, 18)
-- 	fontframe.text:SetAllPoints(fontframe)
-- 	fontframe.text:SetJustifyH("LEFT")
-- 	fontframe.text:SetShadowOffset(1, -1)
-- 	fontframe.text:SetShadowColor(0,0,0)
-- 	fontframe.text:SetAlpha(0.7)
-- 	fontframe.text:SetText(text)
-- 	fontframe:SetSize(200,20)
	
-- 	fontframe.SetText = function(self,text) self.text:SetText(text); end
-- 	fontframe.SetTextColor = function(self,...) self.text:SetTextColor(...) end
	
-- 	fontframe:SetScript("OnEnter",function()
-- 		fontframe.text:SetAlpha(1)
-- 		bdGameMenu.caret:SetPoint("RIGHT",fontframe,"LEFT",-2,1)
-- 		bdGameMenu.caret:Show()
-- 	end)
-- 	fontframe:SetScript("OnLeave",function()
-- 		fontframe.text:SetAlpha(0.7)
-- 		bdGameMenu.caret:Hide()
-- 	end)
	
-- 	if (frame) then
-- 		fontframe:SetScript("OnClick",function()
-- 			frame:Click()
-- 		end)
-- 	end
-- 	fontframe:EnableMouse(false)
	
-- 	hooksecurefunc(GameMenuFrame,"Show",function()
-- 		fontframe:EnableMouse(true)
-- 	end)

-- 	hooksecurefunc(GameMenuFrame,"Hide",function()
-- 		fontframe:EnableMouse(false)
-- 	end)
	
-- 	return fontframe
-- end

-- bdGameMenu.resume = bdGameMenu:makeFont("RETURN TO GAME",GameMenuButtonContinue)
-- bdGameMenu.resume:SetPoint("LEFT",bdGameMenu,"LEFT",350,200)

-- bdGameMenu.config = bdGameMenu:makeFont("CONFIG")
-- bdGameMenu.config:SetPoint("TOPLEFT",bdGameMenu.resume,"BOTTOMLEFT",0,-24)
-- bdGameMenu.config:SetTextColor(unpack(bdCore.media.blue))
-- bdGameMenu.config:SetScript("OnMouseDown",function()
-- 	bdCore:toggleConfig()
-- 	GameMenuButtonContinue:Click()
-- 	UIFrameFadeOut(bdGameMenu,.3,1,0)
-- end)

-- bdGameMenu.system = bdGameMenu:makeFont("SYSTEM",GameMenuButtonOptions)
-- bdGameMenu.system:SetPoint("TOPLEFT",bdGameMenu.config,"BOTTOMLEFT",0,-2)

-- bdGameMenu.interface = bdGameMenu:makeFont("INTERFACE",GameMenuButtonUIOptions)
-- bdGameMenu.interface:SetPoint("TOPLEFT",bdGameMenu.system,"BOTTOMLEFT",0,-2)

-- bdGameMenu.kbs = bdGameMenu:makeFont("KEYBINDINGS",GameMenuButtonKeybindings)
-- bdGameMenu.kbs:SetPoint("TOPLEFT",bdGameMenu.interface,"BOTTOMLEFT",0,-2)

-- bdGameMenu.macros = bdGameMenu:makeFont("MACROS",GameMenuButtonMacros)
-- bdGameMenu.macros:SetPoint("TOPLEFT",bdGameMenu.kbs,"BOTTOMLEFT",0,-2)

-- bdGameMenu.addons = bdGameMenu:makeFont("ADDONS",GameMenuButtonAddons)
-- bdGameMenu.addons:SetPoint("TOPLEFT",bdGameMenu.macros,"BOTTOMLEFT",0,-2)

-- bdGameMenu.logout = bdGameMenu:makeFont("LOGOUT",GameMenuButtonLogout)
-- bdGameMenu.logout:SetPoint("TOPLEFT",bdGameMenu.addons,"BOTTOMLEFT",0,-24)

-- bdGameMenu.quit = bdGameMenu:makeFont("QUIT",GameMenuButtonQuit)
-- bdGameMenu.quit:SetPoint("TOPLEFT",bdGameMenu.logout,"BOTTOMLEFT",0,-2)

-- -- bottom
-- bdGameMenu.help = bdGameMenu:makeFont("HELP",GameMenuButtonHelp)
-- bdGameMenu.help:SetPoint("TOPLEFT",bdGameMenu.quit,"BOTTOMLEFT",0,-24)

-- bdGameMenu.shop = bdGameMenu:makeFont("SHOP",GameMenuButtonStore)
-- bdGameMenu.shop:SetPoint("TOPLEFT",bdGameMenu.help,"BOTTOMLEFT",0,-2)

-- bdGameMenu.new = bdGameMenu:makeFont("WHAT'S NEW",GameMenuButtonWhatsNew)
-- bdGameMenu.new:SetPoint("TOPLEFT",bdGameMenu.shop,"BOTTOMLEFT",0,-2)

-- --model
-- bdGameMenu.model = CreateFrame("PlayerModel",nil,bdGameMenu)
-- bdGameMenu:RegisterEvent("PLAYER_LOGIN")
-- bdGameMenu:RegisterEvent("PLAYER_FLAGS_CHANGED")
-- bdGameMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
-- bdGameMenu.model:SetSize(bdGameMenu:GetHeight(),bdGameMenu:GetHeight()*1.5)
-- bdGameMenu.model:SetPoint("BOTTOMLEFT",bdGameMenu,"BOTTOMLEFT",-310,40)
-- bdGameMenu.model:SetScale(UIParent:GetEffectiveScale())
-- --bdGameMenu.model:SetScale(768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
-- bdGameMenu.model.repose = function(self)
-- 	bdGameMenu:SetPoint("TOPLEFT",UIParent,"TOPLEFT")
-- 	bdGameMenu:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT")
-- 	bdGameMenu.model:SetUnit("player")
-- 	bdGameMenu.model:SetRotation(math.rad(30))
-- 	bdGameMenu.model:SetSize(bdGameMenu:GetHeight(),bdGameMenu:GetHeight()*1.5)
-- 	bdGameMenu.model:SetPoint("TOPLEFT",bdGameMenu,"TOPLEFT",-220, -40)
-- 	--bdGameMenu.model:SetScale(768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
-- 	bdGameMenu.model:SetScale(UIParent:GetEffectiveScale())
-- end
-- bdGameMenu:SetScript("OnEvent",function()
-- 	bdGameMenu.model:repose()
-- end)
-- bdGameMenu.model:SetFrameLevel(24)
-- --[[
-- hooksecurefunc(GameMenuFrame,"Show",function()
-- 	if (c.persistent.General.fancymenu) then
-- 		UIFrameFadeOut(UIParent,.1,1,0)
-- 		UIFrameFadeIn(bdGameMenu,.1,0,1)
-- 		--bdGameMenu:Show()
-- 		GameMenuFrame:SetAlpha(0)
-- 		GameMenuFrame:ClearAllPoints()
-- 		GameMenuFrame:SetScale(.001)
-- 		GameMenuFrame:SetPoint("BOTTOMLEFT")

-- 		bdGameMenu.model:repose()
-- 	else
-- 		GameMenuFrame:SetAlpha(1)
-- 		GameMenuFrame:SetScale(1)
		
-- 		GameMenuFrame:ClearAllPoints()
-- 		GameMenuFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
-- 	end
-- end)

-- hooksecurefunc(GameMenuFrame,"Hide",function()
-- 	if (c.persistent.General.fancymenu) then
-- 		UIFrameFadeOut(bdGameMenu,.1,1,0)
-- 		--bdGameMenu:Hide()
-- 		UIFrameFadeIn(UIParent,.1,0,1)
-- 	end
-- end)--]]
