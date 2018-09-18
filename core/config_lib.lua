local bdCore, c, f = select(2, ...):unpack()
local media = bdCore.media

local configDimensions = {
	width = 740,
	left_col = 140,
	height = 450,
	rightwidth = 580
}

local bdConfig = CreateFrame( "Frame", "bdCore config", UIParent)
bdConfig:SetPoint("RIGHT", UIParent, "RIGHT", -20, 0)
bdConfig:SetSize(configDimensions.width, configDimensions.height)
bdConfig:SetMovable(true)
bdConfig:SetUserPlaced(true)
bdConfig:SetFrameStrata("DIALOG")
bdConfig:SetClampedToScreen(true)
bdConfig:Hide()
bdCore:setBackdrop(bdConfig)
bdCore:createShadow(bdConfig,10)

bdConfig.header = CreateFrame("frame",nil,bdConfig)
bdConfig.header:SetPoint("TOPLEFT",bdConfig,"TOPLEFT",0,0)
bdConfig.header:SetSize(configDimensions.width,30)
bdConfig.header:RegisterForDrag("LeftButton","RightButton")
bdConfig.header:EnableMouse(true)
bdConfig.header:SetScript("OnDragStart", function(self) bdConfig:StartMoving() end)
bdConfig.header:SetScript("OnDragStop", function(self) bdConfig:StopMovingOrSizing() end)

bdConfig.header.title = CreateFrame( "Frame", nil, bdConfig.header)
bdConfig.header.title:SetSize(configDimensions.left_col,30)
bdConfig.header.title:SetBackdrop({bgFile = media.flat})
bdConfig.header.title:SetBackdropColor(1,1,1,.05)
bdConfig.header.title:SetPoint("LEFT", bdConfig.header, "LEFT")

bdConfig.header.title.t = bdConfig.header.title:CreateFontString(nil, "OVERLAY")
bdConfig.header.title.t:SetFont(media.font, 16)
bdConfig.header.title.t:SetTextColor(1, 1, 1, 1)
bdConfig.header.title.t:SetText("bdCore Config")
bdConfig.header.title.t:SetAllPoints(bdConfig.header.title)
bdConfig.header.title.t:SetJustifyH("CENTER")

-- exit button
bdConfig.header.close = CreateFrame("Button", nil, bdConfig.header)
bdConfig.header.close:SetPoint("TOPRIGHT", bdConfig.header, "TOPRIGHT", 0 ,0)
bdConfig.header.close:SetSize(30, 28)
bdConfig.header.close:SetBackdrop({bgFile = media.flat})
bdConfig.header.close:SetBackdropColor(unpack(media.red))
bdConfig.header.close:SetAlpha(0.6)
bdConfig.header.close:EnableMouse(true)
bdConfig.header.close:SetScript("OnEnter", function()
	bdConfig.header.close:SetAlpha(1)
end)
bdConfig.header.close:SetScript("OnLeave", function()
	bdConfig.header.close:SetAlpha(0.6)
end)
bdConfig.header.close:SetScript("OnClick", function()
	bdConfig:Hide()
end)
bdConfig.header.close.x = bdConfig.header.close:CreateFontString(nil)
bdConfig.header.close.x:SetFont(media.font, 12)
bdConfig.header.close.x:SetText("x")
bdConfig.header.close.x:SetPoint("CENTER", bdConfig.header.close, "CENTER", .5, 0)

-- reload button
bdConfig.header.reload = CreateFrame("Button", nil, bdConfig.header)
bdConfig.header.reload:SetPoint("RIGHT", bdConfig.header.close, "LEFT", -2 ,0)
bdConfig.header.reload:SetSize(70, 28)
bdConfig.header.reload:SetBackdrop({bgFile = media.flat})
bdConfig.header.reload:SetBackdropColor(unpack(media.blue))
bdConfig.header.reload:SetAlpha(0.6)
bdConfig.header.reload:EnableMouse(true)
bdConfig.header.reload:SetScript("OnEnter", function()
	bdConfig.header.reload:SetAlpha(1)
end)
bdConfig.header.reload:SetScript("OnLeave", function()
	bdConfig.header.reload:SetAlpha(0.6)
end)
bdConfig.header.reload:SetScript("OnClick", function()
	ReloadUI()
end)

bdConfig.header.reload.x = bdConfig.header.reload:CreateFontString(nil)
bdConfig.header.reload.x:SetFont(media.font, 12)
bdConfig.header.reload.x:SetText("Reload UI")
bdConfig.header.reload.x:SetPoint("CENTER", bdConfig.header.reload, "CENTER", 1, 0)

