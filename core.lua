local addon, engine = ...

engine[1] = CreateFrame("Frame", nil, UIParent)
engine[2] = {}
engine[3] = {}

engine[1]:RegisterEvent("ADDON_LOADED")

if C_ChatInfo then
	RegisterAddonMessagePrefix, SendAddonMessage = C_ChatInfo.RegisterAddonMessagePrefix, C_ChatInfo.SendAddonMessage
end

engine[1].class = string.lower(select(1, UnitClass('player')))
engine[1].name = string.lower(UnitName('player'))

local roleupdate = CreateFrame("frame",nil)
roleupdate:RegisterEvent("LFG_ROLE_UPDATE")
roleupdate:RegisterEvent("PLAYER_ROLES_ASSIGNED")
roleupdate:RegisterEvent("ROLE_CHANGED_INFORM")
roleupdate:RegisterEvent("PVP_ROLE_UPDATE")
roleupdate:SetScript("OnEvent", function(self, event, arg)
	local spec_id = GetSpecialization()
	if (spec_id and GetSpecializationInfo(spec_id)) then
		engine[1].spec = string.lower(select(2,GetSpecializationInfo(spec_id)))
		engine[1].role = string.lower(select(6,GetSpecializationInfo(spec_id)))
	
	end
end)

function engine:unpack()
	return self[1], self[2], self[3]
end

bdCore = engine[1]
bdCore.colorString = '|cffA02C2Fbd|r'
bdCore.config = engine[2]
bdCore.frames = engine[3]
local explevel = GetExpansionLevel()
bdCore.isLegion = explevel == 6 or false
bdCore.isBFA = explevel == 7 or false
bdCore.explevel = explevel

bdCore.font = CreateFont("bdCore.font")
bdCore.font:SetFont("Interface\\Addons\\bdCore\\media\\font.ttf", 13)
bdCore.font:SetShadowColor(0, 0, 0)
bdCore.font:SetShadowOffset(1, -1)