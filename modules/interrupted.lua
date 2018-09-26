local bdCore, c, f = select(2, ...):unpack()
local channel = 'SAY'

local UnitExists, UnitIsUnit, UnitIsUnit, GetSpellLink, SendChatMessage = UnitExists, UnitIsUnit, UnitIsUnit, GetSpellLink, SendChatMessage

local interrupt = CreateFrame('frame')
interrupt:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
local function OnEvent(self, event)
	if (not BD_persistent.General.interrupt ) then return end

	local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critial, glancing, crushing, isOffHand = CombatLogGetCurrentEventInfo()

	if (subevent ~= 'SPELL_INTERRUPT') then return end

	if (UnitExists(sourceName) and UnitIsUnit(sourceName, 'player')) then
		SendChatMessage(UnitName("player")..' interrupted ' .. GetSpellLink(spellID), channel)
	end
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

