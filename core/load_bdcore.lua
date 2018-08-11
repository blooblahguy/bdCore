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

		bdCore.general[2].font.options = font_table
		bdCore.general[4].background.options = bg_table

		local first = false
		-- create default profile
		if (not BD_profiles) then
			BD_profiles = {}
			BD_profiles['default'] = c

			first = true; -- trigger first time run screen
		end
		c.profiles = BD_profiles

		-- create this characters configuration
		if (not BD_user or not BD_user.profile) then
			BD_user = {}
			BD_user.profile = "default"

		end
		c.user = BD_user
		c.user.profile = c.user.profile or "default"

		-- Scope current profile
		c.profile = c.profiles[c.user.profile]
		c.profile.positions = c.profile.positions or {}

		-- add profile config here, before we set any defaults below
		bdCore:triggerEvent('profile_config')

		c.user.profile_spec = c.user.profile_spec or {}
		c.user.profile_spec.current = c.user.profile_spec.current or false
		c.user.profile_spec[1] = c.user.profile_spec[1] or false
		c.user.profile_spec[2] = c.user.profile_spec[2] or false
		c.user.profile_spec[3] = c.user.profile_spec[3] or false
		c.user.profile_spec[4] = c.user.profile_spec[4] or false

		-- things that are not profile specific
		if (not BD_persistent ) then
			BD_persistent = {}
		end

		c.persistent = BD_persistent
		c.persistent.auras = c.persistent.auras or {}
		c.persistent.raid = c.persistent.auras.raid or {}
		c.persistent.whitelist = c.persistent.auras.whitelist or {}
		c.persistent.blacklist = c.persistent.auras.blacklist or {}
		c.persistent.mine = c.persistent.auras.mine or {}
		c.persistent.auras.class = c.persistent.auras.class or {}
		c.persistent.auras.class[bdCore.class] = c.persistent.auras.class[bdCore.class] or {}
		
		c.persistent.gmotd = c.persistent.gmotd or {}
		c.persistent.goldtrack = c.persistent.goldtrack or {}
		
	
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
		
		bdCore:addModule("General", bdCore.general, true)

		print(bdCore.colorString.." loaded. Type /bd for configuration. We're on Discord! https://discord.gg/2SK3bEw")
		
		bdCore:triggerEvent('loaded_bdcore')
		bdCore:triggerEvent('bdcore_redraw')
		
	elseif (event == "LOADING_SCREEN_DISABLED") then
		--bdCore:triggerEvent("bdcore_redraw")
	elseif (event == "PLAYER_REGEN_DISABLED") then
		bdCore:triggerEvent('combat_enter')
	elseif (event == "PLAYER_REGEN_ENABLED") then
		bdCore:triggerEvent('combat_exit')
	end
	
	return true
end)