-- lock/unlock button
bdConfig.header.lock = CreateFrame("Button", nil, bdConfig.header)
bdConfig.header.lock:SetPoint("RIGHT", bdConfig.header.reload, "LEFT", -2 ,0)
bdConfig.header.lock:SetSize(70, 28)
bdConfig.header.lock:SetBackdrop({bgFile = media.flat})
bdConfig.header.lock:SetBackdropColor(unpack(media.green))
bdConfig.header.lock:SetAlpha(0.6)
bdConfig.header.lock:EnableMouse(true)
bdConfig.header.lock:SetScript("OnEnter", function()
	bdConfig.header.lock:SetAlpha(1)
end)
bdConfig.header.lock:SetScript("OnLeave", function()
	bdConfig.header.lock:SetAlpha(0.6)
end)
bdConfig.header.lock:SetScript("OnClick", function(self)
	bdCore.toggleLock()

	if (self.x:GetText() == "Lock") then
		self.x:SetText("Unlock")
	else
		self.x:SetText("Lock")
	end
end)

bdConfig.header.lock.x = bdConfig.header.lock:CreateFontString(nil)
bdConfig.header.lock.x:SetFont(media.font, 12)
bdConfig.header.lock.x:SetText("Unlock")
bdConfig.header.lock.x:SetPoint("CENTER", bdConfig.header.lock, "CENTER", 1, 0)

-- main window
bdConfig.main = CreateFrame("frame",nil,bdConfig)
bdConfig.main:SetPoint("TOPLEFT",bdConfig.header,"BOTTOMLEFT")
bdConfig.main:SetPoint("BOTTOMRIGHT",bdConfig,"BOTTOMRIGHT", 0, 0)
bdCore:setBackdrop(bdConfig.main)

-- left
bdConfig.left = CreateFrame( "Frame", nil, bdConfig)
bdConfig.left:SetPoint("TOPLEFT", bdConfig.main, "TOPLEFT", 0, 0)
bdConfig.left:SetPoint("BOTTOMRIGHT", bdConfig.main, "BOTTOMLEFT", configDimensions.left_col, 0)
bdConfig.left:SetBackdrop({bgFile = media.flat})
bdConfig.left:SetBackdropColor(1,1,1,.05)

function bdCore:toggleConfig()
	if (bdConfig:IsShown()) then
		bdConfig:Hide()
	else
		bdConfig:Show()
		bdConfig.modules['General']:select()
		if (bdCore.moving) then
			bdConfig.header.lock.x:SetText("Lock")
		else
			bdConfig.header.lock.x:SetText("Unlock")
		end
	end
end

-- TABLES
-- bdConfig.buttons = {}
-- bdConfig.frames = {}

bdConfig.modules = {}
bdCore.modules = {}

--bdCore:hookEvent("bdcore_loaded",function() bdCore:toggleConfig() end)

local firstButton
local lastButton

