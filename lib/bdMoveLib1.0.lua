local bdCore, c, f = select(2, ...):unpack()


local addonName, addon = ...
local _G = _G
local version = 11

if _G.bdMoveLib and _G.bdMoveLib.version >= version then
	bdMoveLib = _G.bdMoveLib
	return -- a newer or same version has already been created, ignore this file
end

_G.bdMoveLib = {}
bdMoveLib = _G.bdMoveLib
bdMoveLib.version = version