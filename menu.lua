--[[ oUF_PhantomMenace
	This is a layout for the incredibly awesome oUF by haste.
	
	PLEASE NOTE that this layout comes with no warranty and "as it is". It was created to fit my very own
	needs, so please understand, that I'll not put any effort in "fixing" something for you, "adding" something
	for you or make any changes to this.
	Anyway, when you read this, you've already downloaded my layout, so please, feel free to modify it to your
	own needs.
]]

local ADDON_NAME, ns = ...								-- get the addons namespace to exchange functions between core and layout
local menu = {}

local lib = ns.lib										-- get the lib
local settings = ns.settings							-- get the settings

local elementPadding = 5
local needReload = false

local MenuAnchorPoints = {
	{ text = 'TOPLEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('TOPLEFT') end },
	{ text = 'TOP', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('TOP') end },
	{ text = 'TOPRIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('TOPRIGHT') end },
	{ text = 'RIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('RIGHT') end },
	{ text = 'BOTTOMRIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('BOTTOMRIGHT') end },
	{ text = 'BOTTOM', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('BOTTOM') end },
	{ text = 'BOTTOMLEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('BOTTOMLEFT') end },
	{ text = 'LEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_anchorPointText']:SetText('LEFT') end },
}

local MenuRelativePoints = {
	{ text = 'TOPLEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('TOPLEFT') end },
	{ text = 'TOP', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('TOP') end },
	{ text = 'TOPRIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('TOPRIGHT') end },
	{ text = 'RIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('RIGHT') end },
	{ text = 'BOTTOMRIGHT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('BOTTOMRIGHT') end },
	{ text = 'BOTTOM', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('BOTTOM') end },
	{ text = 'BOTTOMLEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('BOTTOMLEFT') end },
	{ text = 'LEFT', notCheckable = true, func = function() _G['oUF_PhantomMenace_MenuPositions_relativePointText']:SetText('LEFT') end },
}


-- ***** POPUPS ****************************************************************************************

	--[[
	
	]]
	StaticPopupDialogs['OUF_PHANTOMMENACE_POPUP_MENUMAIN_DEFAULTS'] = {
		text = 'Would you like to set oUF_PhantomMenace to default?',
		button1 = 'Ok',
		OnAccept = function()
			PhantomMenaceOptions.healerMode = settings.options.healerMode
			PhantomMenaceOptions.debuffHighlight = settings.options.debuffHighlight
			PhantomMenaceOptions.aggroHighlight = settings.options.aggroHighlight

			PhantomMenacePositions.player = settings.positions.player
			PhantomMenacePositions.target = settings.positions.target
			PhantomMenacePositions.focus = settings.positions.focus
			PhantomMenacePositions.targettarget = settings.positions.targettarget
			PhantomMenacePositions.focustarget = settings.positions.focustarget
			PhantomMenacePositions.party = settings.positions.party
			PhantomMenacePositions.party_healer = settings.positions.party_healer
			PhantomMenacePositions.raid = settings.positions.raid
			PhantomMenacePositions.raid_healer = settings.positions.raid_healer
			PhantomMenacePositions.maintank = settings.positions.maintank
			PhantomMenacePositions.maintank_healer = settings.positions.maintank_healer
			PhantomMenacePositions.boss = settings.positions.boss

			PhantomMenaceOptions.strings.dead = settings.options.strings.dead
			PhantomMenaceOptions.strings.ghost = settings.options.strings.ghost
			PhantomMenaceOptions.strings.offline = settings.options.strings.offline

			-- Updating the elements
			menu.settings.elements.healerMode:SetChecked(PhantomMenaceOptions.healerMode and true or false)
			menu.settings.elements.debuffHighlight:SetChecked(PhantomMenaceOptions.debuffHighlight and true or false)
			menu.settings.elements.aggroHighlight:SetChecked(PhantomMenaceOptions.aggroHighlight and true or false)
			menu.strings.elements.stringDead:SetText(PhantomMenaceOptions.strings.dead)
			menu.strings.elements.stringGhost:SetText(PhantomMenaceOptions.strings.ghost)
			menu.strings.elements.stringOff:SetText(PhantomMenaceOptions.strings.offline)
			StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_RELOAD')
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
	}

	--[[
	
	]]
	StaticPopupDialogs['OUF_PHANTOMMENACE_POPUP_RELOAD'] = {
		text = 'Some settings require a reload of the UI!',
		button1 = 'Ok',
		OnAccept = function()
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
	}




-- ***** CALLBACKS *************************************************************************************


-- ***** FUNCTIONS *************************************************************************************

	--[[
	
	]]
	local function LoadPositions(frame)
		menu.positions.elements.xCoord:SetText(PhantomMenacePositions[frame].x)
		menu.positions.elements.yCoord:SetText(PhantomMenacePositions[frame].y)
		_G[menu.positions.elements.anchorPoint:GetName()..'Text']:SetText(PhantomMenacePositions[frame].anchorPoint)
		-- menu.positions.elements.relativeTo:SetText(PhantomMenacePositions[frame].anchorToFrame)
		_G[menu.positions.elements.relativeTo:GetName()..'Text']:SetText(PhantomMenacePositions[frame].anchorToFrame)
		_G[menu.positions.elements.relativePoint:GetName()..'Text']:SetText(PhantomMenacePositions[frame].anchorToPoint)
	end


-- ***** WIDGETS ***************************************************************************************

	--[[
	
	]]
	local function CreatePanel(panelParent, panelName, panelCaption, panelTitle, panelSubTitle)
		local f = CreateFrame('Frame', panelName, UIParent)

		f.name = panelCaption
		f.parent = panelParent

		f.title = f:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
		f.title:SetPoint('TOPLEFT', 16, -16)
		f.title:SetText(panelTitle)

		f.subtext = f:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		f.subtext:SetHeight(32)
		f.subtext:SetPoint('TOPLEFT', f.title, 'BOTTOMLEFT', 0, -8)
		f.subtext:SetPoint('RIGHT', f, -32, 0)
		f.subtext:SetNonSpaceWrap(true)
		f.subtext:SetJustifyH('LEFT')
		f.subtext:SetJustifyV('TOP')
		f.subtext:SetText(panelSubTitle)

		f.elements = {}

		InterfaceOptions_AddCategory(f)

		return f
	end


	--[[
	
	]]
	local function CreateBox(parent, name, text)
		local box = CreateFrame('Frame', name, parent, 'OptionsBoxTemplate')
		box:SetBackdropBorderColor(0.4, 0.4, 0.4)
		box:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
		_G[name..'Title']:SetText(text)
		return box
	end


	--[[
	
	]]
	local function CreateCheckbox(name, parent, label)
		local f = CreateFrame('CheckButton', 'oUF_PhantomMenace_Menu_'..name, parent, 'InterfaceOptionsCheckButtonTemplate')
		_G['oUF_PhantomMenace_Menu_'..name..'Text']:SetText(label)
		f:SetScript('OnClick', function()
			f:SetChecked((f:GetChecked() and true) or false)
			needReload = true
		end)
		return f
	end


	--[[
	
	]]
	local function CreateFrameSelectorButton(caption, key, parent, title, current)
		local b = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButton'..caption, parent, 'OptionsButtonTemplate')
		b:SetText(caption)
		b:SetScript('OnClick', function()
			title:SetText(caption)
			menu.positions.current = key
			if ( (key == 'party') or (key == 'raid') or (key == 'maintank') ) then
				_G['oUF_PhantomMenace_MenuPositions_healerToggle']:Show()
				if ( _G['oUF_PhantomMenace_Menu_healerMode']:GetChecked() and true ) then
					key = key..'_healer'
					_G['oUF_PhantomMenace_MenuPositions_healerToggle']:SetChecked(true)
				end
			else
				_G['oUF_PhantomMenace_MenuPositions_healerToggle']:Hide()
			end
			LoadPositions(key)
		end)
		return b
	end


	
-- ***** PANELS ****************************************************************************************

	local function CreateConfiguration()

		--[[ SETTINGS
		
		]]
		do
			menu.settings = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuSettings', 'Settings', 'oUF_PhantomMenace - Settings', 'General settings can be made here.')

			menu.settings.elements.healerMode = CreateCheckbox('healerMode', menu.settings, 'HealerMode')
			menu.settings.elements.healerMode:SetPoint('TOPLEFT', menu.settings.subtext, 'BOTTOMLEFT', 0, -10)

			menu.settings.elements.debuffHighlight = CreateCheckbox('debuffHighlight', menu.settings, 'DebuffHighlight')
			menu.settings.elements.debuffHighlight:SetPoint('TOPLEFT', menu.settings.elements.healerMode, 'BOTTOMLEFT', 0, -elementPadding)

			menu.settings.elements.aggroHighlight = CreateCheckbox('aggroHighlight', menu.settings, 'AggroHighlight')
			menu.settings.elements.aggroHighlight:SetPoint('TOPLEFT', menu.settings.elements.debuffHighlight, 'BOTTOMLEFT', 0, -elementPadding)

			menu.settings.box1 = CreateBox(menu.settings, 'oUF_PhantomMenace_Menu_Box1', 'Features')
			menu.settings.box1:SetPoint('TOPLEFT', menu.settings.elements.healerMode, 'TOPLEFT', -5, 5)
			menu.settings.box1:SetPoint('BOTTOM', menu.settings.elements.aggroHighlight, 'BOTTOM', 0, -5)
			menu.settings.box1:SetPoint('RIGHT', menu.settings, 'RIGHT', -32, 0)

			menu.settings:SetScript('OnShow', function()
				-- lib.debugging('menu.settings:OnShow()')
				menu.settings.elements.healerMode:SetChecked(PhantomMenaceOptions.healerMode and true or false)
				menu.settings.elements.debuffHighlight:SetChecked(PhantomMenaceOptions.debuffHighlight and true or false)
				menu.settings.elements.aggroHighlight:SetChecked(PhantomMenaceOptions.aggroHighlight and true or false)
				needReload = false
			end)

			menu.settings.okay = function()
				PhantomMenaceOptions.healerMode = ((menu.settings.elements.healerMode:GetChecked() and true) or false)
				PhantomMenaceOptions.debuffHighlight = ((menu.settings.elements.debuffHighlight:GetChecked() and true) or false)
				PhantomMenaceOptions.aggroHighlight = ((menu.settings.elements.aggroHighlight:GetChecked() and true) or false)
				if ( needReload ) then
					StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_RELOAD')
				end
			end

		end


		--[[ POSITIONS

		]]
		do
			menu.positions = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuPositions', 'Positions', 'oUF_PhantomMenace - Positions', 'The positions of the various unitframes can be adjusted here.')

			menu.positions.current = nil

			menu.positions.elements.title = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')

			menu.positions.elements.buttonPlayer = CreateFrameSelectorButton('Player', 'player', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonPlayer:SetPoint('TOPLEFT', menu.positions.subtext, 'BOTTOMLEFT', 2, -elementPadding)

			menu.positions.elements.buttonPet = CreateFrameSelectorButton('Pet', 'pet', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonPet:SetPoint('TOPLEFT', menu.positions.elements.buttonPlayer, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonTarget = CreateFrameSelectorButton('Target', 'target', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonTarget:SetPoint('TOPLEFT', menu.positions.elements.buttonPet, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonTargettarget = CreateFrameSelectorButton('Targettarget', 'targettarget', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonTargettarget:SetPoint('TOPLEFT', menu.positions.elements.buttonTarget, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonFocus = CreateFrameSelectorButton('Focus', 'focus', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonFocus:SetPoint('TOPLEFT', menu.positions.elements.buttonTargettarget, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonFocustarget = CreateFrameSelectorButton('Focustarget', 'focustarget', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonFocustarget:SetPoint('TOPLEFT', menu.positions.elements.buttonFocus, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonParty = CreateFrameSelectorButton('Party', 'party', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonParty:SetPoint('TOPLEFT', menu.positions.elements.buttonFocustarget, 'BOTTOMLEFT', 0, -elementPadding)
	
			menu.positions.elements.buttonRaid = CreateFrameSelectorButton('Raid', 'raid', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonRaid:SetPoint('TOPLEFT', menu.positions.elements.buttonParty, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonMT = CreateFrameSelectorButton('Maintank', 'maintank', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonMT:SetPoint('TOPLEFT', menu.positions.elements.buttonRaid, 'BOTTOMLEFT', 0, -elementPadding)

			menu.positions.elements.buttonBoss = CreateFrameSelectorButton('Boss', 'boss', menu.positions, menu.positions.elements.title, menu.positions.current)
			menu.positions.elements.buttonBoss:SetPoint('TOPLEFT', menu.positions.elements.buttonMT, 'BOTTOMLEFT', 0, -elementPadding)

			--[[
				ADJUSTMENT
			]]
			menu.positions.box1 = CreateBox(menu.positions, 'oUF_PhantomMenace_MenuPositions_Box1', 'Frames')
			menu.positions.box1:SetPoint('TOPLEFT', menu.positions.elements.buttonPlayer, 'TOPLEFT', -7, 7)
			menu.positions.box1:SetPoint('BOTTOMRIGHT', menu.positions.elements.buttonBoss, 'BOTTOMRIGHT', 7, -7)

			menu.positions.box2 = CreateBox(menu.positions, 'oUF_PhantomMenace_MenuPositions_Box2', 'Settings')
			menu.positions.box2:SetPoint('TOPLEFT', menu.positions.box1, 'TOPRIGHT', 10, 0)
			menu.positions.box2:SetPoint('BOTTOM', menu.positions.box1, 'BOTTOM', 0, -25)
			menu.positions.box2:SetPoint('RIGHT', menu.positions, 'RIGHT', -15, 0)

			-- menu.positions.elements.title = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			menu.positions.elements.title:SetPoint('TOPLEFT', menu.positions.box2, 'TOPLEFT', 15, -10)
			menu.positions.elements.title:SetText('no frame selected')

			menu.positions.elements.xCoord = CreateFrame('EditBox', 'oUF_PhantomMenace_MenuPositions_xCoord', menu.positions, 'InputBoxTemplate')
			menu.positions.elements.xCoord:SetAutoFocus(false)
			menu.positions.elements.xCoord:SetHeight(50)
			menu.positions.elements.xCoord:SetWidth(100)
			menu.positions.elements.xCoord:SetPoint('TOPLEFT', menu.positions.elements.title, 'BOTTOMLEFT', 5, -10)
			menu.positions.elements.xCoordCaption = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.positions.elements.xCoordCaption:SetPoint('BOTTOMLEFT', menu.positions.elements.xCoord, 'TOPLEFT', 0, -15)
			menu.positions.elements.xCoordCaption:SetText('xCoord')

			menu.positions.elements.yCoord = CreateFrame('EditBox', 'oUF_PhantomMenace_MenuPositions_yCoord', menu.positions, 'InputBoxTemplate')
			menu.positions.elements.yCoord:SetAutoFocus(false)
			menu.positions.elements.yCoord:SetHeight(50)
			menu.positions.elements.yCoord:SetWidth(100)
			menu.positions.elements.yCoord:SetPoint('TOPLEFT', menu.positions.elements.xCoord, 'TOPRIGHT', 25, 0)
			menu.positions.elements.yCoordCaption = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.positions.elements.yCoordCaption:SetPoint('BOTTOMLEFT', menu.positions.elements.yCoord, 'TOPLEFT', 0, -15)
			menu.positions.elements.yCoordCaption:SetText('yCoord')

			menu.positions.elements.anchorPoint = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositions_anchorPoint', menu.positions, 'UIDropDownMenuTemplate')
			menu.positions.elements.anchorPoint:SetPoint('TOPLEFT', menu.positions.elements.xCoord, 'BOTTOMLEFT', -20, -10)
			menu.positions.elements.anchorPoint:SetScript('OnShow', function()
				-- lib.debugging('anchorPoint:OnShow()')
				UIDropDownMenu_Initialize(menu.positions.elements.anchorPoint, function()
					local i
					local info = {}
					for i = 1, #MenuAnchorPoints do
						info.text = MenuAnchorPoints[i].text
						info.notCheckable = MenuAnchorPoints[i].notCheckable
						info.func = MenuAnchorPoints[i].func
						UIDropDownMenu_AddButton(info)
					end
				end)
			end)
			menu.positions.elements.anchorPointCaption = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.positions.elements.anchorPointCaption:SetPoint('BOTTOMLEFT', menu.positions.elements.anchorPoint, 'TOPLEFT', 20, 0)
			menu.positions.elements.anchorPointCaption:SetText('anchorPoint')

			menu.positions.elements.relativeTo = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositions_relativeTo', menu.positions, 'UIDropDownMenuTemplate')
			menu.positions.elements.relativeTo:SetPoint('TOPLEFT', menu.positions.elements.anchorPoint, 'BOTTOMLEFT', 0, -15)
			menu.positions.elements.relativeTo:SetScript('OnShow', function()
				-- lib.debugging('relativeTo:OnShow()')
				UIDropDownMenu_Initialize(menu.positions.elements.relativeTo, function()
					local i
					local info = {}

					info.text = 'UIParent'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText('UIParent')
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Player'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.player)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Pet'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.pet)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Target'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.target)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Targettarget'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.targettarget)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Focus'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.focus)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Focustarget'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.focustarget)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Party'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.party)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Raid'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.raid)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Maintank'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.maintank)
					end
					UIDropDownMenu_AddButton(info)

					info.text = 'Boss'
					info.notCheckable = true
					info.func = function()
						_G['oUF_PhantomMenace_MenuPositions_relativeToText']:SetText(settings.src.unitNames.boss)
					end
					UIDropDownMenu_AddButton(info)
				end)
			end)
			menu.positions.elements.relativeToCaption = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.positions.elements.relativeToCaption:SetPoint('BOTTOMLEFT', menu.positions.elements.relativeTo, 'TOPLEFT', 20, 0)
			menu.positions.elements.relativeToCaption:SetText('relativeTo')

			menu.positions.elements.relativePoint = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositions_relativePoint', menu.positions, 'UIDropDownMenuTemplate')
			menu.positions.elements.relativePoint:SetPoint('TOPLEFT', menu.positions.elements.relativeTo, 'BOTTOMLEFT', 0, -15)
			menu.positions.elements.relativePoint:SetScript('OnShow', function()
				-- lib.debugging('anchorPoint:OnShow()')
				UIDropDownMenu_Initialize(menu.positions.elements.relativePoint, function()
					local i
					local info = {}
					for i = 1, #MenuRelativePoints do
						info.text = MenuRelativePoints[i].text
						info.notCheckable = MenuRelativePoints[i].notCheckable
						info.func = MenuRelativePoints[i].func
						UIDropDownMenu_AddButton(info)
					end
				end)
			end)
			menu.positions.elements.relativePointCaption = menu.positions:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.positions.elements.relativePointCaption:SetPoint('BOTTOMLEFT', menu.positions.elements.relativePoint, 'TOPLEFT', 20, 0)
			menu.positions.elements.relativePointCaption:SetText('relativePoint')

			menu.positions.elements.healerToggle = CreateFrame('CheckButton', 'oUF_PhantomMenace_MenuPositions_healerToggle', menu.positions, 'InterfaceOptionsCheckButtonTemplate')
			_G['oUF_PhantomMenace_MenuPositions_healerToggleText']:SetText('Healer Mode')
			menu.positions.elements.healerToggle:SetPoint('TOPLEFT', menu.positions.elements.relativePointCaption, 'BOTTOMLEFT', -5, -70)
			menu.positions.elements.healerToggle:Hide()

			menu.positions.elements.applyButton = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsApplyButton', menu.positions, 'OptionsButtonTemplate')
			menu.positions.elements.applyButton:SetText('set position')
			menu.positions.elements.applyButton:SetPoint('TOPLEFT', menu.positions.elements.healerToggle, 'TOPRIGHT', 125, 0)
			menu.positions.elements.applyButton:SetScript('OnClick', function()
				lib.debugging(menu.positions.current)
				PhantomMenacePositions[menu.positions.current].x = menu.positions.elements.xCoord:GetText()
				PhantomMenacePositions[menu.positions.current].y = menu.positions.elements.yCoord:GetText()
				PhantomMenacePositions[menu.positions.current].anchorPoint = _G[menu.positions.elements.anchorPoint:GetName()..'Text']:GetText()
				PhantomMenacePositions[menu.positions.current].anchorToFrame = _G[menu.positions.elements.relativeTo:GetName()..'Text']:GetText()
				PhantomMenacePositions[menu.positions.current].anchorToPoint = _G[menu.positions.elements.relativePoint:GetName()..'Text']:GetText()
				_G[settings.src.unitNames[menu.positions.current]]:SetPoint(PhantomMenacePositions[menu.positions.current].anchorPoint, PhantomMenacePositions[menu.positions.current].relativeTo, PhantomMenacePositions[menu.positions.current].relativePoint, PhantomMenacePositions[menu.positions.current].x, PhantomMenacePositions[menu.positions.current].y)
			end)

		end


		--[[ BUFFS/DEBUFFS

		]]
		do
			menu.buffs = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuBuffsDebuffs', 'Buffs/Debuffs', 'oUF_PhantomMenace - Buffs/Debuffs', 'Apply buff-/debuff-filter here.')
		end


		--[[ STRINGS
		
		]]
		do
			menu.strings = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuStrings', 'Strings', 'oUF_PhantomMenace - Strings', 'Alter the strings here.')

			menu.strings.elements.stringDead = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringDead', menu.strings, 'InputBoxTemplate')
			menu.strings.elements.stringDead:SetAutoFocus(false)
			menu.strings.elements.stringDead:SetHeight(50)
			menu.strings.elements.stringDead:SetPoint('TOPLEFT', menu.strings.subtext, 'BOTTOMLEFT', 10, -20)
			menu.strings.elements.stringDead:SetPoint('RIGHT', menu.strings, 'RIGHT', -100, 0)
			menu.strings.stringDeadCaption = menu.strings:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.strings.stringDeadCaption:SetPoint('BOTTOMLEFT', menu.strings.elements.stringDead, 'TOPLEFT', 0, -15)
			menu.strings.stringDeadCaption:SetText('dead')

			menu.strings.elements.stringGhost = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringGhost', menu.strings, 'InputBoxTemplate')
			menu.strings.elements.stringGhost:SetAutoFocus(false)
			menu.strings.elements.stringGhost:SetHeight(50)
			menu.strings.elements.stringGhost:SetPoint('TOPLEFT', menu.strings.elements.stringDead, 'BOTTOMLEFT', 0, 0)
			menu.strings.elements.stringGhost:SetPoint('RIGHT', menu.strings, 'RIGHT', -100, 0)
			menu.strings.stringGhostCaption = menu.strings:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.strings.stringGhostCaption:SetPoint('BOTTOMLEFT', menu.strings.elements.stringGhost, 'TOPLEFT', 0, -15)
			menu.strings.stringGhostCaption:SetText('ghost')

			menu.strings.elements.stringOff = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringOff', menu.strings, 'InputBoxTemplate')
			menu.strings.elements.stringOff:SetAutoFocus(false)
			menu.strings.elements.stringOff:SetHeight(50)
			menu.strings.elements.stringOff:SetPoint('TOPLEFT', menu.strings.elements.stringGhost, 'BOTTOMLEFT', 0, 0)
			menu.strings.elements.stringOff:SetPoint('RIGHT', menu.strings, 'RIGHT', -100, 0)
			menu.strings.stringOffCaption = menu.strings:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			menu.strings.stringOffCaption:SetPoint('BOTTOMLEFT', menu.strings.elements.stringOff, 'TOPLEFT', 0, -15)
			menu.strings.stringOffCaption:SetText('offline')

			menu.strings.box2 = CreateBox(menu.strings, 'oUF_PhantomMenace_Menu_Box2', 'Strings')
			menu.strings.box2:SetPoint('TOPLEFT', menu.strings.elements.stringDead, 'TOPLEFT', -15, 7)
			menu.strings.box2:SetPoint('BOTTOM', menu.strings.elements.stringOff, 'BOTTOM', 0, 0)
			menu.strings.box2:SetPoint('RIGHT', menu.strings, 'RIGHT', -32, 0)

			menu.strings:SetScript('OnShow', function()
				menu.strings.elements.stringDead:SetText(PhantomMenaceOptions.strings.dead)
				menu.strings.elements.stringGhost:SetText(PhantomMenaceOptions.strings.ghost)
				menu.strings.elements.stringOff:SetText(PhantomMenaceOptions.strings.offline)
				needReload = false
			end)

			menu.strings.okay = function()
				PhantomMenaceOptions.strings.dead = menu.strings.elements.stringDead:GetText()
				PhantomMenaceOptions.strings.ghost = menu.strings.elements.stringGhost:GetText()
				PhantomMenaceOptions.strings.offline = menu.strings.elements.stringOff:GetText()
				if ( needReload ) then
					StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_RELOAD')
				end
			end

		end
	end


	--[[

	]]
	do
		menu.main = CreatePanel(nil, 'oUF_PhantomMenace_Menu', 'oUF_PhantomMenace', 'oUF_PhantomMenace - Options', 'You can adjust oUF_PhantomMenace here.')

		menu.main:SetScript('OnShow', function()
			-- lib.debugging('menu.main:OnShow()')
			if ( not menu.settings ) then
				CreateConfiguration()
			end
			needReload = false
		end)

		menu.main.default = function()
			StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_MENUMAIN_DEFAULTS')
		end
	end