function bdCore:addModule(name, configs, persistent)
	local module = CreateFrame('frame', nil, bdConfig)

	bdConfig.modules[name] = module
	bdCore.modules[name] = true

	module:SetPoint("TOPLEFT", bdConfig.left, "TOPRIGHT", 0, -2)
	module:SetPoint("BOTTOMRIGHT", bdConfig.main, "BOTTOMRIGHT", -2, 2)
	module:Hide()
	
	-- tabs
	module.tabs = CreateFrame("frame",nil,module)
	module.tabs:SetPoint("TOPLEFT", module, "TOPLEFT", 2, 0)
	module.tabs:SetPoint("BOTTOMRIGHT", module, "TOPRIGHT", 0, -30)
	module.tabs:SetBackdrop({bdFile = bdCore.media.flat})
	module.tabs:SetBackdropColor(1,1,1,1)
	
	-- bottom border to tabs
	module.tabs.bottom = module.tabs:CreateTexture(nil,"OVERLAY")
	module.tabs.bottom:SetTexture(bdCore.media.flat)
	module.tabs.bottom:SetVertexColor(unpack(bdCore.media.border))
	module.tabs.bottom:SetPoint("BOTTOMLEFT", module.tabs, "BOTTOMLEFT")
	module.tabs.bottom:SetPoint("TOPRIGHT", module.tabs, "BOTTOMRIGHT", 0, 2)

	-- Select
	function module:deselect()
		self:Hide()
		self.button:SetBackdropColor(0,0,0,0)
		self.active = false
	end
	function module:select()
		if (self.active) then return end

		-- deselect previous modules
		for name, frame in pairs(bdConfig.modules) do
			frame:deselect()
		end

		-- selec this module
		self.active = true
		self.button:SetBackdropColor(unpack(media.red))
		self:Show()

		-- deselct all tabs
		local tabs = {self.tabs:GetChildren()}
		for k, tab in pairs(tabs) do
			tab.active = nil
			tab:SetAlpha(0.6)
			tab.backdrop:SetVertexColor(1,1,1,.1)
		end

		local firstTab = tabs[0] or tabs[1]
		firstTab:Click()
	end

	-- Add Button
	function module:createButton()
		local button = CreateFrame('frame', nil, bdConfig)
		button:SetSize(configDimensions.left_col, 26)
		button:SetBackdrop({bgFile = media.flat})
		button:SetBackdropColor(0,0,0,0)
		button:EnableMouse(true)

		button.text = button:CreateFontString(nil, "OVERLAY")
		button.text:SetPoint("LEFT", button, "LEFT", 8, 0)
		button.text:SetFont(media.font, 14)
		button.text:SetText(name)

		-- Click scripts
		button:SetScript("OnEnter", function(self)
			if (module.active) then return end
			self:SetBackdropColor(1,1,1,0.1)
		end)
		button:SetScript("OnLeave", function(self)
			if (module.active) then return end
			self:SetBackdropColor(1,1,1,0)
		end)
		button:SetScript("OnMouseUp", function(self)
			module:select()
		end)

		-- position
		if (not lastButton) then
			button:SetPoint("TOP", bdConfig.left, "TOP", 0, 0)
		else
			button:SetPoint("TOP", lastButton, "BOTTOM", 0, 0)
		end
	
		-- set variables
		self.button = button
		lastButton = button
		firstButton = firstButton or button

		return button
	end

	-- Add Tabs
	function module:addTab(tabName)
		local tab = CreateFrame("Button", nil, self.tabs)

		tab.text = tab:CreateFontString(nil,"OVERLAY")
		tab.text:SetFont(bdCore.media.font, 14)
		tab.text:SetText(tabName)
		tab.text:SetAllPoints()
		tab:SetSize(tab.text:GetWidth()+30,26)

		if (self.lastTab) then
			tab:SetPoint("LEFT", self.lastTab, "RIGHT", 2, 0)
		else
			tab:SetPoint("LEFT", self.tabs, "LEFT", 4, 0)
		end

		tab.backdrop = tab:CreateTexture(nil,"OVERLAY")
		tab.backdrop:SetTexture(bdCore.media.flat)
		tab.backdrop:SetVertexColor(1,1,1,.1)
		tab.backdrop:SetAllPoints()

		-- select tab, select content
		function tab:select()
			local siblings = {self:GetParent():GetChildren()}

			-- unselect sibling tabs
			for k, frame in pairs(siblings) do
				frame.active = false
				frame:SetAlpha(0.6)
				frame.backdrop:SetVertexColor(1,1,1,.1)

				-- the scrollContent frame for this tab
				frame.container:Hide()
			end

			self.container:Show()
			self:SetAlpha(1)
			self.backdrop:SetVertexColor(unpack(bdCore.media.blue))
			self.active = true
		end

		-- Mouse scripts
		tab:SetScript("OnEnter", function(self)
			if (self.active) then return end
			self:SetAlpha(1)
		end)
		
		tab:SetScript("OnLeave", function(self)
			if (self.active) then return end
			self:SetAlpha(0.6)
		end)

		tab:SetScript("OnClick", function(self)
			if (self.active) then return end
			self:select()
		end)

		-----------------------------------------------
		-- Create scrollFrame for this tab
		-----------------------------------------------
		--parent frame 
		local scrollFrameParent = CreateFrame("Frame", "bdConfig"..tabName, module) 
		scrollFrameParent:SetPoint("TOPLEFT", module.tabs, "BOTTOMLEFT", 8, -8)
		scrollFrameParent:SetPoint("BOTTOMRIGHT", module, "BOTTOMRIGHT", -8, 8)

		--scrollframe 
		scrollContainer = CreateFrame("ScrollFrame", nil, scrollFrameParent) 
		scrollContainer:SetPoint("TOPRIGHT", scrollFrameParent, "TOPRIGHT", 0, 0) 
		scrollContainer:SetSize(scrollFrameParent:GetWidth(), scrollFrameParent:GetHeight()) 
		scrollFrameParent.scrollframe = scrollContainer 

		--scrollbar 
		scrollbar = CreateFrame("Slider", nil, scrollContainer, "UIPanelScrollBarTemplate") 
		scrollbar:SetPoint("TOPRIGHT", scrollFrameParent, "TOPRIGHT", 0, -16) 
		scrollbar:SetPoint("BOTTOMRIGHT", scrollFrameParent, "BOTTOMRIGHT", 0, 16) 
		scrollbar:SetMinMaxValues(1, math.ceil(scrollFrameParent:GetHeight()+1)) 
		scrollbar:SetValueStep(1) 
		scrollbar.scrollStep = 1 
		scrollbar:SetValue(0) 
		scrollbar:SetWidth(16) 
		scrollbar:SetScript("OnValueChanged", function (self, value) 
			self:GetParent():SetVerticalScroll(value) 
		end) 
		scrollbar:SetBackdrop({bgFile = media.flat})
		scrollbar:SetBackdropColor(0,0,0,.2)
		scrollFrameParent.scrollbar = scrollbar 

		--content frame 
		local content = CreateFrame("Frame", nil, scrollContainer) 
		content:SetPoint("TOPLEFT", scrollFrameParent, "TOPLEFT")
		content:SetSize(scrollFrameParent:GetWidth() - 32, scrollFrameParent:GetHeight()) 
		scrollContainer.content = content 
		scrollContainer:SetScrollChild(content)

		scrollFrameParent:SetScript("OnMouseWheel", function(self, delta)
			self.scrollbar:SetValue(self.scrollbar:GetValue() - (delta*20))
		end)

		self.lastTab = tab
		self.lastFrame = content
		self.scrollbar = scrollbar
		self.contentParent = scrollFrameParent
		tab.container = scrollFrameParent

		return content
	end

	local navigationButton = module:createButton()

	----------------------------------------------------
	-- Add configuration entries in for this addon
	----------------------------------------------------
	if (configs) then
		local scrollHeight = 0
		
		for i = 1, #configs do
			local conf = configs[i]		
			
			for option, info in pairs(conf) do

				-- store the variable in either the persitent or profile, as well as the smart_config
				if (info.persistent or persistent) then
					c.persistent[name] = c.persistent[name] or {}
					if (c.persistent[name][option] == nil) then
						if (info.value == nil) then
							info.value = {}
						end

						c.persistent[name][option] = info.value
					end
				else
					c.profile[name] = c.profile[name] or {}
					if (c.profile[name][option] == nil) then
						if (info.value == nil) then
							info.value = {}
						end

						c.profile[name][option] = info.value
					end
				end
				
				
				-- Create a general tab for everything to anchor to if no other tab is started
				if (info.type ~= "tab" and not module.lastTab) then
					module:addTab("General")
				end
				
				--scrollheight = panels.lastpanel.scrollheight

				local addedHeight = 0
				
				if (info.type == "slider") then
					addedHeight = bdCore:createSlider(name, option, info, persistent)
				elseif (info.type == "checkbox") then
					addedHeight = bdCore:createCheckButton(name, option, info, persistent)
				elseif (info.type == "dropdown") then
					addedHeight = bdCore:createDropdown(name, option, info, persistent)
				elseif (info.type == "text") then
					addedHeight = bdCore:createText(name, info)
				elseif (info.type == "list") then
					addedHeight = bdCore:createList(name, option, info, persistent)
				elseif (info.type == "tab") then
					if (module.lastTab) then
						module.scrollbar:SetMinMaxValues(1, math.max(1, scrollHeight - 320))
						if ((scrollHeight - 320) < 2) then
							module.scrollbar:Hide()
						end
					end
					scrollHeight = 0

					module:addTab(info.value)
					tabstarted = true
				elseif (info.type == "createbox") then
					addedHeight = bdCore:createBox(name, option, info, persistent)
				elseif (info.type == "actionbutton") then
					addedHeight = bdCore:createActionButton(name, option, info, persistent)
				elseif (info.type == "color") then
					addedHeight = bdCore:colorPicker(name, option, info, persistent)
				end

				scrollHeight = scrollHeight + addedHeight
			end

		end

		module.scrollbar:SetMinMaxValues(1, math.max(1, scrollHeight - 320))
		if ((scrollHeight - 320) < 2) then
			module.scrollbar:Hide()
		end
	end
	
	-- If there aren't additional tabs, act like non exist
	if (module.lastTab.text:GetText() == "General") then
		module.tabs:Hide()
		module.contentParent:SetPoint("TOPLEFT", module, "TOPLEFT", 8, -8)
	else
		module.tabs:Show()
	end
