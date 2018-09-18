local bdCore, c, f = select(2, ...):unpack()

function bdCore:isBlacklisted(name,caster)	
	local blacklist = c.persistent["Auras"]["blacklist"]	
		
	if (blacklist[name]) then	
		return true	
	end	
	return false	
end

-- filter debuffs/buffs
function bdCore:filterAura(name, caster, isRaidDebuff, nameplateShowAll, invert)
	local blacklist = BD_persistent["Auras"]["blacklist"]
	local whitelist = BD_persistent["Auras"]["whitelist"]
	local mine = BD_persistent["Auras"]["mine"]
	local class = BD_persistent["Auras"][bdCore.class]
	local raid = bdCore.auras.raid

	-- blacklist has priority
	if (blacklist and blacklist[name]) then
		return false
	end

	-- but let's let things through that are obvious
	if (isRaidDebuff or nameplateShowAll or invert) then
		return true
	end
	
	if (whitelist and whitelist[name]) then
		return true
	elseif (raid and raid[name]) then
		return true
	elseif (class and class[name]) then
		return true
	elseif (mine and mine[name] and caster and caster == "player") then
		return true
	end
	
	return false
end