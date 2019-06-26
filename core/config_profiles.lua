local bdCore, c, f = select(2, ...):unpack()
-- bdCore:hookEvent("loaded_bdcore", function() c = bdConfigLib:GetSave("bdAddons") end)

local config = {}
local function profileDropdown(dropdown) 

	local profile_table = {}
	for k, v in pairs(c.profiles) do
		table.insert(profile_table, k)
	end

	dropdown:populate(profile_table)
end

local function profileChange(value)
	c.profile = value

	c.profile = c.profiles[c.user.profile]

	bdCore:triggerEvent("bd_reconfig")
end

local function addProfile(value, arg2) 
	c.profiles[value] = c.profile

	bdCore:triggerEvent("bd_update_profiles")
end

local function deleteProfile()
	if (c.user.profile == "default") then
		print("You cannot delete the default profile, but you're free to modify it")
		return 
	end

	c.profiles[c.profile] = nil

	c.profile = "default"
	profileChange('default')

	bdCore:triggerEvent("bd_update_profiles")
end

local function profileCallback(...) 
	
end

bdCore:hookEvent('profile_config',function() 
	c = bdConfigLib:GetSave("bdAddons")

	local profile_table = {}
	for k, v in pairs(c.profiles) do
		table.insert(profile_table, k)
	end

	-- make new profile form
	local name, realm = UnitName("player")
	realm = GetRealmName()
	local placeholder = name.."-"..realm
	
	local defaults = {}
	defaults[#defaults+1] = {intro = {
		type = "text",
		value = "You can use profiles to store configuration per character and spec automatically, or save templates to use when needed."
	}}
	defaults[#defaults+1] = {currentprofile = {
		type = "dropdown",
		value = c.profile,
		override = true,
		options = profile_table,
		update = function(dropdown) profileDropdown(dropdown) end,
		updateOn = "bd_update_profiles",
		tooltip = "Your currently selected profile.",
		callback = function(self, value) profileChange(value) end
	}}
	defaults[#defaults+1] = {createprofile = {
		type = "textBox",
		value = placeholder,
		button = "Create & Copy",
		description = "Create New Profile: ",
		tooltip = "Your currently selected profile.",
		callback = addProfile
	}}
	defaults[#defaults+1] = {deleteprofile = {
		type = "button",
		value = "Delete Current Profile",
		callback = function(self) deleteProfile() end
	}}

	-- bdCore:addModule("Profiles", defaults)
	-- config = bdCore.config.profile['Profiles']

	bdConfigLib:RegisterModule({
		name = "Profiles"
		, persistent = true
	}, defaults, "BD_persistent")
	
	
end)
