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


-- ***** POPUPS ****************************************************************************************

	--[[
	
	]]
	StaticPopupDialogs['OUF_PHANTOMMENACE_POPUP_MENUMAIN_DEFAULTS'] = {
		text = 'Would you like to set these settings to default?',
		button1 = 'Ok',
		OnAccept = function()
			PhantomMenaceOptions.healerMode = settings.options.healerMode
			PhantomMenaceOptions.debuffHighlight = settings.options.debuffHighlight
			PhantomMenaceOptions.aggroHighlight = settings.options.aggroHighlight
			PhantomMenaceOptions.strings.dead = settings.options.strings.dead
			PhantomMenaceOptions.strings.ghost = settings.options.strings.ghost
			PhantomMenaceOptions.strings.offline = settings.options.strings.offline
			menu.main.elements.healerMode:SetChecked(PhantomMenaceOptions.healerMode and true or false)
			menu.main.elements.debuffHighlight:SetChecked(PhantomMenaceOptions.debuffHighlight and true or false)
			menu.main.elements.aggroHighlight:SetChecked(PhantomMenaceOptions.aggroHighlight and true or false)
			menu.main.elements.stringDead:SetText(PhantomMenaceOptions.strings.dead)
			menu.main.elements.stringGhost:SetText(PhantomMenaceOptions.strings.ghost)
			menu.main.elements.stringOff:SetText(PhantomMenaceOptions.strings.offline)
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

-- ***** PANELS ****************************************************************************************

	--[[

	]]
	do
		menu.main = CreatePanel(nil, 'oUF_PhantomMenace_Menu', 'oUF_PhantomMenace', 'oUF_PhantomMenace - General Options', 'These are the options, that take effect on the general behaviour of oUF_PhantomMenace.')

		menu.main.elements.healerMode = CreateFrame('CheckButton', 'oUF_PhantomMenace_Menu_healerMode', menu.main, 'InterfaceOptionsCheckButtonTemplate')
		_G['oUF_PhantomMenace_Menu_healerModeText']:SetText('HealerMode')
		menu.main.elements.healerMode:SetPoint('TOPLEFT', menu.main.subtext, 'BOTTOMLEFT', 0, -20)
		menu.main.elements.healerMode:SetScript('OnClick', function()
			menu.main.elements.healerMode:SetChecked((menu.main.elements.healerMode:GetChecked() and true) or false)
			needReload = true
		end)

		menu.main.elements.debuffHighlight = CreateFrame('CheckButton', 'oUF_PhantomMenace_Menu_debuffHighlight', menu.main, 'InterfaceOptionsCheckButtonTemplate')
		_G['oUF_PhantomMenace_Menu_debuffHighlightText']:SetText('DebuffHighlight')
		menu.main.elements.debuffHighlight:SetPoint('TOPLEFT', menu.main.elements.healerMode, 'BOTTOMLEFT', 0, -elementPadding)
		menu.main.elements.debuffHighlight:SetScript('OnClick', function()
			menu.main.elements.debuffHighlight:SetChecked((menu.main.elements.debuffHighlight:GetChecked() and true) or false)
			needReload = true
		end)

		menu.main.elements.aggroHighlight = CreateFrame('CheckButton', 'oUF_PhantomMenace_Menu_aggroHighlight', menu.main, 'InterfaceOptionsCheckButtonTemplate')
		_G['oUF_PhantomMenace_Menu_aggroHighlightText']:SetText('AggroHighlight')
		menu.main.elements.aggroHighlight:SetPoint('TOPLEFT', menu.main.elements.debuffHighlight, 'BOTTOMLEFT', 0, -elementPadding)
		menu.main.elements.aggroHighlight:SetScript('OnClick', function()
			menu.main.elements.aggroHighlight:SetChecked((menu.main.elements.aggroHighlight:GetChecked() and true) or false)
			needReload = true
		end)

		menu.main.elements.stringDead = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringDead', menu.main, 'InputBoxTemplate')
		menu.main.elements.stringDead:SetAutoFocus(false)
		menu.main.elements.stringDead:SetHeight(50)
		menu.main.elements.stringDead:SetPoint('TOPLEFT', menu.main.elements.aggroHighlight, 'BOTTOMLEFT', 10, -40)
		menu.main.elements.stringDead:SetPoint('RIGHT', menu.main, 'RIGHT', -100, 0)
		menu.main.stringDeadCaption = menu.main:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		menu.main.stringDeadCaption:SetPoint('BOTTOMLEFT', menu.main.elements.stringDead, 'TOPLEFT', 0, -15)
		menu.main.stringDeadCaption:SetText('dead')

		menu.main.elements.stringGhost = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringGhost', menu.main, 'InputBoxTemplate')
		menu.main.elements.stringGhost:SetAutoFocus(false)
		menu.main.elements.stringGhost:SetHeight(50)
		menu.main.elements.stringGhost:SetPoint('TOPLEFT', menu.main.elements.stringDead, 'BOTTOMLEFT', 0, 0)
		menu.main.elements.stringGhost:SetPoint('RIGHT', menu.main, 'RIGHT', -100, 0)
		menu.main.stringGhostCaption = menu.main:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		menu.main.stringGhostCaption:SetPoint('BOTTOMLEFT', menu.main.elements.stringGhost, 'TOPLEFT', 0, -15)
		menu.main.stringGhostCaption:SetText('ghost')

		menu.main.elements.stringOff = CreateFrame('EditBox', 'oUF_PhantomMenace_Menu_stringOff', menu.main, 'InputBoxTemplate')
		menu.main.elements.stringOff:SetAutoFocus(false)
		menu.main.elements.stringOff:SetHeight(50)
		menu.main.elements.stringOff:SetPoint('TOPLEFT', menu.main.elements.stringGhost, 'BOTTOMLEFT', 0, 0)
		menu.main.elements.stringOff:SetPoint('RIGHT', menu.main, 'RIGHT', -100, 0)
		menu.main.stringOffCaption = menu.main:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		menu.main.stringOffCaption:SetPoint('BOTTOMLEFT', menu.main.elements.stringOff, 'TOPLEFT', 0, -15)
		menu.main.stringOffCaption:SetText('offline')

		menu.main.box1 = CreateBox(menu.main, 'oUF_PhantomMenace_Menu_Box1', 'Features')
		menu.main.box1:SetPoint('TOPLEFT', menu.main.elements.healerMode, 'TOPLEFT', -5, 5)
		menu.main.box1:SetPoint('BOTTOM', menu.main.elements.aggroHighlight, 'BOTTOM', 0, -5)
		menu.main.box1:SetPoint('RIGHT', menu.main, 'RIGHT', -32, 0)

		menu.main.box2 = CreateBox(menu.main, 'oUF_PhantomMenace_Menu_Box2', 'Strings')
		menu.main.box2:SetPoint('TOPLEFT', menu.main.elements.stringDead, 'TOPLEFT', -15, 7)
		menu.main.box2:SetPoint('BOTTOM', menu.main.elements.stringOff, 'BOTTOM', 0, 0)
		menu.main.box2:SetPoint('RIGHT', menu.main, 'RIGHT', -32, 0)

		menu.main.okay = function()
			PhantomMenaceOptions.healerMode = ((menu.main.elements.healerMode:GetChecked() and true) or false)
			PhantomMenaceOptions.debuffHighlight = ((menu.main.elements.debuffHighlight:GetChecked() and true) or false)
			PhantomMenaceOptions.aggroHighlight = ((menu.main.elements.aggroHighlight:GetChecked() and true) or false)
			PhantomMenaceOptions.strings.dead = menu.main.elements.stringDead:GetText()
			PhantomMenaceOptions.strings.ghost = menu.main.elements.stringGhost:GetText()
			PhantomMenaceOptions.strings.offline = menu.main.elements.stringOff:GetText()
			if ( needReload ) then
				StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_RELOAD')
			end
		end

		menu.main.default = function()
			StaticPopup_Show('OUF_PHANTOMMENACE_POPUP_MENUMAIN_DEFAULTS')
		end

		menu.main:SetScript('OnShow', function()
			-- lib.debugging('menu.main:OnShow()')
			menu.main.elements.healerMode:SetChecked(PhantomMenaceOptions.healerMode and true or false)
			menu.main.elements.debuffHighlight:SetChecked(PhantomMenaceOptions.debuffHighlight and true or false)
			menu.main.elements.aggroHighlight:SetChecked(PhantomMenaceOptions.aggroHighlight and true or false)
			menu.main.elements.stringDead:SetText(PhantomMenaceOptions.strings.dead)
			menu.main.elements.stringGhost:SetText(PhantomMenaceOptions.strings.ghost)
			menu.main.elements.stringOff:SetText(PhantomMenaceOptions.strings.offline)
			needReload = false
		end)
	end


	--[[

	]]
	do
		menu.positions = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuPositions', 'Positions', 'oUF_PhantomMenace - Positions', 'The positions of the various unitframes can be adjusted here.')

		menu.positions.elements.buttonPlayer = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonPlayer', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonPlayer:SetText('Player')
		menu.positions.elements.buttonPlayer:SetPoint('TOPLEFT', menu.positions.subtext, 'BOTTOMLEFT', 2, -elementPadding)

		menu.positions.elements.buttonPet = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonPet', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonPet:SetText('Pet')
		menu.positions.elements.buttonPet:SetPoint('TOPLEFT', menu.positions.elements.buttonPlayer, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonTarget = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonTarget', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonTarget:SetText('Target')
		menu.positions.elements.buttonTarget:SetPoint('TOPLEFT', menu.positions.elements.buttonPet, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonTargettarget = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonTargettarget', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonTargettarget:SetText('Targettarget')
		menu.positions.elements.buttonTargettarget:SetPoint('TOPLEFT', menu.positions.elements.buttonTarget, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonFocus = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonFocus', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonFocus:SetText('Focus')
		menu.positions.elements.buttonFocus:SetPoint('TOPLEFT', menu.positions.elements.buttonTargettarget, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonFocustarget = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonFocustarget', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonFocustarget:SetText('Focustarget')
		menu.positions.elements.buttonFocustarget:SetPoint('TOPLEFT', menu.positions.elements.buttonFocus, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonParty = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonParty', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonParty:SetText('Party')
		menu.positions.elements.buttonParty:SetPoint('TOPLEFT', menu.positions.elements.buttonFocustarget, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonPartyH = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonPartyH', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonPartyH:SetText('Party (Heal)')
		menu.positions.elements.buttonPartyH:SetPoint('TOPLEFT', menu.positions.elements.buttonParty, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonRaid = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonRaid', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonRaid:SetText('Raid')
		menu.positions.elements.buttonRaid:SetPoint('TOPLEFT', menu.positions.elements.buttonPartyH, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonRaidH = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonRaidH', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonRaidH:SetText('Raid (Heal)')
		menu.positions.elements.buttonRaidH:SetPoint('TOPLEFT', menu.positions.elements.buttonRaid, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonMT = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonMT', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonMT:SetText('Maintanks')
		menu.positions.elements.buttonMT:SetPoint('TOPLEFT', menu.positions.elements.buttonRaidH, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonMTH = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonMTH', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonMTH:SetText('MTs (Heal)')
		menu.positions.elements.buttonMTH:SetPoint('TOPLEFT', menu.positions.elements.buttonMT, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.elements.buttonBoss = CreateFrame('Button', 'oUF_PhantomMenace_MenuPositionsButtonBoss', menu.positions, 'OptionsButtonTemplate')
		menu.positions.elements.buttonBoss:SetText('Boss')
		menu.positions.elements.buttonBoss:SetPoint('TOPLEFT', menu.positions.elements.buttonMTH, 'BOTTOMLEFT', 0, -elementPadding)

		menu.positions.box1 = CreateBox(menu.positions, 'oUF_PhantomMenace_MenuPositions_Box1', 'Frames')
		menu.positions.box1:SetPoint('TOPLEFT', menu.positions.elements.buttonPlayer, 'TOPLEFT', -7, 7)
		menu.positions.box1:SetPoint('BOTTOMRIGHT', menu.positions.elements.buttonBoss, 'BOTTOMRIGHT', 7, -7)

		menu.positions.box2 = CreateBox(menu.positions, 'oUF_PhantomMenace_MenuPositions_Box2', 'Settings')
		menu.positions.box2:SetPoint('TOPLEFT', menu.positions.box1, 'TOPRIGHT', 10, 0)
		menu.positions.box2:SetPoint('BOTTOM', menu.positions.box1, 'BOTTOM', 0, 0)
		menu.positions.box2:SetPoint('RIGHT', menu.positions, 'RIGHT', -15, 0)

		menu.positions.elements.xCoord = CreateFrame('EditBox', 'oUF_PhantomMenace_MenuPositions_xCoord', menu.positions, 'InputBoxTemplate')
		menu.positions.elements.xCoord:SetAutoFocus(false)
		menu.positions.elements.xCoord:SetHeight(50)
		menu.positions.elements.xCoord:SetWidth(100)
		menu.positions.elements.xCoord:SetPoint('TOPLEFT', menu.positions.box2, 'TOPLEFT', 20, -7)
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
		menu.positions.elements.anchorPoint:SetPoint('CENTER')
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

	end


	--[[

	]]
	menu.buffs = CreatePanel('oUF_PhantomMenace', 'oUF_PhantomMenace_MenuBuffsDebuffs', 'Buffs/Debuffs', 'oUF_PhantomMenace - Buffs/Debuffs', 'Apply buff-/debuff-filter here.')