end


--------------------------------------------------
-- functions here
--------------------------------------------------
function bdConfig:createContainer(contentParent, size)
	if (not size) then 
		size = "full" 
	end

	local container = CreateFrame("frame", nil, contentParent)
	container:SetHeight(30)

	-- container.test = container:CreateTexture(nil, "BACKGROUND")
	-- container.test:SetAllPoints()
	-- container.test:SetTexture(bdCore.media.flat)
	-- container.test:SetVertexColor(1,1,1,1)
	-- container.test:SetAlpha(0.1)

	contentParent.row = contentParent.row or 0

	local row = contentParent.row
	local lastFrame = contentParent.lastFrame
	local position

	-- allow for 2 column layout
	if (size == "half") then
		if (row <= 1) then
			position = "aside"
			contentParent.row = contentParent.row + 1
		else
			position = "newline"
			contentParent.row = 1
		end
	else
		positoin = "newline"
		contentParent.row = 2
	end
	container:SetWidth(contentParent:GetWidth())
	
--[[
	if (position == "aside") then
		container:SetWidth(contentParent:GetWidth() / 2)

		if (not lastFrame) then
			container:SetPoint("TOPLEFT", contentParent, "TOPLEFT", 4, 0)
		else
			container:SetPoint("TOPLEFT", lastFrame, "TOPRIGHT", 0, 0)
		end
	elseif (position == "newline") then
		container:SetWidth(contentParent:GetWidth())

		if (not lastFrame) then
			container:SetPoint("TOPLEFT", contentParent, "TOPLEFT", 4, 0)
		else
			container:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
		end
	end--]]

	
	
	if (not lastFrame) then
		container:SetPoint("TOPLEFT", contentParent, "TOPLEFT", 4, 0)
	else
		container:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
	end
	

	contentParent.lastFrame = container

	return container
