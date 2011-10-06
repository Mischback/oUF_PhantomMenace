<<<<<<< HEAD
--[[ CORE
	Contains the core-functions
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib

-- Let's get it on!
local core = {}
-- ************************************************************************************************

--[[

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

--[[

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

--[[

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

--[[

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

--[[

]]
core.CreatePowerbarOffsettedBG = function(self, leftX, leftY, rightX, rightY)

	local pb = core.CreatePowerbarOffsetted(self, leftX, leftY, rightX, rightY)
	pb:SetPoint('TOPLEFT', self, 'LEFT', leftX, leftY)
	pb:SetFrameLevel(self.Health:GetFrameLevel()-5)

	return pb
end

--[[

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

--[[

]]
core.UpdateName_PartyTarget = function(health, unit, min, max)
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[

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

--[[

]]
core.CheckForInterrupt = function(bar, unit)
	if ( bar.interrupt and UnitCanAttack('player', unit) ) then
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbarNoInterrupt))
	else
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbar))
	end
end

--[[

]]
core.FilterSpecialsFocus = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if ( caster ~= 'player' ) then return false end
	return lib.in_array(spellID, settings.SpecialAurasFocus)
end

--[[

]]
core.FilterSpecialsParty = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if ( caster ~= 'player' ) then return false end
	return lib.in_array(spellID, settings.SpecialAurasParty)
end

-- ************************************************************************************************
-- ***** HEALTH UPDATES ***************************************************************************
-- ************************************************************************************************

--[[

]]
core.UpdateHealth_percent = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[

]]
core.UpdateHealth_deficit = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s-%s|r', oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min))
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[

]]
core.UpdateHealth_player = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s-%s|r | |cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthDeficit, lib.Shorten(max-min), oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min))
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
end

--[[

]]
core.UpdateHealth_target = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%s | %d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, lib.Shorten(min), (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

--[[

]]
core.UpdateHealth_pet = function(health, unit, min, max)
	if ( min ~= max ) then
		health.value:SetFormattedText('|cff%s%d%%|r', oUF_PhantomMenaceSettings.general.color.healthValue, (min/max)*100)
	else
		health.value:SetFormattedText('|cff%s%s|r', oUF_PhantomMenaceSettings.general.color.healthValue, min)
	end
end

--[[

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

--[[

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

--[[

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


--[[

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

--[[

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
=======
--[[ oUF_PhantomMenace
	This is a layout for the incredibly awesome oUF by haste.
	
	PLEASE NOTE that this layout comes with no warranty and "as it is". It was created to fit my very own
	needs, so please understand, that I'll not put any effort in "fixing" something for you, "adding" something
	for you or make any changes to this.
	Anyway, when you read this, you've already downloaded my layout, so please, feel free to modify it to your
	own needs.
]]

local ADDON_NAME, ns = ...								-- get the addons namespace to exchange functions between core and layout
local core = {}

local lib = ns.lib										-- get the lib
local settings = ns.settings							-- get the settings

--[[ FUNCTIONS
	Now we're starting with our functions. 
	Note that in this file are only the functions, which are used by more than one layout-function.
]]

	--[[ Creates the HealthBar
		FRAME CreateHealthBar(FRAME frame)
	]]
	core.CreateHealthBar = function(frame)
		local hp = CreateFrame('StatusBar', nil, frame)
		hp:SetFrameLevel(10)
		hp:SetAllPoints(frame)
		hp:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		hp:SetStatusBarColor(unpack(settings.src.bar))

		hp.bg = hp:CreateTexture(nil, 'BACKGROUND')
		hp.bg:SetAllPoints(hp)
		hp.bg:SetTexture(settings.src.textures.bar)
		hp.bg:SetVertexColor(unpack(settings.src.bar_bg))

		local mhpb = CreateFrame('StatusBar', nil, self)
		mhpb:SetFrameLevel(11)
		mhpb:SetPoint('TOPLEFT', hp:GetStatusBarTexture(), 'TOPRIGHT')
		mhpb:SetPoint('BOTTOMLEFT', hp:GetStatusBarTexture(), 'BOTTOMRIGHT')
		mhpb:SetWidth(frame:GetWidth())
		mhpb:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		mhpb:SetStatusBarColor(0.3, 0.6, 0.3)
		mhpb:Hide()

		local ohpb = CreateFrame('StatusBar', nil, self)
		ohpb:SetFrameLevel(11)
		ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT')
		ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT')
		ohpb:SetWidth(frame:GetWidth())
		ohpb:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		ohpb:SetStatusBarColor(0.8, 0.7, 0.3)
		ohpb:Hide()

		frame.HealPrediction = {
			['myBar'] = mhpb,
			['otherBar'] = ohpb, 
			['maxOverflow'] = 1.0,
		}

		return hp
	end


	--[[ Creates the PowerBar
		FRAME CreatePowerBar(FRAME frame, INT width, INT height)
	]]
	core.CreatePowerBar = function(frame, width, height)
		local pb = CreateFrame('StatusBar', nil, frame)
		pb:SetFrameLevel(5)
		pb:SetSize(width, height)
		pb:SetStatusBarTexture(settings.src.textures.solid, 'ARTWORK')

		pb.bg = pb:CreateTexture(nil, 'BORDER')
		pb.bg:SetAllPoints(pb)
		pb.bg:SetTexture(settings.src.textures.solid)
		pb.bg:SetAlpha(0.5)

		pb.back = pb:CreateTexture(nil, 'BACKGROUND')
		pb.back:SetAllPoints(pb)
		pb.back:SetTexture(settings.src.textures.solid)
		pb.back:SetVertexColor(0.2, 0.2, 0.2)

		pb.colorDisconnected = true
		pb.colorClass = true
		pb.colorReaction = true

		return pb
	end


	--[[ Generic function to create borders
		FRAME CreateBorder_Generic(FRAME frame, STRING tex, INT xOff, INT yOff)
	]]
	core.CreateBorder_Generic = function(frame, tex, xOff, yOff)
		local b = CreateFrame('Frame', nil, frame)
		b:SetFrameLevel(40)
		b:SetSize(256, 64)
		b:SetPoint('TOPLEFT', frame, 'TOPLEFT', xOff, yOff)
		b.tex = b:CreateTexture(nil, 'ARTWORK')
		b.tex:SetTexture(tex)
		b.tex:SetAllPoints(b)
		return b
	end


	--[[ Creates the Rune frame (for DKs)
		FRAME CreateRuneFrame(FRAME frame)
	]]
	core.CreateRuneFrame = function(frame)
		local rf = CreateFrame('Frame', nil, frame)
		rf:SetFrameLevel(35)

		rf[1] = CreateFrame('StatusBar', nil, rf)
		rf[1]:SetSize(20, 7)
		rf[1]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[1]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 18, 5)
		rf[1].back = rf[1]:CreateTexture(nil, 'BACKGROUND')
		rf[1].back:SetTexture(settings.src.textures.solid)
		rf[1].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[1].back:SetAllPoints(rf[1])

		rf[2] = CreateFrame('StatusBar', nil, rf)
		rf[2]:SetSize(20, 7)
		rf[2]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[2]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 41, 5)
		rf[2].back = rf[2]:CreateTexture(nil, 'BACKGROUND')
		rf[2].back:SetTexture(settings.src.textures.solid)
		rf[2].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[2].back:SetAllPoints(rf[2])

		rf[3] = CreateFrame('StatusBar', nil, rf)
		rf[3]:SetSize(20, 7)
		rf[3]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[3]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 79, 5)
		rf[3].back = rf[3]:CreateTexture(nil, 'BACKGROUND')
		rf[3].back:SetTexture(settings.src.textures.solid)
		rf[3].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[3].back:SetAllPoints(rf[3])

		rf[4] = CreateFrame('StatusBar', nil, rf)
		rf[4]:SetSize(20, 7)
		rf[4]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[4]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 102, 5)
		rf[4].back = rf[4]:CreateTexture(nil, 'BACKGROUND')
		rf[4].back:SetTexture(settings.src.textures.solid)
		rf[4].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[4].back:SetAllPoints(rf[4])

		rf[5] = CreateFrame('StatusBar', nil, rf)
		rf[5]:SetSize(20, 7)
		rf[5]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[5]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 140, 5)
		rf[5].back = rf[5]:CreateTexture(nil, 'BACKGROUND')
		rf[5].back:SetTexture(settings.src.textures.solid)
		rf[5].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[5].back:SetAllPoints(rf[5])

		rf[6] = CreateFrame('StatusBar', nil, rf)
		rf[6]:SetSize(20, 7)
		rf[6]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[6]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 163, 5)
		rf[6].back = rf[6]:CreateTexture(nil, 'BACKGROUND')
		rf[6].back:SetTexture(settings.src.textures.solid)
		rf[6].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[6].back:SetAllPoints(rf[6])

		return rf
	end


	--[[ Creates the HolyPower/SoulShard frame for Paladins/Warlocks
		FRAME CreateHolyShardsFrame(FRAME frame)
		Note: Coloring is done in the layout-function.
	]]
	core.CreateHolyShardsFrame = function(frame)
		local hsf = CreateFrame('Frame', nil, frame)
		hsf:SetFrameLevel(35)

		hsf[1] = hsf:CreateTexture(nil, 'BORDER')
		hsf[1]:SetTexture(settings.src.textures.solid)
		hsf[1]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -114, 5)
		hsf[1]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -92, -3)

		hsf[2] = hsf:CreateTexture(nil, 'BORDER')
		hsf[2]:SetTexture(settings.src.textures.solid)
		hsf[2]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -77, 5)
		hsf[2]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -55, -3)

		hsf[3] = hsf:CreateTexture(nil, 'BORDER')
		hsf[3]:SetTexture(settings.src.textures.solid)
		hsf[3]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -40, 5)
		hsf[3]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -18, -3)

		hsf.back1 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back1:SetTexture(settings.src.textures.solid)
		hsf.back1:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back1:SetAllPoints(hsf[1])

		hsf.back2 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back2:SetTexture(settings.src.textures.solid)
		hsf.back2:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back2:SetAllPoints(hsf[2])

		hsf.back3 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back3:SetTexture(settings.src.textures.solid)
		hsf.back3:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back3:SetAllPoints(hsf[3])

		return hsf
	end


	--[[ Creates the Eclipse-bar for Balance-Druids
		FRAME CreateEclipseBar(FRAME frame)
	]]
	core.CreateEclipseBar = function(frame)
		local eb = CreateFrame('Frame', nil, frame)
		eb:SetFrameLevel(35)
		eb:SetPoint('TOPLEFT', frame, 'TOPLEFT', 18, 5)
		eb:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -18, -3)

		eb.LunarBar = CreateFrame('StatusBar', nil, eb)
		eb.LunarBar:SetFrameLevel(16)
		eb.LunarBar:SetPoint('LEFT', eb, 'LEFT')
		eb.LunarBar:SetSize(164, 8)
		eb.LunarBar:SetStatusBarTexture(settings.src.textures.bar)
		eb.LunarBar:SetStatusBarColor(0.34, 0.1, 0.86)

		eb.SolarBar = CreateFrame('StatusBar', nil, eb)
		eb.SolarBar:SetFrameLevel(16)
		eb.SolarBar:SetPoint('LEFT', eb.LunarBar:GetStatusBarTexture(), 'RIGHT')
		eb.SolarBar:SetSize(164, 8)
		eb.SolarBar:SetStatusBarTexture(settings.src.textures.bar)
		eb.SolarBar:SetStatusBarColor(0.95, 0.73, 0.15)

		return eb
	end


	--[[ Creates the Totem-bar for Shamans (supporting oUF_boring_totembar)
		FRAME CreateTotems(FRAME frame)
	]]
	core.CreateTotems = function(frame)
		local totems = CreateFrame('Frame', nil, frame)
		totems:SetFrameLevel(35)

		totems[1] = CreateFrame('Frame', nil, totems)
		totems[1]:SetFrameLevel(16)
		totems[1]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -151, 5)
		totems[1]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -128, -3)
		totems[1].StatusBar = CreateFrame('StatusBar', nil, totems[1])
		totems[1].StatusBar:SetAllPoints(totems[1])
		totems[1].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[2] = CreateFrame('Frame', nil, frame)
		totems[2]:SetFrameLevel(16)
		totems[2]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -114, 5)
		totems[2]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -91, -3)
		totems[2].StatusBar = CreateFrame('StatusBar', nil, totems[2])
		totems[2].StatusBar:SetAllPoints(totems[2])
		totems[2].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[3] = CreateFrame('Frame', nil, frame)
		totems[3]:SetFrameLevel(16)
		totems[3]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -77, 5)
		totems[3]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -54, -3)
		totems[3].StatusBar = CreateFrame('StatusBar', nil, totems[3])
		totems[3].StatusBar:SetAllPoints(totems[3])
		totems[3].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[4] = CreateFrame('Frame', nil, frame)
		totems[4]:SetFrameLevel(16)
		totems[4]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -40, 5)
		totems[4]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -17, -3)
		totems[4].StatusBar = CreateFrame('StatusBar', nil, totems[4])
		totems[4].StatusBar:SetAllPoints(totems[4])
		totems[4].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems.back = {}
		totems.back[1] = totems:CreateTexture(nil, 'BORDER')
		totems.back[1]:SetAllPoints(totems[1])
		totems.back[1]:SetTexture(settings.src.textures.solid)
		totems.back[1]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[2] = totems:CreateTexture(nil, 'BORDER')
		totems.back[2]:SetAllPoints(totems[2])
		totems.back[2]:SetTexture(settings.src.textures.solid)
		totems.back[2]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[3] = totems:CreateTexture(nil, 'BORDER')
		totems.back[3]:SetAllPoints(totems[3])
		totems.back[3]:SetTexture(settings.src.textures.solid)
		totems.back[3]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[4] = totems:CreateTexture(nil, 'BORDER')
		totems.back[4]:SetAllPoints(totems[4])
		totems.back[4]:SetTexture(settings.src.textures.solid)
		totems.back[4]:SetVertexColor(0.1, 0.1, 0.1)

		return totems
	end


	--[[ Creates the player's castbar
		FRAME CreatePlayerCastbar()
	]]
	core.CreatePlayerCastbar = function()
		local cb = CreateFrame('StatusBar', nil, UIParent)
		cb:SetStatusBarTexture(settings.src.textures.bar, 'ARTWORK')
		cb:SetStatusBarColor(0.86, 0.5, 0, 1)
		cb:SetWidth(PhantomMenaceOptions.castbar.width)
		cb:SetHeight(PhantomMenaceOptions.castbar.height)
		cb:SetPoint('CENTER', UIParent, 'CENTER', 15, -175)

		cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
		cb.bg:SetAllPoints(cb)
		cb.bg:SetTexture(settings.src.textures.bar)
		cb.bg:SetVertexColor(0.1, 0.1, 0.1)

		cb.SafeZone = cb:CreateTexture(nil,'BORDER')
		cb.SafeZone:SetPoint('TOPRIGHT')
		cb.SafeZone:SetPoint('BOTTOMRIGHT')
		cb.SafeZone:SetHeight(22)
		cb.SafeZone:SetTexture(settings.src.textures.bar)
		cb.SafeZone:SetVertexColor(.69,.31,.31)

		cb.Text = lib.CreateFontObject(cb, PhantomMenaceOptions.castbar.fontSize, settings.src.fonts.value)
		cb.Text:SetPoint('LEFT', 3, 2)
		cb.Text:SetTextColor(0.84, 0.75, 0.65)

		cb.Time = lib.CreateFontObject(cb, PhantomMenaceOptions.castbar.fontSize, settings.src.fonts.value)
		cb.Time:SetPoint('RIGHT', -3, 2)
		cb.Time:SetTextColor(0.84, 0.75, 0.65)
		cb.Time:SetJustifyH('RIGHT')

		cb.Icon = cb:CreateTexture(nil, 'ARTWORK')
		cb.Icon:SetHeight(25)
		cb.Icon:SetWidth(25)
		cb.Icon:SetTexCoord(0.1,0.9,0.1,0.9)
		cb.Icon:SetPoint('RIGHT', cb, 'LEFT', -10, 0)

		cb.Border = CreateFrame('Frame', nil, cb)
		cb.Border:SetPoint('TOPLEFT', cb, 'TOPLEFT', -5, 5)
		cb.Border:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 5, -4)
		cb.Border:SetBackdrop( {
			bgFile = nil, 
			edgeFile = settings.src.textures.border_generic,
			tile = false, 
			edgeSize = 8,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )

		cb.Icon.Border = CreateFrame('Frame', nil, cb)
		cb.Icon.Border:SetPoint('TOPLEFT', cb.Icon, 'TOPLEFT', -5, 5)
		cb.Icon.Border:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMRIGHT', 5, -4)
		cb.Icon.Border:SetBackdrop( {
			bgFile = nil, 
			edgeFile = settings.src.textures.border_generic,
			tile = false, 
			edgeSize = 8,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )

		return cb
	end


	--[[ Creates a generic castbar, which is used on certain unitframes
		FRAME CreateNameplateCastbar(FRAME hold)
	]]
	core.CreateNameplateCastbar = function(hold)
		local cb = CreateFrame('StatusBar', nil, hold)
		cb:SetFrameLevel(35)
		cb:SetStatusBarTexture(settings.src.textures.bar, 'ARTWORK')
		cb:SetStatusBarColor(0.86, 0.5, 0, 1)
		cb:SetAllPoints(hold)

		cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
		cb.bg:SetAllPoints(cb)
		cb.bg:SetTexture(settings.src.textures.solid)
		cb.bg:SetVertexColor(0.1, 0.1, 0.1)

		cb.Text = lib.CreateFontObject(cb, 16, settings.src.fonts.value)
		cb.Text:SetPoint('LEFT', 3, 1)
		cb.Text:SetTextColor(unpack(settings.src.default_font))

		cb.Time = lib.CreateFontObject(cb, 16, settings.src.fonts.value)
		cb.Time:SetPoint('RIGHT', -3, 1)
		cb.Time:SetTextColor(unpack(settings.src.default_font))
		cb.Time:SetJustifyH('RIGHT')

		return cb
	end


	--[[ Creates the overlay for Threat-/Debuff-highlighting
		FRAME CreateOverlay(FRAME frame)
	]]
	core.CreateOverlay = function(frame)
		local t = CreateFrame('Frame', nil, frame)
		t:SetFrameLevel(20)
		t.tex = t:CreateTexture(nil, 'OVERLAY')
		t.tex:SetTexture(settings.src.textures.overlay)
		t.tex:SetAllPoints(frame.Health)

		t:Hide()
		return t
	end


	--[[ Creates a frame for Debuff-highlighting.
		This will actually only be used for event-registrations
		FRAME CreateDebuffHighlight(FRAME frame)
	]]
	core.CreateDebuffHighlight = function(frame)
		local dbh = CreateFrame('FRAME', nil, frame)
		dbh:RegisterEvent('UNIT_AURA')
		dbh:RegisterEvent('PLAYER_TALENT_UPDATE', lib.CheckSpec)
		dbh:RegisterEvent('CHARACTER_POINTS_CHANGED', lib.CheckSpec)
		dbh:SetScript('OnEvent', function(self, event, unit)
			if ( event == 'UNIT_AURA' ) then
				core.UpdateOverlay(self:GetParent(), nil, unit)
			else
				lib.CheckSpec()
			end
		end)
		return dbh
	end


	--[[ Creates a statusbar for incoming resses (support for oUF_ResComm)
		STATUSBAR CreateRezzComm(FRAME frame)
	]]
	core.CreateRezzComm = function(frame)
		local rc = CreateFrame('StatusBar', nil, frame)
		rc:SetFrameLevel(15)
		rc:SetAllPoints(frame.Health)
		rc:SetStatusBarTexture(settings.src.textures.bar)
		rc:SetStatusBarColor(1, 1, 0)

		return rc
	end


-- ***** ENGINES ***************************************************************************************

	--[[ Update player's health
	]]
	core.UpdateHealth_player = function(health, unit, min, max)
		if ( min ~= max ) then
			health.value:SetFormattedText('|cffCC0000-%s|r|cffCCCCCC | %s|r', lib.Shorten((max-min)), lib.Shorten(min))
			health.value:Show()
		else
			health.value:SetText(min)
			if (not UnitAffectingCombat('player')) then
				health.value:Hide()
			end
		end
	end


	--[[ Shows health value and percent text or just the value, if at 100%
	]]
	core.UpdateHealth_min_percent = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.dead)
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.ghost)
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.offline)
		else
			if (min ~= max) then
				health.value:SetFormattedText('|cffCCCCCC%s | %d%%|r', lib.Shorten(min), (min/max)*100)
			else
				health.value:SetText(min)
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as percent only.
	]]
	core.UpdateHealth_percent = function(health, unit, min, max)
		health.value:Show()
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.dead)
			-- health.value:Show()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.ghost)
			-- health.value:Show()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.offline)
			-- health.value:Show()
		elseif ( min ~= max ) then
			health.value:SetFormattedText('|cffCCCCCC%d%%|r', (min/max)*100)
			-- health.value:Show()
		else
			health.value:SetFormattedText('|cffCCCCCC%d%%|r', (min/max)*100)
			if (not UnitAffectingCombat(unit)) then
				health.value:Hide()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as deficit from MAX.
	]]
	core.UpdateHealth_deficit = function(health, unit, min, max)
		health.value:Show()
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.dead)
			-- health.value:Show()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.ghost)
			-- health.value:Show()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.offline)
			-- health.value:Show()
		elseif ( min ~= max ) then
			health.value:SetFormattedText('|cffCC0000-%s|r', lib.Shorten(max-min))
			-- health.value:Show()
		else
			health.value:SetText(min)
			if (not UnitAffectingCombat(unit)) then
				health.value:Hide()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as percent.
		Toggles Name-/Health-visibility.
	]]
	core.UpdateHealth_raid = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.dead)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.ghost)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.offline)
			health.value:Show()
			health:GetParent().Name:Hide()
		else
			if ( min ~= max ) then
				health.value:SetFormattedText('|cffCCCCCC%d%%|r', (min/max)*100)
				health.value:Show()
				health:GetParent().Name:Hide()
			else
				health.value:Hide()
				health:GetParent().Name:Show()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as deficit from MAX.
		Toggles Name-/Health-visibility.
	]]
	core.UpdateHealth_raid_deficit = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.dead)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.ghost)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(PhantomMenaceOptions.strings.offline)
			health.value:Show()
			health:GetParent().Name:Hide()
		else
			if ( min ~= max ) then
				health.value:SetFormattedText('|cffCC0000-%s|r', lib.Shorten(max-min))
				health.value:Show()
				health:GetParent().Name:Hide()
			else
				health.value:Hide()
				health:GetParent().Name:Show()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Update player's power
		This shows the current value of power (mana, rage, energy, focus, runic power).
		For druids, it will show mana at any time.
	]]
	core.UpdatePower_player = function(power, unit, min, max)
		if ( lib.playerclass == 'DRUID' ) then
			min, max = UnitPower(unit, 0), UnitPowerMax(unit, 0)
		end
		power.value:SetText(lib.Shorten(min))
	end


	--[[ Update power
		This shows the current value of power (mana, rage, energy, focus, runic power).
	]]
	core.UpdatePower = function(power, unit, min, max)
		power.value:SetText(lib.Shorten(min))
		power:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[
	
	]]
	core.CombatShowHealthPlayer = function(frame, event)
		if ( event == 'PLAYER_REGEN_DISABLED' ) then
			frame.value:Show()
			frame:GetParent():SetScript('OnEnter', nil)
			frame:GetParent():SetScript('OnLeave', nil)
		else
			frame.value:Hide()
			frame:GetParent():SetScript('OnEnter', function()
				frame:GetParent().Health.value:Show()
				frame:GetParent().Power.value:Show()
			end)
			frame:GetParent():SetScript('OnLeave', function()
				frame:GetParent().Health.value:Hide()
				frame:GetParent().Power.value:Hide()
			end)
		end
	end


	--[[
	
	]]
	core.CombatShowPowerPlayer = function(frame, event)
		if ( event == 'PLAYER_REGEN_DISABLED' ) then
			frame.value:Show()
		else
			frame.value:Hide()
		end
	end


	--[[
	
	]]
	core.CombatShowPowerTarget = function(frame, event)
		if ( event == 'PLAYER_REGEN_DISABLED' ) then
			frame.value:Show()
			frame:GetParent():SetScript('OnEnter', function()
			UnitFrame_OnEnter(frame:GetParent())
		end)
			frame:GetParent():SetScript('OnLeave', function()
			UnitFrame_OnLeave()
		end)
		else
			frame.value:Hide()
			frame:GetParent():SetScript('OnEnter', function()
				frame.value:Show()
				UnitFrame_OnEnter(frame:GetParent())
			end)
			frame:GetParent():SetScript('OnLeave', function()
				frame.value:Hide()
				UnitFrame_OnLeave()
			end)
		end
	end


	--[[ Updates the target's name
		Limited to 23 characters.
	]]
	core.UpdateName_target = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 21 then name = name:sub(1, 20)..'...' end
		self.Name:SetText(name)
	end


	--[[ Updates the target's target's name
		Limited to 6 characters.
	]]
	core.UpdateName_targettarget = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 6 then name = name:sub(1, 6) end
		self.Name:SetText(name)
	end


	--[[ Updates the focus' name.
		Limited to 15 characters.
	]]
	core.UpdateName_focus = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 15 then name = name:sub(1, 15) end
		self.Name:SetText(name)
	end


	--[[ Updates the raid-members' names.
		Limited to 6 characters.
	]]
	core.UpdateName_raid = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 6 then name = name:sub(1, 6) end
		self.Name:SetText(name)
	end


	--[[ Updates the ComboPoints.
		This is applied to the target-frame for ALL classes, since we don't know, which vehicle uses this.
		Main purpose of course for Rogues and Druids.
	]]
	core.UpdateComboPoints = function(frame)
		-- lib.debugging('UpdateComboPoints')
		local cp
		if ( UnitExists('vehicle') ) then
			cp = GetComboPoints('vehicle', 'target')
		else
			cp = GetComboPoints('player', 'target')
		end
		if (cp < 1) then
			frame.value:Hide()
		elseif ( cp < 5 ) then
			frame.value:SetText(cp)
			frame.value:Show()
		else
			frame.value:SetFormattedText('|cffCC0000%s|r', cp)
			frame.value:Show()
		end
	end


	--[[ Updates the EclipseBar's visibility.
		TODO: not working, it seems!
	
	]]
	core.UpdateEclipseBarVisibility = function(unit)
		if(powerType ~= 'ECLIPSE') then return end

		local eb = self.EclipseBar

		local power = UnitPower(unit, SPELL_POWER_ECLIPSE)
		local maxPower = UnitPowerMax(unit, SPELL_POWER_ECLIPSE)

		if(eb.LunarBar) then
			eb.LunarBar:SetMinMaxValues(-maxPower, maxPower)
			eb.LunarBar:SetValue(power)
		end

		if(eb.SolarBar) then
			eb.SolarBar:SetMinMaxValues(-maxPower, maxPower)
			eb.SolarBar:SetValue(power * -1)
		end
	end


	--[[ This updates the overlay.
		Priority is as follows: 
			If we're highlighting debuffs, we first show the debuff, then threat
	]]
	core.UpdateOverlay = function(self, event, unit)
		if ( unit ~= self.unit ) then return end
		local r, g, b, a = 1, 1, 1, 0
		if ( self.Threat ) then
			local status = UnitThreatSituation(unit)
			-- if ( self.threatStatus == status ) then return end
			if not status then status = 0 end
			-- self.threatStatus = status
			-- lib.debugging('UpdateOverlay (THREAT)')
			r, g, b, a = unpack(settings.src.threatColors[status])
			-- lib.debugging('AggroColor: '..r..'/'..g..'/'..b..'/'..a)
		end
		if ( lib.dispelAbility and self.DebuffHighlight ) then
			local debuffType = lib.GetDebuff(unit)
			if ( debuffType ) then
				-- lib.debugging('UpdateOverlay (DEBUFF)')
				r, g, b, a = unpack(settings.src.debuffColors[debuffType])
				-- lib.debugging('DebuffColor: '..r..'/'..g..'/'..b..'/'..a)
			end
		end
		-- lib.debugging('OverlayColor: '..r..'/'..g..'/'..b..'/'..a)
		self.Overlay.tex:SetVertexColor(r, g, b, a)
		self.Overlay:Show()
	end


