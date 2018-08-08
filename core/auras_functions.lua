local bdCore, c, f = select(2, ...):unpack()

-- filter debuffs/buffs
function bdCore:filterAura(name, caster, invert)
	--local name = string.lower(name)
	local blacklist = BD_persistent["Auras"]["blacklist"]
	local whitelist = BD_persistent["Auras"]["whitelist"]
	local mine = BD_persistent["Auras"]["mine"]
	local class = BD_persistent["Auras"][bdCore.class]
	
	-- raid variables are set in a file, they can be blacklisted though, and added to through whitelist
	local raid = bdCore.auras.raid

	-- everything is blacklisted by default
	local allow = false
	if (invert) then
		allow = true
	end
	
	
	if (whitelist and whitelist[name]) then
		allow = true
	elseif (raid and raid[name]) then
		allow = true
	elseif (mine and mine[name] and caster and caster == "player") then
		allow = true
	elseif (class and class[name]) then
		allow = true
	elseif (blacklist and blacklist[name]) then
		allow = false
	end
	
	return allow
end