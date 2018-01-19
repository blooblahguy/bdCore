local bdCore, c, f = select(2, ...):unpack()

bdCore.media = {
	flat = "Interface\\Buttons\\WHITE8x8",
	smooth = "Interface\\Addons\\bdCore\\media\\smooth.tga",
	arial = "fonts\\ARIALN.ttf",
	font = "Interface\\Addons\\bdCore\\media\\font.ttf",
	bold = "Interface\\Addons\\bdCore\\media\\homizio_bold.ttf",
	arrow = "Interface\\Addons\\bdCore\\media\\arrow.blp",
	arrowup = "Interface\\Addons\\bdCore\\media\\arrowup.blp",
	arrowdown = "Interface\\Addons\\bdCore\\media\\arrowdown.blp",
	shadow = "Interface\\Addons\\bdCore\\media\\shadow.blp",
	fonts = {},
	backgrounds = {},
	border = {.06, .08, .09, 1},
	backdrop = {.11,.15,.18, 1},
	red = {.62,.17,.18,1},
	blue = {.2, .4, 0.8, 1},
	green = {.1, .7, 0.3, 1},
}

-- register everything with shared media
local shared = LibStub:GetLibrary("LibSharedMedia-3.0")
shared:Register("font", "bdFont", bdCore.media.font)
shared:Register("statusbar", "bdSmooth", bdCore.media.smooth)
shared:Register("background", "bdSmooth", bdCore.media.smooth)
shared:Register("statusbar", "Flat", bdCore.media.flat)
shared:Register("background", "Flat", bdCore.media.flat)
shared:Register("border", "bdShadow", bdCore.media.shadow)

-- general
	bdCore.general = {}
	bdCore.general[#bdCore.general+1] = {warning = {
		type = "text",
		value = "Changing font and background are still a work in progress."
	}}
	bdCore.general[#bdCore.general+1] = {font = {
		type = "dropdown",
		value = "bdFont",
		options = {},
		label = "Font",
		persistent = true,
		tooltip = "The font which all bdAddons use as their font.",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {background = {
		type = "dropdown",
		value = "bdSmooth",
		options = {},
		label = "Backgrounds Texture",
		persistent = true,
		tooltip = "The texture which all bdAddons use as their background.",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {border = {
		type = "slider",
		value = 2,
		min = 0,
		max = 2,
		step = 1,
		label = "Border Width",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {errorblock = {
		type = "checkbox",
		value = true,
		label = "Block Red Error Text Spam",
	}}
	bdCore.general[#bdCore.general+1] = {changefonts = {
		type = "checkbox",
		value = true,
		label = "Change UI Fonts",
	}}
	bdCore.general[#bdCore.general+1] = {interrupt = {
		type = "checkbox",
		value = true,
		label = "Announce Interrupts",
	}}
	bdCore.general[#bdCore.general+1] = {doubleclickbo = {
		type = "checkbox",
		value = true,
		label = "Double Click buyout",
		tooltip = "When double clicking on an auction it will buyout.",
	}}
	bdCore.general[#bdCore.general+1] = {alteratepowerbar = {
		type = "checkbox",
		value = true,
		label = "Use Alternate Power Bar",
	}}
	bdCore.general[#bdCore.general+1] = {forcescale = {
		type = "checkbox",
		value = false,
		label = "Force UI scale for pixel perfect borders",
	}}

----------------------------------------
-- skinning
----------------------------------------
	bdCore.general[#bdCore.general+1] = {tab = {
		type = "tab",
		value = "Skinning"
	}}
	bdCore.general[#bdCore.general+1] = {skingmotd = {
		type = "checkbox",
		value = true,
		label = "Show popup GMOTD",
	}}
	bdCore.general[#bdCore.general+1] = {skinwas = {
		type = "checkbox",
		value = false,
		label = "Skin Weak Auras to bd Style",
	}}
	bdCore.general[#bdCore.general+1] = {fancymenu = {
		type = "checkbox",
		value = false,
		label = "Replace Game Menu with Fancy Menu",
	}}

----------------------------------------
bdCore.auraconfig = {}
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="Whitelist"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Nothing is shown by default, add an aura to this list to have it show up. Useful for personal cooldowns, raid encounter debuffs, or other player auras."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {whitelist = {
	type = "list",
	value = bdCore.auras.whitelist,
	label = "Whitelisted Auras",
}}

-- Mine
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="My Casts"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Shows spells that are cast only by you."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {mine = {
	type = "list",
	value = bdCore.auras.mine,
	label = "Auras Cast by Me",
}}

-- Class
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="All "..bdCore.class.." Auras"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Shows spells that are cast only by the class you are currently playing. IE show paladin beacons while you are a paladin."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {[bdCore.class] = {
	type = "list",
	value = bdCore.auras['Personal Auras'][bdCore.class],
	label = 'All '..bdCore.class.." Auras",
}}

-- Blacklist
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="Blacklist"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="The blacklist overrides all previous aura configurations and hides an aura if its in this list."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {blacklist = {
	type = "list",
	value = bdCore.auras.blacklist,
	label = "Blacklisted Auras",
}}

--[[
bdCore.whitelistconfig = {
	[1] = {intro = {
		type = "text",
		value = "Add auras to the whitelist to have them tracked. i.e. Add a boss debuff to have it show on the raid frames.",
	}},
	[2] = {whitelist = {
		type = "list",
		value = bdCore.auras.whitelist,
		label = "Whitelisted Auras",
	}},
}

bdCore.blacklistconfig = {
	[1] = {intro = {
		type = "text",
		value = "Add auras to the blacklist to have them hidden whenever possible, such as buffs or debuffs that you don't need to track.",
	}},
	[2] = {blacklist = {
		type = "list",
		value = bdCore.auras.blacklist,
		label = "Blacklisted Auras",
	}},
}

bdCore.personalconfig = {
	[1] = {intro = {
		type = "text",
		value = "Personal auras will only show when they are cast by you, and class auras will only show when you're this class.",
	}},
	[2] = {mine = {
		type = "list",
		value = bdCore.auras.mine,
		label = "Auras Cast by Me",
	}},
	[3] = {[bdCore.class] = {
		type = "list",
		value = bdCore.auras['Personal Auras'][bdCore.class],
		label = 'All '..bdCore.class.." Auras",
	}},
}
--]]
-- modules defaults