end
function bdCore:createActionButton(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame

	local container = bdConfig:createContainer(panel)

	local create = CreateFrame("Button", nil, panel)
	create:SetPoint("TOPLEFT", container, "TOPLEFT")
	create:SetText(info.value)
	bdCore:skinButton(create, false, "blue")

	-- create:SetSize(tab.text:GetWidth()+30,26)

	create:SetScript("OnClick", function()
		if (info.callback) then
			info.callback()
		end
	end)

	return container:GetHeight()
end
function bdCore:createBox(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame
	local create = CreateFrame("EditBox",nil,panel)

	local container = bdConfig:createContainer(panel)


	create:SetSize(200,24)
	bdCore:setBackdrop(create)
	create.background:SetVertexColor(.10,.14,.17,1)
	create:SetFont(bdCore.media.font,12)
	create:SetText(info.value)
	create:SetTextInsets(6, 2, 2, 2)
	create:SetMaxLetters(200)
	create:SetHistoryLines(1000)
	create:SetAutoFocus(false) 
	create:SetScript("OnEnterPressed", function(self, key) create.button:Click() end)
	create:SetScript("OnEscapePressed", function(self, key) self:ClearFocus() end)

	create:SetPoint("TOPLEFT", container, "TOPLEFT", 5, 0)

	create.label = create:CreateFontString(nil)
	create.label:SetFont(bdCore.media.font, 12)
	create.label:SetText(info.description)
	create.label:SetPoint("BOTTOMLEFT", create, "TOPLEFT", 0, 4)

	create.button = CreateFrame("Button", nil, create)
	create.button:SetPoint("LEFT", create, "RIGHT", 4, 0)
	create.button:SetText(info.button)
	bdCore:skinButton(create.button, false, "blue")
	create.button:SetScript("OnClick", function()
		if (info.callback) then
			info:callback(create:GetText())
			create:SetText("")
		end
	end)


	return container:GetHeight()
end

function bdCore:colorPicker(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame
	
	local container = bdConfig:createContainer(panel, "half")
	
	local picker = CreateFrame("button",nil,container)
	picker:SetSize(20, 20)
	picker:SetBackdrop({bgFile = bdCore.media.flat, edgeFile = bdCore.media.flat, edgeSize = 2, insets = {top = 2, right = 2, bottom = 2, left = 2}})
	if (info.persistent or persistent) then
		picker:SetBackdropColor(unpack(c.persistent[group][option]))
	else
		picker:SetBackdropColor(unpack(c.profile[group][option]))
	end
	picker:SetBackdropBorderColor(0,0,0,1)
	picker:SetPoint("LEFT", container, "LEFT", 0, 0)
	
	picker.callback = function(self, r, g, b, a)
		if (info.persistent or persistent) then
			c.persistent[group][option] = {r,g,b,a}
		else
			c.profile[group][option] = {r,g,b,a}
		end
		self:SetBackdropColor(r,g,b,a)

		if (info.callback) then
			info:callback()
		end
		
		return r, g, b, a
	end
	
	picker:SetScript("OnClick",function()		
		HideUIPanel(ColorPickerFrame)
		local r,g,b,a
		if (info.persistent or persistent) then
			r,g,b,a = unpack(c.persistent[group][option])
		else
			r,g,b,a = unpack(c.profile[group][option])
		end
		ColorPickerFrame:SetFrameStrata("FULLSCREEN_DIALOG")
		ColorPickerFrame:SetClampedToScreen(true)
		ColorPickerFrame.hasOpacity = true
		
		ColorPickerFrame.opacity = 1 - a
		ColorPickerFrame.old = {r, g, b, a}
		
		ColorPickerFrame.func = function()
			local r, g, b = ColorPickerFrame:GetColorRGB()
			local a = 1 - OpacitySliderFrame:GetValue()
			picker:callback(r, g, b, a)
		end
		ColorPickerFrame.opacityFunc = function()
			local r, g, b = ColorPickerFrame:GetColorRGB()
			local a = 1 - OpacitySliderFrame:GetValue()
			picker:callback(r, g, b, a)
		end
		
		--print(ColorPickerFrame:GetColorRGB())
		ColorPickerFrame:SetColorRGB(r, g, b)
		--print(ColorPickerFrame:GetColorRGB())
		--ColorPickerFrame.func()
		
		ColorPickerFrame.cancelFunc = function()
			local r, g, b, a = unpack(ColorPickerFrame.old) 
			picker:callback(r, g, b, a)
		end

		ColorPickerFrame:EnableKeyboard(false)
		ShowUIPanel(ColorPickerFrame)
	end)
	
	picker.text = picker:CreateFontString(nil,"OVERLAY")
	picker.text:SetFont(bdCore.media.font, 14)
	picker.text:SetText(info.name)
	picker.text:SetPoint("LEFT", picker, "RIGHT", 8, 0)

	return container:GetHeight()
end
function bdCore:createText(group, info)
	local panel = bdConfig.modules[group].lastFrame

	local container = bdConfig:createContainer(panel)

	local text = container:CreateFontString(nil)

	text:SetFont(media.font, 14)
	text:SetText(info.value)
	text:SetTextColor(0.8,0.8,0.8)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("TOP")
	text:SetAllPoints(container)

	local lines = math.ceil(strlen(info.value) / 108)

	container:SetHeight( (lines * 14) + 5)
	
	return container:GetHeight()
end

function bdCore:createList(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame
	
	local container = bdConfig:createContainer(panel)
	container:SetHeight(200)

	-- bdCore:setBackdrop(container)

	local title = container:CreateFontString(nil)
	local insertbox = CreateFrame("EditBox",nil, container)
	local button = CreateFrame("Button", nil, container)
	local list = CreateFrame("frame", nil, container)
	
	title:SetFont(media.font, 14)
	title:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
	title:SetText(info.label)

	insertbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
	insertbox:SetSize(container:GetWidth() - 66, 24)
	insertbox:SetFont(media.font,12)
	insertbox:SetTextInsets(6, 2, 2, 2)
	insertbox:SetMaxLetters(200)
	insertbox:SetHistoryLines(1000)
	insertbox:SetAutoFocus(false) 
	insertbox:SetScript("OnEnterPressed", function(self, key) button:Click() end)
	insertbox:SetScript("OnEscapePressed", function(self, key) self:ClearFocus() end)
	bdCore:setBackdrop(insertbox)
	insertbox.background:SetVertexColor(.10,.14,.17,1)

	insertbox.alert = insertbox:CreateFontString(nil)
	insertbox.alert:SetFont(bdCore.media.font,13)
	insertbox.alert:SetPoint("TOPRIGHT",container,"TOPRIGHT", -2, 0)

	function insertbox:startFade()
		local total = 0

		self.alert:Show()
		self:SetScript("OnUpdate",function(self, elapsed)
			total = total + elapsed
			if (total > 1.5) then
				self.alert:SetAlpha(self.alert:GetAlpha()-0.02)
				
				if (self.alert:GetAlpha() <= 0.05) then
					self:SetScript("OnUpdate", function() return end)
					self.alert:Hide()
				end
			end
		end)
	end

	button:SetPoint("TOPLEFT", insertbox, "TOPRIGHT", 0, 2)
	button:SetText("Add/Remove")
	bdCore:skinButton(button, false, "blue")
	insertbox:SetSize(container:GetWidth() - button:GetWidth() + 2, 24)

	button:SetScript("OnClick", function()
		local value = insertbox:GetText()

		if (strlen(value) > 0) then
			list:addRemove(insertbox:GetText())
		end

		insertbox:SetText("")
		insertbox:ClearFocus()
	end)

	list:SetPoint("TOPLEFT", insertbox, "BOTTOMLEFT", 0, -2)
	list:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT")

	--scrollframe 
	local scrollframe = CreateFrame("ScrollFrame", nil, list) 
	scrollframe:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -5) 
	scrollframe:SetSize(list:GetWidth(), list:GetHeight() - 10) 
	list.scrollframe = scrollframe 

	--scrollbar 
	local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
	scrollbar:SetPoint("TOPRIGHT", list, "TOPRIGHT", -2, -18) 
	scrollbar:SetPoint("BOTTOMLEFT", list, "BOTTOMRIGHT", -18, 18) 
	scrollbar:SetMinMaxValues(1, 600) 
	scrollbar:SetValueStep(1) 
	scrollbar.scrollStep = 1
	scrollbar:SetValue(0) 
	scrollbar:SetWidth(16) 
	scrollbar:SetScript("OnValueChanged", function (self, value) self:GetParent():SetVerticalScroll(value) self:SetValue(value) end) 
	scrollbar:SetBackdrop({bgFile = media.flat})
	scrollbar:SetBackdropColor(0,0,0,.2)
	list.scrollbar = scrollbar 

	--content frame 
	list.content = CreateFrame("Frame", nil, scrollframe) 
	list.content:SetPoint("TOPLEFT", list, "TOPLEFT") 
	list.content:SetSize(list:GetWidth(), list:GetHeight()) 
	scrollframe.content = list.content
	scrollframe:SetScrollChild(list.content)
	
	list.text = list.content:CreateFontString(nil)
	list.text:SetFont(media.font,12)
	list.text:SetPoint("TOPLEFT", list.content, "TOPLEFT", 5, 0)
	list.text:SetHeight(600)
	list.text:SetWidth(list:GetWidth()-10)
	list.text:SetJustifyH("LEFT")
	list.text:SetJustifyV("TOP")

	list.text:SetText("test")


	bdCore:setBackdrop(list)

	-- show all config entries in this list
	function list:populate()
		local string = "";
		local height = 0;

		if (info.persistent or persistent) then
			for k, v in pairs(c.persistent[group][option]) do
				string = string..k.."\n";
				height = height + 13
			end
		else
			for k, v in pairs(c.profile[group][option]) do
				string = string..k.."\n";
				height = height + 13
			end
		end

		local scrollheight = height-200
		if (scrollheight < 1) then 
			scrollheight = 1 
			scrollbar:Hide()
		else
			scrollbar:Show()
			list:SetScript("OnMouseWheel", function(self, delta) self.scrollbar:SetValue(self.scrollbar:GetValue() - (delta*30)) end)
		end

		scrollbar:SetMinMaxValues(1,scrollheight)

		list.text:SetHeight(height)
		list.text:SetText(string)
	end

	-- remove or add something, then redraw the text
	function list:addRemove(value)
		if (info.persistent or persistent) then
			if (c.persistent[group][option][value]) then
				c.persistent[group][option][value] = nil
				insertbox.alert:SetText(value.." removed")
				insertbox.alert:SetTextColor(1, .3, .3)
				insertbox:startFade()
			else
				c.persistent[group][option][value] = true
				insertbox.alert:SetText(value.." added")
				insertbox.alert:SetTextColor(.3, 1, .3)
				insertbox:startFade()
			end
		else
			if (c.profile[group][option][value]) then
				c.profile[group][option][value] = nil
				insertbox.alert:SetText(value.." removed")
				insertbox.alert:SetTextColor(1, .3, .3)
				insertbox:startFade()
			else
				c.profile[group][option][value] = true
				insertbox.alert:SetText(value.." added")
				insertbox.alert:SetTextColor(.3, 1, .3)
				insertbox:startFade()
			end
		end
		self:populate()

		if (info.callback) then
			info:callback()
		end
	end

	list:populate()

	return container:GetHeight()
end

function bdCore:createDropdown(group, option, info, custompanel, persistent)
	local panel = bdConfig.modules[group].lastFrame
	local container = bdConfig:createContainer(panel)

	container:SetHeight(50)

	local label = container:CreateFontString(nil)
	label:SetFont(media.font, 14)
	label:SetPoint("TOPLEFT", container, "TOPLEFT")
	-- label:SetWidth(container:GetWidth())
	label:SetText(info.label)

	local selectbox = CreateFrame("Frame", nil, container)
	selectbox:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -4)
	selectbox:SetSize(container:GetWidth(), 25)
	bdCore:setBackdrop(selectbox)

	selectbox.arrow = selectbox:CreateTexture(nil,"OVERLAY")
	selectbox.arrow:SetTexture(media.arrowdown)
	selectbox.arrow:SetSize(8, 6)
	selectbox.arrow:SetVertexColor(1,1,1,.4)
	selectbox.arrow:SetPoint("RIGHT", selectbox, "RIGHT", -6, 1)
	selectbox.arrow:Show()

	selectbox.selected = selectbox:CreateFontString(nil)
	selectbox.selected:SetFont(media.font, 13)
	selectbox.selected:SetPoint("LEFT", selectbox, "LEFT", 6, 0)

	local dropdown = CreateFrame("Frame", nil, container)
	dropdown:SetPoint("TOPLEFT", selectbox, "BOTTOMLEFT", -2, 0)
	dropdown:SetPoint("TOPRIGHT", selectbox, "BOTTOMRIGHT", 2, 0)
	
	-- override setting into this box
	if (info.override) then
		c.profile[group][option] = info.value
		selectbox.selected:SetText(c.profile[group][option])
	else
		if (info.persistent or persistent) then
			selectbox.selected:SetText(c.persistent[group][option])
		else
			selectbox.selected:SetText(c.profile[group][option])
		end
	end
	
	function selectbox:click()
		if (dropdown.dropped) then
			dropdown:Hide()
			dropdown.dropped = false
			selectbox.background:SetVertexColor(.11,.15,.18, 1)
			selectbox.arrow:SetTexture(media.arrowdown)
		else
			dropdown:Show()
			dropdown.dropped = true
			selectbox.background:SetVertexColor(1,1,1,.05)
			selectbox.arrow:SetTexture(media.arrowup)
		end
	end
	
	selectbox:SetScript("OnMouseDown", function() selectbox:click()end)

	dropdown:Hide()
	dropdown:SetFrameLevel(10)
	dropdown:SetBackdrop({
		bgFile = bdCore.media.flat, 
		edgeFile = bdCore.media.flat, edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	dropdown:SetBackdropColor(.18,.22,.25,1)
	dropdown:SetBackdropBorderColor(.06, .08, .09, 1)
	dropdown.dropped = false

	dropdown.items = {}
	dropdown.lastframe = nil
	dropdown.populate = function(self, items)
		self.lastframe = nil
		self:SetSize(selectbox:GetWidth()+4, 25*#items)
		for i = 1, #items do
			local item = self.items[i] or CreateFrame("Button", nil, self)
			item:SetSize(self:GetWidth()-4, 25)
			item:SetBackdrop({bgFile = bdCore.media.flat, })
			item:SetBackdropColor(0,0,0,0)
			item:SetScript("OnEnter",function() item:SetBackdropColor(.21,.25,.29,1) end)
			item:SetScript("OnLeave",function() item:SetBackdropColor(0,0,0,0) end)
			item.label = item.label or item:CreateFontString(nil)
			item.label:SetFont(media.font, 13)
			item.label:SetPoint("LEFT", item, "LEFT", 6, 0)
			item.label:SetText(items[i])
			item.id = i
			item:ClearAllPoints()

			--if (not self.lastFrame or self.lastFrame == item) then
				item:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -((i-1)*25 + 2))
			--else	
				--item:SetPoint("TOPLEFT", self.lastFrame, "BOTTOMLEFT", 0, 0)
			--end
			
			item:SetScript("OnClick", function(self)
				local text = self.label:GetText()

				if (info.persistent or persistent) then
					c.persistent[group][option] = text
				else
					c.profile[group][option] = text
				end

				if (info.callback) then
					info:callback(text)
				end
			
				selectbox.selected:SetText(text)
				selectbox:click()
			end)
			self.items[i] = item
			self.lastFrame = item
		end
	end
	local items = info.options
	dropdown:populate(items)

	if (info.update) then
		bdCore:hookEvent(info.updateOn, function()
			info.update(dropdown)
		end)
	end

	return container:GetHeight()
end

function bdCore:createSlider(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame
	local container = bdConfig:createContainer(panel)
	container:SetHeight(50)

	local slider = CreateFrame("Slider", "bdCore_"..group..":"..option, panel, "OptionsSliderTemplate")
	slider:SetWidth(container:GetWidth())
	slider:SetHeight(14)
	slider:SetPoint("TOPLEFT", container ,"TOPLEFT", 0, -20)
	
	slider:SetOrientation('HORIZONTAL')
	slider:SetMinMaxValues(info.min, info.max)
	slider:SetObeyStepOnDrag(true)
	slider:SetValueStep(info.step)
	slider.tooltipText = info.tooltip
	_G[slider:GetName() .. 'Low']:SetText(info.min);
	_G[slider:GetName() .. 'Low']:SetTextColor(1,1,1);
	_G[slider:GetName() .. 'Low']:SetFont(media.font, 12)
	_G[slider:GetName() .. 'Low']:ClearAllPoints()
	_G[slider:GetName() .. 'Low']:SetPoint("TOPLEFT",slider,"BOTTOMLEFT",0,-1)

	_G[slider:GetName() .. 'High']:SetText(info.max);
	_G[slider:GetName() .. 'High']:SetTextColor(1,1,1);
	_G[slider:GetName() .. 'High']:SetFont(media.font, 12)
	_G[slider:GetName() .. 'High']:ClearAllPoints()
	_G[slider:GetName() .. 'High']:SetPoint("TOPRIGHT",slider,"BOTTOMRIGHT",0,-1)

	_G[slider:GetName() .. 'Text']:SetText(info.label);
	_G[slider:GetName() .. 'Text']:SetTextColor(1,1,1);
	_G[slider:GetName() .. 'Text']:SetFont(media.font, 14)
	
	slider.value = slider:CreateFontString(nil)
	slider.value:SetFont(media.font, 12)

	if (info.persistent or persistent) then
		slider:SetValue(c.persistent[group][option])
		slider.value:SetText(c.persistent[group][option])
	else
		slider:SetValue(c.profile[group][option])
		slider.value:SetText(c.profile[group][option])
	end
	slider.value:SetTextColor(1,1,1)
	slider.value:SetPoint("TOP", slider,"BOTTOM", 0, -2)
	slider:Show()
	slider:SetScript("OnValueChanged", function(self)
		local newval = round(slider:GetValue(), 1)

		if (info.persistent or persistent) then
			if (c.persistent[group][option] == newval) then -- throttle it changing on every pixel
				return false
			end

			c.persistent[group][option] = newval
		else
			if (c.profile[group][option] == newval) then -- throttle it changing on every pixel
				return false
			end

			c.profile[group][option] = newval
		end

		slider:SetValue(newval)
		slider.value:SetText(newval)
		
		if (info.callback) then
			info:callback()
		end
	end)

	return container:GetHeight()
end

function bdCore:createCheckButton(group, option, info, persistent)
	local panel = bdConfig.modules[group].lastFrame
	local container = bdConfig:createContainer(panel, "half")

	local check = CreateFrame("CheckButton", "bdCore_"..group..":"..option, container, "ChatConfigCheckButtonTemplate")

	check:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
	
	_G[check:GetName().."Text"]:SetText(info.label)
	_G[check:GetName().."Text"]:SetFont(bdCore.media.font, 14)
	_G[check:GetName().."Text"]:ClearAllPoints()
	_G[check:GetName().."Text"]:SetPoint("LEFT", check, "RIGHT", 2, 1)
	check.tooltip = info.tooltip;
	if (info.persistent or persistent) then
		check:SetChecked(c.persistent[group][option])
	else
		check:SetChecked(c.profile[group][option])
	end
	check:SetScript("OnClick", function(self)
		if (info.persistent or persistent) then
			c.persistent[group][option] = self:GetChecked()
		else
			c.profile[group][option] = self:GetChecked()
		end
		
		if (info.callback) then
			info:callback(check)
		end
	end)
	
	return container:GetHeight()
end

f.config = bdConfig