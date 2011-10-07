--[[ CORE
	@file:			core.lua
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
		This file (core.lua) contains necessary functions to build the PhantomMenace-look'n'feel
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib

-- Let's get it on!
local core = {}
-- ************************************************************************************************

--[[ Creates a BASIC unitframe, meaning all unitframes will rely on this function!
	VOID CreateUnitFrame(FRAME self, INT width, INT height)

	Features:
		* Health-bar with heal-prediction (using oUF's internal element) and a health-value
		* Threat-highlighting (overriding oUF's internal function, we color the border's textures)
		* provides the Overlay-element (which is currently unused)
		* Unit-menu
]]
core.CreateUnitFrame = function(self, width, height)

	self:SetSize(width, height)

	-- ***** HEALTH BAR ***************************************************************************
	local hp = CreateFrame('StatusBar', nil, self)
	hp:SetFrameLevel(20)
	hp:SetAllPoints(self)
	hp:SetStatusBarTexture(settings.tex.solid, 'ARTWORK')
	hp:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.healthBarFG))

	hp.bg = hp:CreateTexture(nil, 'BORDER')
	hp.bg:SetAllPoints(hp)
	hp.bg:SetTexture(settings.tex.solid)
	hp.bg:SetVertexColor(unpack(oUF_PhantomMenaceSettings.general.color.healthBarBG))

	hp.back = lib.CreateBack(hp)

	self.Health = hp

	-- ***** HEAL PREDICTION **********************************************************************
	local mhpb = CreateFrame('StatusBar', nil, self)
	mhpb:SetFrameLevel(21)
	mhpb:SetPoint('TOPLEFT', hp:GetStatusBarTexture(), 'TOPRIGHT')
	mhpb:SetPoint('BOTTOMLEFT', hp:GetStatusBarTexture(), 'BOTTOMRIGHT')
	mhpb:SetWidth(width)
	mhpb:SetStatusBarTexture(settings.tex.solid, 'ARTWORK')
	mhpb:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.healthBarMyHeal))
	mhpb:Hide()

	local ohpb = CreateFrame('StatusBar', nil, self)
	ohpb:SetFrameLevel(21)
	ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT')
	ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT')
	ohpb:SetWidth(width)
	ohpb:SetStatusBarTexture(settings.tex.solid, 'ARTWORK')
	ohpb:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.healthBarHeal))
	ohpb:Hide()

	self.HealPrediction = {
		['myBar'] = mhpb,
		['otherBar'] = ohpb, 
		['maxOverflow'] = 1.0,
	}

	-- ***** THREAT *******************************************************************************
	self.Threat = CreateFrame('Frame', nil, self)
	self.Threat.Override = core.ThreatUpdate

	-- ***** OVERLAY ******************************************************************************
	self.Overlay = CreateFrame('Frame', nil, self)
	self.Overlay:SetFrameLevel(23)
	self.Overlay.tex = self.Overlay:CreateTexture(nil, 'OVERLAY')
	self.Overlay.tex:SetPoint('TOPLEFT', self)
	self.Overlay.tex:SetPoint('BOTTOM', self)
	self.Overlay.tex:SetTexture(settings.tex.overlay)
	self.Overlay.tex:SetTexCoord(0, (width/256), 0, 1)
	self.Overlay.tex:SetWidth(width)
	self.Overlay.tex:SetVertexColor(1, 1, 1, 0)

	-- ***** TEXT *********************************************************************************
	self.Text = CreateFrame('Frame', nil, self)
	self.Text:SetFrameLevel(self.Health:GetFrameLevel()+20)

	self.Health.value = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Health.value:SetJustifyH('RIGHT')
	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -1, 1)

	-- ***** GLOSS ********************************************************************************
	self.Gloss = lib.CreateGloss(self, self.Health)

	-- ***** BORDER *******************************************************************************
	self.Border = CreateFrame('Frame', nil, self)
	self.Border:SetFrameLevel(50)
	self.Border.tex = {}

	-- ***** ENGINES ******************************************************************************
	self.menu = lib.menu
	self:RegisterForClicks('anyup')
	self:SetAttribute('*type2', 'menu')
end