-- ***** BUFFS/DEBUFFS *********************************************************************************

	--[[ Filter the players buffs
		BOOL FilterBuffs_player(..., INT spellID)
	]]
	core.FilterBuffs_player = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		-- lib.debugging(spellID..'('..name..')')
		return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.playerBuffs, icon, caster)
	end


	--[[ Filter the players debuffs
		BOOL FilterDebuffs_player(..., INT spellID)
	]]
	core.FilterDebuffs_player = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.playerDebuffs, icon, caster)
	end


	--[[ Filter buffs
		BOOL FilterBuffs(..., INT spellID)
	]]
	core.FilterBuffs = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		-- lib.debugging('entering FilterBuffs() with spellID='..spellID)
		if ( UnitIsFriend(unit, 'player') ) then
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.friendsBuffs, icon, caster)
		else
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.enemyBuffs, icon, caster)
		end
	end


	--[[ Filter debuffs
		BOOL FilterDebuffs(..., INT spellID)
	]]
	core.FilterDebuffs = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		if ( UnitIsFriend(unit, 'player') ) then
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.friendsDebuffs, icon, caster)
		else
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.enemyDebuffs, icon, caster)
		end
	end


	--[[ Generic PostUpdate-function to apply the OmniCC-hack
		VOID GenericPostUpdateIcon(FRAME icons, UNIT unit, BUTTON icon, INT index, INT offset, STRING filter, BOOL isDebuff)
	]]
	core.GenericPostUpdateIcon = function(icons, unit, icon, index, offset, filter, isDebuff)
		lib.OmniCCHack(icon)
	end

-- *****************************************************************************************************
ns.core = core											-- handover of the core-functions to the namespace
>>>>>>> 5cdeb3ca4ce54e72e6a343f53c244f640f1cb02c
