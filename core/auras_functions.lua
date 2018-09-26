local bdCore, c, f = select(2, ...):unpack()

local persistentAuras 
bdCore.isBlacklisted = memoize(function(name)
	persistentAuras = BD_persistent["Auras"]
	local blacklist = persistentAuras["blacklist"]

	if (blacklist[name]) then	
		return true	
	end	
	return false
end, bdCore.caches.auras)

-- filter debuffs/buffs

bdCore.filterAura = memoize(function(self, name, caster, isRaidDebuff, nameplateShowAll, invert)
	persistentAuras = BD_persistent["Auras"]
	local blacklist = persistentAuras["blacklist"]
	local whitelist = persistentAuras["whitelist"]
	local mine = persistentAuras["mine"]
	local class = persistentAuras[bdCore.class]
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

end, bdCore.caches.auras)