--[[ Creates a unitframe with NAMEPLATE on it!
	VOID CreateUnitFrameName(FRAME self, INT width, INT height, INT nameOff)

	This is merely our 'default' frame-appearance.

	Features:
		* ALL features from CreateUnitFrame()
		* Nameplate including name-string
		* RaidIcon
		* builds the borders for this type of frame
]]
core.CreateUnitFrameName = function(self, width, height, nameOff)

	self.colors = oUF_PhantomMenaceSettings.colors

	core.CreateUnitFrame(self, width, height)

	-- ***** NAME *********************************************************************************
	self.NameBG = CreateFrame('Frame', nil, self)
	self.NameBG:SetFrameLevel(35)
	self.NameBG:SetHeight(16)
	self.NameBG:SetPoint('LEFT', self, 'TOPLEFT', nameOff, 2)
	self.NameBG:SetPoint('RIGHT', self, 'TOPRIGHT', -nameOff, 2)
	self.NameBG.bg = self.NameBG:CreateTexture(nil, 'BORDER')
	self.NameBG.bg:SetAllPoints(self.NameBG)
	self.NameBG.bg:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.nameBG))
	self.NameBG.back = lib.CreateBack(self.NameBG)
	self.NameBG.Gloss = lib.CreateGloss(self, self.NameBG)

	self.Name = lib.CreateFontObject(self.NameBG, 12, settings.fonts['default'])
	self.Name:SetTextColor(1, 1, 1)
	self.Name:SetPoint('BOTTOMLEFT', self.NameBG, 'BOTTOMLEFT', 1, 1)
	self.Name:SetPoint('BOTTOMRIGHT', self.NameBG, 'BOTTOMRIGHT', 1, 1)

	-- ***** BORDER *******************************************************************************
	do
		-- Health Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
		tex:SetPoint('RIGHT', self.NameBG, 'LEFT', -2, 0)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('LEFT', self.NameBG, 'RIGHT', 2, 0)
		tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		-- NameBG Border
		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.NameBG, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.NameBG, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.NameBG, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', self.NameBG, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.NameBG, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.NameBG, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.NameBG, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.NameBG, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** ENGINES ******************************************************************************
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	if ( oUF_PhantomMenaceSettings.configuration.healerMode ) then
		self.Health.PostUpdate = core.UpdateHealth_deficit
	else
		self.Health.PostUpdate = core.UpdateHealth_percent
	end
	self.UNIT_NAME_UPDATE = core.UpdateName

end

--[[ Creates a unitframe with build-in CASTBAR!
	VOID CreateUnitFrameCastbar(FRAME self, INT width, INT height, INT nameOff)

	Features:
		* ALL features from CreateUnitFrameName()
		* Build-in castbar (overlaps the nameplate)
]]
core.CreateUnitFrameCastbar = function(self, width, height, nameOff)
	core.CreateUnitFrameName(self, width, height, nameOff)

	-- ***** CASTBAR ******************************************************************************
	local cb = CreateFrame('StatusBar', nil, self)
	cb:SetFrameLevel(self.NameBG:GetFrameLevel()+1)
	cb:SetStatusBarTexture(settings.tex.solid, 'ARTWORK')
	cb:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbar))
	cb:SetAllPoints(self.NameBG)

	cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
	cb.bg:SetAllPoints(cb)
	cb.bg:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.nameBG))

	cb.Text = lib.CreateFontObject(cb, 12, settings.fonts['default'])
	cb.Text:SetPoint('BOTTOMLEFT', cb, 'BOTTOMLEFT', 1, 1)
	cb.Text:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 1, 1)
	cb.Text:SetTextColor(1, 1, 1)

	self.Castbar = cb
	self.Castbar.PostCastStart = core.CheckForInterrupt
	self.Castbar.PostChannelStart = core.CheckForInterrupt
end


-- ************************************************************************************************
-- ***** POWER ************************************************************************************
-- ************************************************************************************************

