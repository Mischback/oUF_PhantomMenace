--[[ LIBRARY
	@file:			lib.lua
	@file-version:	1.0
	@project:		oUF_PhantomMenace
	@project-url:	https://github.com/Mischback/oUF_PhantomMenace
	@author:		Mischback

	@project-description:
		This is a layout for the incredible awesome oUF by haste. You can find this addon 
			@wowinterface:	http://www.wowinterface.com/downloads/info9994-oUF.html
			@github:		https://github.com/haste/oUF
		PLEASE NOTE: This layout comes with absolute no warranty and "as it is". It was created to 
		fit my very own needs. Please understand, that I will not put any effort in "adding" 
		anything for you, "fix" things for you or make any changes to this.
		However, please feel free to send me feature requests, I will consider them and _possibly_
		will add what you requested.
		Anyway: When you read this, you have already downloaded the layout and view the code. Feel 
		free to modify it to your own needs.

	@file-description:
		This file (lib.lua) contains 
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings

-- Let's get it on!
local lib = {}
-- ************************************************************************************************

--[[ Debugging to ChatFrame
	VOID debugging(STRING text)
]]
lib.debugging = function(text)
	DEFAULT_CHAT_FRAME:AddMessage('|cffffd700oUF_PhantomMenace:|r |cffeeeeee'..text..'|r')
end

--[[ Is a value in a table?
	BOOL in_array(MIXED e, TABLE t)
]]
lib.in_array = function(e, t)
	-- lib.debugging('entering in_array() with spellID='..e)
	-- for _,v in pairs(t) do
		-- if ( v == e ) then
			-- -- lib.debugging('in_array(): v == e: '..v..'/'..e)
			-- return true
		-- end
	-- end
	return t[e]
	-- return false
end

--[[ Creates a font-object
	FONT OBJECT CreateFontObject(FRAME parent, INT size, STRING font)
]]
lib.CreateFontObject = function(parent, size, font)
	local fo = parent:CreateFontString(nil, 'OVERLAY')
	fo:SetFont(font, size, 'OUTLINE')
	fo:SetJustifyH('CENTER')
	-- fo:SetShadowColor(0,0,0)
	-- fo:SetShadowOffset(1, 1)
	return fo
end

--[[ Shortening the values displayed on the Health- and Power-Bars
	STRING Shorten(INT value)
]]
lib.Shorten = function(value)
	if value >= 1e7 then
		return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e6 then
		return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e5 then
		return ('%.0fk'):format(value / 1e3)
	elseif value >= 1e3 then
		return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return value
	end
end

--[[ Applies a given color to an array of textures. Needed to color the border
	VOID ColorBorder(ARRAY tex, FLOAT r, FLOAT g, FLOAT b, FLOAT a)
]]
lib.ColorBorder = function(tex, r, g, b, a)

	if (#tex == 0) then 
		lib.debugging('no textures to color!')
		return
	end

	local _, v
	for _, v in pairs(tex) do
		v:SetVertexColor(r, g, b, a)
	end

end

--[[ Creates a background
	TEXTURE CreateBack(FRAME target)
]]
lib.CreateBack = function(target)

	local back = target:CreateTexture(nil, 'BACKGROUND')
	back:SetPoint('TOPLEFT', target, 'TOPLEFT', -3, 3)
	back:SetPoint('BOTTOMRIGHT', target, 'BOTTOMRIGHT', 3, -3)
	back:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

	return back
end

--[[ Creates the gloss-effect
	FRAME CreateGloss(FRAME self, FRAME target)
]]
lib.CreateGloss = function(self, target)
	local gloss = CreateFrame('Frame', nil, self)
	gloss:SetFrameLevel(target:GetFrameLevel()+5)
	gloss:SetAllPoints(target)
	gloss.left = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.left:SetSize(13, target:GetHeight())
	gloss.left:SetTexture(settings.tex.gloss)
	gloss.left:SetTexCoord(0, 0.25, 0, 1)
	gloss.left:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.left:SetPoint('TOPLEFT')
	gloss.right = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.right:SetSize(13, target:GetHeight())
	gloss.right:SetTexture(settings.tex.gloss)
	gloss.right:SetTexCoord(0.75, 1, 0, 1)
	gloss.right:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.right:SetPoint('TOPRIGHT')
	gloss.mid = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.mid:SetHeight(target:GetHeight())
	gloss.mid:SetTexture(settings.tex.gloss)
	gloss.mid:SetTexCoord(0.25, 0.75, 0, 1)
	gloss.mid:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.mid:SetPoint('TOPLEFT', gloss.left, 'TOPRIGHT')
	gloss.mid:SetPoint('TOPRIGHT', gloss.right, 'TOPLEFT')

	return gloss
end

--[[

]]
lib.DropDownMenu = CreateFrame('Frame', 'oUF_PhantomMenace_UnitDropDownMenu', UIParent, 'UIDropDownMenuTemplate')

UIDropDownMenu_Initialize(lib.DropDownMenu, function(self)
	local unit = self:GetParent().unit
	if not unit then return end

	local menu, name, id
	if UnitIsUnit(unit, 'player') then
		menu = 'SELF'
	elseif UnitIsUnit(unit, 'vehicle') then
		menu = 'VEHICLE'
	elseif UnitIsUnit(unit, 'pet') then
		menu = 'PET'
	elseif UnitIsPlayer(unit) then
		id = UnitInRaid(unit)
		if id then
			menu = 'RAID_PLAYER'
			name = GetRaidRosterInfo(id)
		elseif UnitInParty(unit) then
			menu = 'PARTY'
		else
			menu = 'PLAYER'
		end
	else
		menu = 'TARGET'
		name = RAID_TARGET_ICON
	end
	if menu then
		UnitPopup_ShowMenu(self, menu, unit, name, id)
	end
end, 'MENU')

lib.menu = function(self)
	lib.DropDownMenu:SetParent(self)
	ToggleDropDownMenu(1, nil, lib.DropDownMenu, 'cursor', 0, 0)
end


-- ************************************************************************************************
-- ***** VENGEANCE ********************************************************************************
-- ************************************************************************************************

--[[ We are creating the scannable tooltip

]]
lib.Vengeance = {
	['venAura'] = GetSpellInfo(93098),
	['venTT'] = CreateFrame('GameTooltip', 'VengeanceTooltip', UIParent, 'GameTooltipTemplate')
}
lib.Vengeance.venTT:SetOwner(UIParent, 'ANCHOR_NONE')


--[[ Scans the tooltip for the vengeance-amount and updates the vengeance-bar
	VOID updateVengeance(FRAME self, STRING event, STRING unit)
]]
lib.Vengeance.updateVengeance = function(self, event, unit)
	if not unit or (unit and unit ~= 'player') then return end

	local name = UnitBuff('player', lib.Vengeance.venAura)
	if ( not name ) then 
		self:SetValue(0)
		return 
	end

	lib.Vengeance.venTT:ClearLines()
	lib.Vengeance.venTT:SetUnitBuff('player', lib.Vengeance.venAura)

	local tooltiptext = _G[lib.Vengeance.venTT:GetName()..'TextLeft2']
	local value = (tooltiptext:GetText() and tonumber(string.match(tostring(tooltiptext:GetText()), '%d+'))) or -1

	self:SetValue(value or 0)
end

--[[ Checks, if the unit is a tank
	BOOL checkSpec()
]]
lib.Vengeance.checkSpec = function()
	local isTank
	local class = settings.playerClass
	local talentTree = GetPrimaryTalentTree()

	if ( class == 'WARRIOR' and talentTree == 3 ) then
		isTank = true
	elseif ( class == 'PALADIN' and talentTree == 2 ) then
		isTank = true
	elseif ( class == 'DEATHKNIGHT' and talenTree == 1 ) then
		isTank = true
	elseif ( class == 'DRUID' and talentTree == 2 ) then
		isTank = true
	end
	return isTank
end

--[[ Sets up the bar, settings min/max values
	VOID setUpBar(FRAME self)
]]
lib.Vengeance.setUpBar = function(self)
	if ( not lib.Vengeance.checkSpec ) then return end
	local maxHealth = UnitHealthMax('player')
	local _, stamina = UnitStat('player', 3)
	self:SetMinMaxValues(0, (0.1 * (maxHealth - 15*stamina) + stamina))
	self:SetValue(0)
	-- lib.debugging('max='..(0.1 * (maxHealth - 15*stamina) + stamina))
	lib.Vengeance.updateVengeance(self, 'UNIT_AURA', 'player')
end

--[[ Handles all events of the vengeance-bar
	VOID eventHandler(FRAME self, STRING event, STRING unit)
]]
lib.Vengeance.eventHandler = function(self, event, unit)
	if ( event == 'UNIT_AURA' ) then
		lib.Vengeance.updateVengeance(self, event, unit)
	elseif ( (event == 'UNIT_MAXHEALTH') or (event == 'PLAYER_ENTERING_WORLD') or (event == 'UNIT_LEVEL') ) then
		lib.Vengeance.setUpBar(self)
	else
		if ( lib.Vengeance.checkSpec() ) then
			lib.Vengeance.setUpBar(self)
		end
	end
end


-- ************************************************************************************************
-- ***** DEBUFF HIGHLIGHT *************************************************************************
-- ************************************************************************************************
lib.DBH = {
	['abilities'] = {
		['PRIEST'] = { ['Magic'] = true, ['Disease'] = true },
		['SHAMAN'] = { ['Magic'] = true, ['Curse'] = true },
		['PALADIN'] = { ['Magic'] = true, ['Poison'] = true, ['Disease'] = true },
		['MAGE'] = { ['Curse'] = true },
		['DRUID'] = { ['Magic'] = true, ['Curse'] = true, ['Poison'] = true }
	}
}
lib.DBH.canDispel = lib.DBH.abilities[settings.playerClass]

--[[ Iterates over all unit's debuffs and returns the first one with a given type
	STRING getDebuffType(STRING unit)
]]
lib.DBH.getDebuffType = function(unit)
	if ( not UnitCanAssist('player', unit) ) then return nil end
	local i = 1
	while true do
		local name, _, _, _, debuffType = UnitAura(unit, i, 'HARMFUL')
		if ( not name ) then break end
		if ( debuffType ) then
			return debuffType
		end
		i = i + 1
	end
end

--[[ Sets the color of the Overlay-element to highlight a debuff
	VOID highlightDebuffs(FRAME self, STRING event, STRING unit)
]]
lib.DBH.highlightDebuffs = function(self, event, unit)
	if self:GetParent().unit ~= unit then return end

	local debuffType = lib.DBH.getDebuffType(unit)
	if ( debuffType and (oUF_PhantomMenaceSettings.configuration.showAllDebuffs or lib.DBH.canDispel[debuffType]) ) then
		local color = DebuffTypeColor[debuffType]
		local a = oUF_PhantomMenaceSettings.general.debuffHighlightIntensity
		self.tex:SetVertexColor(color.r, color.g, color.b, a)
	else
		self.tex:SetVertexColor(1, 1, 1, 0)
	end
end

-- ************************************************************************************************
ns.lib = lib