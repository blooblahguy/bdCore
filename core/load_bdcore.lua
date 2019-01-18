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

		-- add profile config here, before we set any defaults below
		-- bdCore:triggerEvent('profile_config')
		
	
		-- we shouldn't need this since lua references automatically the same table?
		-- when we update the default configuration, those new configurations should be copied over
		--[[ for group, options in pairs(c) do
			if (bdCoreDataPerChar[group] == nil) then
				bdCoreDataPerChar[group] = c[group]
			end
			for option, value in pairs(options) do
				if (bdCoreDataPerChar[group][option] == nil) then
					bdCoreDataPerChar[group][option] = value
				end
			end
			
		end--]]
		
		--[[
		for group, options in pairs(c.sv) do
			for option, value in pairs(options) do
				if (not c[group]) then c[group] = {} end
				if (c[group][option] ~= value) then
					c[group][option] = value
				end
			end
		end--]]
		
		-- bdConfigLib.savedVariable = BD_persistent
		c = bdConfigLib:RegisterModule({
			name = "bdAddons"
			, persistent = true
		}, bdCore.general, "BD_persistent")
		
		-- c = bdConfigLib:GetSave("bdAddons")
		-- bdCore.config = bdConfigLib:GetSave("bdAddons")

		print(bdCore.colorString.." loaded. Type /bd for configuration. We're on Discord! https://discord.gg/2SK3bEw")
		
		bdCore:triggerEvent('loaded_bdcore')
		bdCore:triggerEvent('bdcore_redraw')
		-- bdCore:triggerEvent("profile_config")
		
		-- a lot of addons do this when they shouldn't it should really only be done when addons finish loading
		collectgarbage("collect")
	elseif (event == "LOADING_SCREEN_DISABLED") then
		--bdCore:triggerEvent("bdcore_redraw")
	elseif (event == "PLAYER_REGEN_DISABLED") then
		bdCore:triggerEvent('combat_enter')
	elseif (event == "PLAYER_REGEN_ENABLED") then
		bdCore:triggerEvent('combat_exit')
	end
	
	return true
end)