--[[ Generic function to create the offsetted Powerbar-look. SHOULD NOT BE CALLED DIRECTLY!
	STATUSBAR CreatePowerBarOffsetted(FRAME self, INT leftX, INT leftY, INT rightX, INT rightY)

	Yeah, leftX and leftY are not actually used! I'll keep them...
]]
core.CreatePowerbarOffsetted = function(self, leftX, leftY, rightX, rightY)

	-- ***** POWER BAR ****************************************************************************
	local pb = CreateFrame('StatusBar', nil, self)
	pb:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', rightX, rightY)
	pb:SetStatusBarTexture(settings.tex.solid)

	pb.bg = pb:CreateTexture(nil, 'BORDER')
	pb.bg:SetAllPoints(pb)
	pb.bg:SetTexture(settings.tex.solid)
	pb.bg:SetAlpha(0.5)

	pb.back = lib.CreateBack(pb)

	pb.colorTapping = true
	pb.colorDisconnected = true
	pb.colorClass = true
	pb.colorClassPet = true
	pb.colorReaction = true

	return pb
end

--[[ Creates a power-bar BEHIND the health-bar
	STATUSBAR CreatePowerbarOffsettedBG(FRAME self, INT leftX, INT leftY, INT rightX, INT rightY)
]]
core.CreatePowerbarOffsettedBG = function(self, leftX, leftY, rightX, rightY)

	local pb = core.CreatePowerbarOffsetted(self, leftX, leftY, rightX, rightY)
	pb:SetPoint('TOPLEFT', self, 'LEFT', leftX, leftY)
	pb:SetFrameLevel(self.Health:GetFrameLevel()-5)

	return pb
end

--[[ Creates a power-bar IN FRONT OF the health-bar
	STATUSBAR CreatePowerbarOffsettedBG(FRAME self, INT leftX, INT leftY, INT rightX, INT rightY)
]]
core.CreatePowerbarOffsettedFG = function(self, leftX, leftY, rightX, rightY)

	-- ***** POWER BAR ****************************************************************************
	local pb = core.CreatePowerbarOffsetted(self, leftX, leftY, rightX, rightY)
	pb:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', leftX, leftY)
	pb:SetFrameLevel(self.Health:GetFrameLevel()+10)

	return pb
end


-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************

--[[ Updates the name of an unit and sets the given raid icon, if present
	VOID UpdateName(FRAME self, STRING event)
]]
core.UpdateName = function(self, event)
	local name = UnitName(self.unit)
	local raidIcon = GetRaidTargetIndex(self.unit)
	if ( raidIcon and name ) then
		self.Name:SetFormattedText('|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0:0:0:0.5|t |cff%s%s|r', raidIcon, oUF_PhantomMenaceSettings.general.color.name, name)
	elseif ( name ) then
		self.Name:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.name, name)
	end
end

--[[ This function is necessary, because we hide the health-value on party-targets (and MT-targets)
	VOID UpdateName_PartyTarget(STATUSBAR health, STRING unit, INT min, INT max)

	Follows the prototype of the PostUpdate-health-function, because this is when we call this!
]]
core.UpdateName_PartyTarget = function(health, unit, min, max)
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[ Updates the power-bar of pets, actually it changes its color!
	VOID PetPowerUpdate(FRAME self, STRING event, STRING unit)

	This is only applied to the player's pet as Power.Override!
]]
core.PetPowerUpdate = function(self, event, unit)

	if(self.unit ~= unit) then return end
	local power = self.Power

	local min, max = UnitPower(unit), UnitPowerMax(unit)
	power:SetMinMaxValues(0, max)

	local t = self.colors.class[settings.playerClass]
	local r, g, b = t[1], t[2], t[3]

	power:SetStatusBarColor(r, g, b)

	local bg = power.bg
	if(bg) then
		local mu = bg.multiplier or 1
		bg:SetVertexColor(r * mu, g * mu, b * mu)
	end

	power:SetValue(min)
end

--[[ Move player's debuffs if there is an EclipseBar and makes adjustments of border-textures
	VOID EclipseBarVisibility(FRAME self)
]]
core.EclipseBarVisibility = function(self)
	local cfg = oUF_PhantomMenaceSettings['player']
	if ( self:IsShown() ) then
		self:GetParent().Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)
		_G['TexPMPlayerTop']:Hide()
		_G['TexPMPlayerSpecial01']:Show()
		_G['TexPMPlayerSpecial02']:Show()
		_G['TexPMPlayerSpecial03']:Show()
		_G['TexPMPlayerSpecial04']:Show()
		_G['TexPMPlayerSpecial05']:Show()
		_G['TexPMPlayerSpecial06']:Show()
	else
		self:GetParent().Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
		_G['TexPMPlayerTop']:Show()
		_G['TexPMPlayerSpecial01']:Hide()
		_G['TexPMPlayerSpecial02']:Hide()
		_G['TexPMPlayerSpecial03']:Hide()
		_G['TexPMPlayerSpecial04']:Hide()
		_G['TexPMPlayerSpecial05']:Hide()
		_G['TexPMPlayerSpecial06']:Hide()
	end
