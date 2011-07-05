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

	self.Health.value = lib.CreateFontObject(self.Text, 12, settings.fonts[2])
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

	self.Name = lib.CreateFontObject(self.NameBG, 12, settings.fonts[2])
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

	cb.Text = lib.CreateFontObject(cb, 12, settings.fonts[2])
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

--[[

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

--[[

]]
core.CheckForInterrupt = function(bar, unit)
	if ( bar.interrupt and UnitCanAttack('player', unit) ) then
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbarNoInterrupt))
	else
		bar:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbar))
	end
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