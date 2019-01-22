local bdCore, c, f = select(2, ...):unpack()
-- bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)

local persistentAuras 
local blacklisted = function(self, name)
	persistentAuras = bdConfigLib:GetSave("Auras")
	local blacklist = persistentAuras["blacklist"]

	if (blacklist[name]) then	
		return true	
	end	
	return false
end

bdCore.isBlacklisted = memoize(blacklisted, bdCore.caches.auras)

local filterAura = function(self, name, castByPlayer, isRaidDebuff, nameplateShowAll, invert)
	-- print(self, name, castByPlayer, isRaidDebuff, nameplateShowAll, invert)

	persistentAuras = bdConfigLib:GetSave("Auras")
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
	elseif (mine and mine[name] and castByPlayer) then
		return true
	end
	
	return false
end

bdCore.filterAura = memoize(filterAura, bdCore.caches.auras)

local isGlow = function(self, name)
	persistentAuras = bdConfigLib:GetSave("Auras")
	local raid = bdCore.auras.raid

	if (raid[name] == 2) then	
		return true	
	end	
	return false
end
bdCore.isGlow = memoize(isGlow, bdCore.caches.auras)