end

--[[ Custom SoulShard-Update (SetAlpha instead of Show/Hide)
	VOID SoulShardOverride(FRAME self, STRING event, STRING unit, STRING powerType)
]]
core.SoulShardOverride = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end

	local ss = self.SoulShards

	local num = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
	for i = 1, SHARD_BAR_NUM_SHARDS do
		if(i <= num) then
			ss[i]:SetAlpha(1)
		else
			ss[i]:SetAlpha(0.35)
		end
	end
end

--[[ Custom HolyPower-Update (SetAlpha instead of Show/Hide)
	VOID HolyPowerOverride(FRAME self, STRING event, STRING unit, STRING powerType)
]]
core.HolyPowerOverride = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end

	local hp = self.HolyPower

	local num = UnitPower('player', SPELL_POWER_HOLY_POWER)
	for i = 1, MAX_HOLY_POWER do
		if(i <= num) then
			hp[i]:SetAlpha(1)
		else
			hp[i]:SetAlpha(0.35)
		end
	end
end

--[[ Custom Totem-Update (to update statusbars for totems)
	VOID TotemOverride(FRAME self, STRING event, INT slot)
]]
core.TotemOverride = function(self, event, slot)
	local totems = self.Totems

	local totem = totems[slot]
	local haveTotem, name, start, duration, icon = GetTotemInfo(slot)
	if(duration > 0) then
		totem:SetMinMaxValues(0, duration)
		totem.start = start
		totem.duration = duration
		totem.TimeSinceLastUpdate = 0
		totem:SetScript('OnUpdate', function(self, elapsed)
			self.TimeSinceLastUpdate = self.TimeSinceLastUpdate +  elapsed
			if ( self.TimeSinceLastUpdate > 0.5 ) then
				self.TimeSinceLastUpdate = 0
				self:SetValue(self.start+self.duration-GetTime())
			end
		end)
		totem:Show()
	else
		totem:Hide()
	end
end

--[[ Custom threat-function (highlights the frames border)
	VOID ThreatUpdate(FRAME self, STRING event, STRING unit)
]]
core.ThreatUpdate = function(self, event, unit)
	if(unit ~= self.unit) then return end

	local threat = self.Threat

	unit = unit or self.unit
	local status = UnitThreatSituation(unit)

	if ( status and (status ~= 0) ) then
		lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.threat[status]))
	else
		lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	end
end

--[[ Custom function to display (custom) LfD-icons
	VOID LFDOverride(FRAME self, STRING event)
]]
core.LFDOverride = function(self, event)
	local lfdrole = self.LFDRole

	local role = UnitGroupRolesAssigned(self.unit)

	if ( role == 'TANK' ) then
		lfdrole:SetTexture(settings.tex.role.tank)
		lfdrole:Show()
	elseif ( role == 'HEALER' ) then
		lfdrole:SetTexture(settings.tex.role.heal)
		lfdrole:Show()
	elseif ( role == 'DAMAGER' ) then
		lfdrole:SetTexture(settings.tex.role.damage)
		lfdrole:Show()
	else
		lfdrole:Hide()
	end
end

--[[ Highlights non-interruptable spells
	VOID CheckForInterrupt(STATUSBAR bar, STRING unit)

	I really can't remember, that I have seen this working...
]]
core.CheckForInterrupt = function(bar, unit)
	if ( bar.interrupt and UnitCanAttack('player', unit) ) then
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbarNoInterrupt))
	else
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbar))
	end
end

--[[ Filters special auras on focus-unitframe
	BOOL FilterSpecialsFocus(..., INT spellID)

	TODO: Hm, yeah, it is in this layout! But should it be here or in oUF_BuffFilter?
]]
core.FilterSpecialsFocus = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if ( caster ~= 'player' ) then return false end
	return lib.in_array(spellID, settings.SpecialAurasFocus)
end

