local addon, engine = ...

engine[1] = CreateFrame("Frame", nil, UIParent)
engine[2] = {}
engine[3] = {}

function engine:unpack()
	return self[1], self[2], self[3]
end


bdCore = engine[1]
bdCore.config = engine[2]
bdCore.frames = engine[3]

bdCore:RegisterEvent("ADDON_LOADED")

bdCore.class = string.lower(select(1, UnitClass('player')))
bdCore.name = string.lower(UnitName('player'))
bdCore.scale = 768 / string.match( GetCVar( "gxWindowedResolution" ), "%d+x(%d+)" );

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

bdCore.colorString = '|cffA02C2Fbd|r'


local explevel = GetExpansionLevel()

bdCore.font = CreateFont("bdCore.font")
bdCore.font:SetFont("Interface\\Addons\\bdCore\\media\\font.ttf", 13)
bdCore.font:SetShadowColor(0, 0, 0)
bdCore.font:SetShadowOffset(1, -1)

function bdCore:noop() return end

-- SLASH COMMANDS
function bdCore:setSlashCommand(name, func, ...)
    SlashCmdList[name] = func
    for i = 1, select('#', ...) do
        _G['SLASH_'..name..i] = '/'..select(i, ...)
    end
end

bdCore:setSlashCommand('ReloadUI', ReloadUI, 'rl', 'reset')
bdCore:setSlashCommand('DoReadyCheck', DoReadyCheck, 'rc', 'ready')

SLASH_BDCORE1, SLASH_BDCORE2 = "/bdcore", '/bd'
SlashCmdList["BDCORE"] = function(msg, editbox)
	if (msg == "" or msg == " ") then
		print(bdCore.colorString.." Options:")
		print("   /"..bdCore.colorString.." lock - unlocks/locks moving bd addons")
		print("   /"..bdCore.colorString.." config - opens the configuration for bd addons")
		print("   /"..bdCore.colorString.." reset - reset the saved settings account-wide (careful)")
		--print("-- /bui lock - locks the UI")
	elseif (msg == "unlock" or msg == "lock") then
		bdCore:toggleLock()
	elseif (msg == "reset") then
		BD_user = nil
		BD_profiles = nil
		BD_persistent = nil

		ReloadUI()
	elseif (msg == "config" or msg == "conf") then
		bdConfigLib:Toggle()
	else
		print(bdCore.colorString.." "..msg.." not recognized as a command.")
	end
end