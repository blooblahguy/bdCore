local bdCore, c, f = select(2, ...):unpack()

bdCore:RegisterEvent("ADDON_LOADED")
bdCore:RegisterEvent("PLAYER_REGEN_ENABLED")
bdCore:RegisterEvent("PLAYER_REGEN_DISABLED")
bdCore:RegisterEvent("LOADING_SCREEN_DISABLED")
bdCore:RegisterEvent("PLAYER_ENTERING_WORLD")
bdCore:SetScript("OnEvent", function(self, event, arg1, arg2, ...)

	if (event == "ADDON_LOADED" and (arg1 == "bdCore" or arg1 == "bdcore")) then

		-- shared media first
		local shared = LibStub:GetLibrary("LibSharedMedia-3.0")
		local fonts = shared:List('font')
		local backgrounds = shared:List('statusbar')

		local font_table = {}
		local bg_table = {}
		for k, font in pairs(fonts) do
			local path = shared:Fetch("font", font)
			if (font) then
				bdCore.media.fonts[font] = path
				table.insert(font_table, font)
			end
		end
		for k, background in pairs(backgrounds) do
			local path = shared:Fetch("statusbar", background)
			if (background) then
				bdCore.media.backgrounds[background] = path
				table.insert(bg_table, background)
			end
		end

		-- update shared media configuration
		bdCore.general[2].font.options = font_table
		bdCore.general[4].background.options = bg_table
		
		-- init config
		local saved = bdConfigLib:RegisterModule({
			name = "bdAddons"
			, persistent = true
			, returnType = "both"
		}, bdCore.general, "BD_persistent")

		c.persistent = saved.persistent
		c.profile = saved.profile
		bdCore:hookEvent("bd_reconfig", function()
			c.persistent = saved.persistent
			c.profile = saved.profile
		end)		

		print(bdCore.colorString.." loaded. Type /bd for configuration. We're on Discord! https://discord.gg/2SK3bEw")

		bdCore.loaded = true
		
		bd_do_action('loaded_bdcore')
		bd_do_action('bdcore_redraw')
		
		-- a lot of addons do this when they shouldn't it should really only be done when addons finish loading
		collectgarbage("collect")

		print(bdCore.colorString.." - All bd addons have been replaced by a single suite, called bdUI. Download on the twitch client or at https://www.curseforge.com/wow/addons/bdui . All support for the individual addons are going away, but the suite is entirely modular!");

		MOD_TextFrame = CreateFrame("Frame");
		MOD_TextFrame:ClearAllPoints();
		MOD_TextFrame:SetHeight(300);
		MOD_TextFrame:SetWidth(300);
		MOD_TextFrame:SetScript("OnUpdate", MOD_TextFrame_OnUpdate);
		MOD_TextFrame:Hide();
		MOD_TextFrame.text = MOD_TextFrame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
		MOD_TextFrame.text:SetAllPoints();
		MOD_TextFrame:SetPoint("CENTER", 0, 200);
		MOD_TextFrameTime = 0;

		function MOD_TextFrame_OnUpdate()
		if (MOD_TextFrameTime < GetTime() - 3) then
			local alpha = MOD_TextFrame:GetAlpha();
			if (alpha ~= 0) then MOD_TextFrame:SetAlpha(alpha - .05); end
			if (alpha == 0) then MOD_TextFrame:Hide(); end
		end
		end

		function MOD_TextMessage(message)
			MOD_TextFrame.text:SetText(message);
			MOD_TextFrame:SetAlpha(1);
			MOD_TextFrame:Show();
			MOD_TextFrameTime = GetTime();
		end

		MOD_TextMessage("All "..bdCore.colorString.." addons have been replaced by a single suite, called bdUI. Download on the twitch client or at https://www.curseforge.com/wow/addons/bdui . All support for the individual addons are going away, but the suite is entirely modular!")

	elseif (event == "ADDON_LOADED" and bdCore.loaded) then
		bd_do_action("addon_loaded")
	elseif (event == "LOADING_SCREEN_DISABLED") then
		--bdCore:triggerEvent("bdcore_redraw")
	elseif (event == "PLAYER_REGEN_DISABLED") then
		bdCore:triggerEvent('combat_enter')
	elseif (event == "PLAYER_REGEN_ENABLED") then
		bdCore:triggerEvent('combat_exit')
	end
	
	return true
end)