--[[ Filters special auras on party-unitframe
	BOOL FilterSpecialsParty(..., INT spellID)

	TODO: Hm, yeah, it is in this layout! But should it be here or in oUF_BuffFilter?
]]
core.FilterSpecialsParty = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if ( caster ~= 'player' ) then return false end
	return lib.in_array(spellID, settings.SpecialAurasParty)
end

-- ************************************************************************************************
-- ***** HEALTH UPDATES ***************************************************************************
-- ************************************************************************************************

--[[ Shows the health-value as %-value
	VOID UpdateHealth_percent(STATUSBAR health, STRING unit, INT min, INT max)

	Shows the absolute value, when at max health (100%), percent-value otherwhise
]]
core.UpdateHealth_percent = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[ Shows the health-value as deficit from full health
	VOID UpdateHealth_deficit(STATUSBAR health, STRING unit, INT min, INT max)

	This is, what I call the healer-mode!
]]
core.UpdateHealth_deficit = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s-%s|r', oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min))
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[ Specific function for the player's health-value
	VOID UpdateHealth_player(STATUSBAR health, STRING unit, INT min, INT max)

	Shows deficit AND current value.
]]
core.UpdateHealth_player = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s-%s|r | |cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min), oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
end

--[[ Specific function for the target's health-value
	VOID UpdateHealth_target(STATUSBAR health, STRING unit, INT min, INT max)

	Shows current AND percent value.
]]
core.UpdateHealth_target = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%s | %d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min), (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[ Specific function for the player's pet's health-value
	VOID UpdateHealth_pet(STATUSBAR health, STRING unit, INT min, INT max)

	Basically works just as UpdateHealth_percent(), but don't triggers the update of 
	the unit's name, since our pet-frame doesn't display the pet's name
]]
core.UpdateHealth_pet = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
end

--[[ Switches display between health-value (in percent) and name
	VOID UpdateHealth_raid(STATUSBAR health, STRING unit, INT min, INT max)

	The function is specifically tailored for raid-frames, it also includes 'offline' and 'dead'
	strings.
]]
core.UpdateHealth_raid = function(health, unit, min, max)
	if ( not UnitIsConnected(unit) ) then
		health:GetParent().Name:Hide()
		health.value:SetText(oUF_PhantomMenaceSettings.configuration.strings.off)
		health.value:Show()
	elseif ( UnitIsDead(unit) ) then
		health:GetParent().Name:Hide()
		health.value:SetText(oUF_PhantomMenaceSettings.configuration.strings.dead)
		health.value:Show()
	elseif ( min ~= max ) then
		local raidIcon = GetRaidTargetIndex(health:GetParent().unit)
		if ( raidIcon ) then
			health.value:SetFormattedText('|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0:0:0:0.5|t |cff%s%d%%|r', raidIcon, oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
		else
			health.value:SetFormattedText('|cff%s%d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
		end
		health.value:Show()
		health:GetParent().Name:Hide()
	else
		health.value:Hide()
		health:GetParent().Name:Show()
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[ Switches display between health-value (as deficit) and name
	VOID UpdateHealth_raid(STATUSBAR health, STRING unit, INT min, INT max)

	The function is specifically tailored for raid-frames, it also includes 'offline' and 'dead'
	strings.
]]
core.UpdateHealth_raidHealer = function(health, unit, min, max)
	if ( not UnitIsConnected(unit) ) then
		health:GetParent().Name:Hide()
		health.value:SetText(oUF_PhantomMenaceSettings.configuration.strings.off)
		health.value:Show()
	elseif ( UnitIsDead(unit) ) then
		health:GetParent().Name:Hide()
		health.value:SetText(oUF_PhantomMenaceSettings.configuration.strings.dead)
		health.value:Show()
	elseif ( min ~= max ) then
		local raidIcon = GetRaidTargetIndex(health:GetParent().unit)
		if ( raidIcon ) then
			health.value:SetFormattedText('|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0:0:0:0.5|t |cff%s-%s|r', raidIcon, oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min))
		else
			health.value:SetFormattedText('|cff%s-%s|r', oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min))
		end
		health.value:Show()
		health:GetParent().Name:Hide()
	else
		health.value:Hide()
		health:GetParent().Name:Show()
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end


-- ************************************************************************************************
-- ***** POWER UPDATES ****************************************************************************
-- ************************************************************************************************

