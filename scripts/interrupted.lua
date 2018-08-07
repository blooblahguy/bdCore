local bdCore, c, f = select(2, ...):unpack()
local interrupt = CreateFrame('frame')
local channel = 'SAY'

local function RGBPercToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

interrupt:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
local function OnEvent(self, event)
	
	if (not BD_persistent.General.interrupt() ) then return end
	if (select(2, CombatLogGetCurrentEventInfo() ) ~= 'SPELL_INTERRUPT') then return end
	if (not UnitExists(select(5, CombatLogGetCurrentEventInfo() )) or not UnitIsUnit(select(5, CombatLogGetCurrentEventInfo() ), 'player') ) then return end
	--local class, classFileName = UnitClass("player")
	--local colors = RAID_CLASS_COLORS[classFileName]
	--local hex = RGBPercToHex(colors.r,colors.g,colors.b)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15 = CombatLogGetCurrentEventInfo ()
	
	SendChatMessage(UnitName("player")..' interrupted ' .. GetSpellLink(arg15), channel)
end

interrupt:SetScript('OnEvent', OnEvent)

-- FontString scannign
--[[local function scanChildren(obj)
	local children = {obj:GetChildren()}
	for k, v in pairs(children) do
		if (not (v:IsForbidden()) and v:GetObjectType() == "FontString" and not v.bdHooked) then
			v.bdHooked = true
			v.oldSetText = v.SetText
			v.SetText = function(self, text) 
				self:oldSetText(text)
			end
		elseif (not (v:IsForbidden()) and v:GetObjectType() == "Frame") then
			scanChildren(v)
		end
	end
end
scanChildren(UIParent)--]]
--[[
local raid_specs = {}
local inspect_pending = {}
local inspector = CreateFrame("Frame")
inspector:RegisterEvent("ENCOUNTER_START")
inspector:RegisterEvent("PLAYER_ENTERING_WORLD")
inspector:RegisterEvent("INSPECT_READY")
inspector:SetScript("OnEvent",function(self, event, arg1)
	if (event == "ENCOUNTER_START" or event == "PLAYER_ENTERING_WORLD") then
		local num_group = GetNumGroupMembers()
		for i = 1, num_group do
			if (UnitExists("raid"..i)) then
				local name = UnitName("raid"..i)
				inspect_pending[name] = true
				NotifyInspect(name)
			end
		end
		print("added ", num_group, "for inspect_pending")
	elseif (event == "INSPECT_READY") then
		print(event)
		for kname, v in pairs(inspect_pending) do
			InspectUnit(kname)
			local spec_id = GetInspectSpecialization(kname)
			ClearInspectPlayer()
			if (spec_id and spec_id > 0) then
				print(kname, spec_id)
				raid_specs[kname] = spec_id
				inspect_pending[kname] = nil
			end
		end
	end
end)

C_Timer.After(6, function() 
	print("specs")
	for k, v in pairs(raid_specs) do
		print(k, v)
	end
end)

local f = CreateFrame("Frame")

function InspectSpec()
	if CanInspect("target") then
		f:RegisterEvent("INSPECT_READY")
		NotifyInspect("target")
	else
		print("Can't inspect target")
	end
end

f:SetScript("OnEvent",function(self,event,...)
	local spec_id = GetInspectSpecialization("target")
	f:UnregisterEvent("INSPECT_READY")
	ClearInspectPlayer()
	local spec_name = select(2,GetSpecializationInfoByID(spec_id))
	print(spec_name)
end)
--]]

