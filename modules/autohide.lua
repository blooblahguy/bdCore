local bdCore, c, f = select(2, ...):unpack()

local autohide = CreateFrame("frame",nil,UIParent)
autohide:RegisterEvent("ENCOUNTER_START")
autohide:RegisterEvent("ENCOUNTER_END")
autohide:RegisterEvent("LOADING_SCREEN_DISABLED")

autohide:SetScript("OnEvent",function(self,event,arg1) 
	if (not IsInRaid()) then 
		ObjectiveTracker_Expand() 
		return 
	end

	if (event == "ENCOUNTER_START" or (event == "LOADING_SCREEN_DISABLED" and UnitExists("boss1"))) then
		ObjectiveTracker_Collapse()
	else
		ObjectiveTracker_Expand()
	end
end)