--[[ Updates the power-value on the player-frame
	VOID UpdatePower_player(STATUSBAR power, STRING unit, INT min, INT max)

	We want to handle the display of power slightly different, based on the class-mechanics in use.
	So, basically it works like this:
		Warrior, Deathknights and Druids (Bear) show nothing when there's no rage, show value when there is rage
		Hunter, Rogue, Druids (Cat) show nothing, when they are at full focus, show value when not
		The rest (mana-users): Show value and % when not at max
]]
core.UpdatePower_player = function(power, unit, min, max)

	power.value:SetTextColor(unpack(power:GetParent().colors.class[settings.playerClass]))

	--[[ DAMN Druid stances:
		0 - Humanoid
		1 - Bear
		2 - Swimming
		3 - Cat
		4 - Travel
		5 - Moonkin
		Handle Bear like Warrior, Cat like Rogue
	]]
	local shapeshiftform = GetShapeshiftForm()

	if ( (settings.playerClass == 'WARRIOR') or
		 (settings.playerClass == 'DEATHKNIGHT') or
		 ((settings.playerClass == 'DRUID') and (shapeshiftform == 1)) ) then
		if ( min == 0 ) then
			power.value:SetText('')
		else
			power.value:SetText(min)
		end
	elseif ( (settings.playerClass == 'HUNTER') or
		 (settings.playerClass == 'ROGUE') or
		 ((settings.playerClass == 'DRUID') and (shapeshiftform == 3)) ) then
		if ( min == max ) then
			power.value:SetText('')
		else
			power.value:SetText(min)
		end
	else
		if ( min == max ) then
			power.value:SetText(min)
		else
			power.value:SetFormattedText('%s | %d%%', lib.Shorten(min), (min/max)*100)
		end
	end

end


--[[ Updates the power-value on the target-frame
	VOID UpdatePower_target(STATUSBAR power, STRING unit, INT min, INT max)
]]
core.UpdatePower_target = function(power, unit, min, max)
	if ( min > 0 ) then
		power.value:SetText(lib.Shorten(min))
	else
		power.value:SetText('')
	end
end


-- ************************************************************************************************
-- ***** AURA STUFF *******************************************************************************
-- ************************************************************************************************

--[[ Styles the Aura-/Buff-/Debuff-icons
	VOID PostCreateIcon(FRAME self, BUTTON b)

	Modifies the tex-coords of the icon to get rid of the ugly Blizzard-borders and creates 
	the PhantomMenace-style borders.
]]
core.PostCreateIcon = function(self, b)

	b.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	b.cd:SetAllPoints(b)
	b.cd:SetFrameLevel(b:GetFrameLevel()-1)

	b.back = lib.CreateBack(b)

	b.border = {}
	local tex = b:CreateTexture(nil, 'BORDER')
	tex:SetPoint('TOPLEFT', b, 'TOPLEFT', -2, 2)
	tex:SetPoint('BOTTOMRIGHT', b, 'TOPRIGHT', 2, 1)
	tex:SetTexture(settings.tex.solid)
	table.insert(b.border, tex)

	tex = b:CreateTexture(nil, 'BORDER')
	tex:SetPoint('TOPLEFT', b, 'TOPRIGHT', 1, 1)
	tex:SetPoint('BOTTOMRIGHT', b, 'BOTTOMRIGHT', 2, -2)
	tex:SetTexture(settings.tex.solid)
	table.insert(b.border, tex)

	tex = b:CreateTexture(nil, 'BORDER')
	tex:SetPoint('TOPLEFT', b, 'BOTTOMLEFT', -2, -1)
	tex:SetPoint('BOTTOMRIGHT', b, 'BOTTOMRIGHT', 1, -2)
	tex:SetTexture(settings.tex.solid)
	table.insert(b.border, tex)

	tex = b:CreateTexture(nil, 'BORDER')
	tex:SetPoint('TOPLEFT', b, 'TOPLEFT', -2, 1)
	tex:SetPoint('BOTTOMRIGHT', b, 'BOTTOMLEFT', -1, -1)
	tex:SetTexture(settings.tex.solid)
	table.insert(b.border, tex)

	lib.ColorBorder(b.border, unpack(oUF_PhantomMenaceSettings.general.color.border))
end


-- ************************************************************************************************
ns.core = core