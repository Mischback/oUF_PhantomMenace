--[[ oUF_PhantomMenace
	This is a layout for the incredibly awesome oUF by haste.
	
	PLEASE NOTE that this layout comes with no warranty and "as it is". It was created to fit my very own
	needs, so please understand, that I'll not put any effort in "fixing" something for you, "adding" something
	for you or make any changes to this.
	Anyway, when you read this, you've already downloaded my layout, so please, feel free to modify it to your
	own needs.
]]

local ADDON_NAME, ns = ...								-- get the addons namespace to exchange functions between core and layout
local oUF = ns.oUF or oUF
assert(oUF, "oUF_PhantomMenace was unable to locate oUF install.")
local oUF_PhantomMenace = CreateFrame('Frame')

local settings = ns.settings							-- get the settings
local lib = ns.lib										-- get the library
local core = ns.core									-- get the core

-- *****************************************************************************************************

	--[[
	
	]]
	local function player(self, unit, isSingle)
		-- lib.debugging('PLAYER')

		self:SetSize(200, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		-- self:SetScript('OnEnter', UnitFrame_OnEnter)
		-- self:SetScript('OnLeave', UnitFrame_OnLeave)
		self:SetScript('OnEnter', function()
			self.Power.value:Show()
		end)
		self:SetScript('OnLeave', function()
			self.Power.value:Hide()
		end)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 162, 25)
		self.Power:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -9, 16)

		-- ***** BORDER ********************************************************************************
		if ( lib.playerclass == 'DEATHKNIGHT' ) then
			self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_6, -32, 14)
			self.Runes = core.CreateRuneFrame(self)
		elseif ( lib.playerclass == 'PALADIN' ) then
			self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_3, -32, 14)
			self.HolyPower = core.CreateHolyShardsFrame(self)
			self.HolyPower[1]:SetVertexColor(0.7, 0.5, 0, 1)
			self.HolyPower[2]:SetVertexColor(0.7, 0.5, 0, 1)
			self.HolyPower[3]:SetVertexColor(0.7, 0.5, 0, 1)
		elseif ( lib.playerclass == 'WARLOCK' ) then
			self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_3, -32, 14)
			self.SoulShards = core.CreateHolyShardsFrame(self)
			self.SoulShards[1]:SetVertexColor(0.75, 0.2, 0.7)
			self.SoulShards[2]:SetVertexColor(0.75, 0.2, 0.7)
			self.SoulShards[3]:SetVertexColor(0.75, 0.2, 0.7)
		elseif ( lib.playerclass == 'DRUID' ) then
			local DruidFormChanger = CreateFrame('Frame')
			DruidFormChanger:RegisterEvent('PLAYER_TALENT_UPDATE')
			DruidFormChanger:SetScript('OnEvent', function()
				self.Border:Hide()
				self.Border = nil
				if ( self.EclipseBar ) then
					self.EclipseBar:Hide()
					self.EclipseBar = nil
				end
				if ( GetPrimaryTalentTree() == 1 ) then
					self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_bar, -32, 14)
					self.EclipseBar = core.CreateEclipseBar(self)
					self.EclipseBar.PostUpdateVisibility = core.UpdateEclipseBarVisibility
					self.Border.back = self.EclipseBar:CreateTexture(nil, 'BACKGROUND')
					self.Border.back:SetTexture(settings.src.textures.solid)
					self.Border.back:SetVertexColor(0.1, 0.1, 0.1)
					self.Border.back:SetPoint('TOPLEFT', self, 'TOPLEFT', 18, 5)
					self.Border.back:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -18, -2)
				else
					self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_standard, -32, 14)
				end
			end)
			if  ( GetPrimaryTalentTree() == 1 ) then
				self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_bar, -32, 14)
				self.EclipseBar = core.CreateEclipseBar(self)
				self.EclipseBar.PostUpdateVisibility = core.UpdateEclipseBarVisibility
				self.Border.back = self.EclipseBar:CreateTexture(nil, 'BACKGROUND')
				self.Border.back:SetTexture(settings.src.textures.solid)
				self.Border.back:SetVertexColor(0.1, 0.1, 0.1)
				self.Border.back:SetPoint('TOPLEFT', self, 'TOPLEFT', 18, 5)
				self.Border.back:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -18, -2)
			else
				self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_standard, -32, 14)
			end
		elseif ( lib.playerclass == 'SHAMAN' and  IsAddOnLoaded('oUF_boring_totembar') ) then
			self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_4, -32, 14)
			self.TotemBar = core.CreateTotems(self)
			self.TotemBar.UpdateColors = true
		else
			self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_player_standard, -32, 14)
		end

		-- ***** BUFFS/DEBUFFS *************************************************************************
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(200, 28)
		self.Buffs.size = 28
		self.Buffs.spacing = 4
		self.Buffs.num = 6
		self.Buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 5, -15)
		self.Buffs.CreateIcon = lib.CreateAuraIcon
		self.Buffs.CustomFilter = core.FilterBuffs_player
		self.Buffs.PostUpdateIcon = core.GenericPostUpdateIcon

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(200, 28)
		self.Debuffs.size = 28
		self.Debuffs.spacing = 4
		self.Debuffs.num = 6
		self.Debuffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 5, 15)
		self.Debuffs.CreateIcon = lib.CreateAuraIcon
		self.Debuffs.CustomFilter = core.FilterDebuffs_player
		self.Debuffs.PostUpdateIcon = core.GenericPostUpdateIcon

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** CASTBAR *******************************************************************************
		self.Castbar = core.CreatePlayerCastbar()

		-- ***** TEXT **********************************************************************************
		self.Text = CreateFrame('Frame', nil, UIParent)
		self.Text:SetFrameLevel(25)
		self.Health.value = lib.CreateFontObject(self.Text, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		self.Power.value = lib.CreateFontObject(self.Text, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		-- ***** ENGINES *******************************************************************************
		self.Health.PostUpdate = core.UpdateHealth_player
		self.Power.PostUpdate = core.UpdatePower_player
	end


	--[[
	
	]]
	local function target(self)
		-- lib.debugging('TARGET')

		self:SetSize(200, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', function()
			self.Power.value:Show()
			UnitFrame_OnEnter(self)
		end)
		self:SetScript('OnLeave', function()
			self.Power.value:Hide()
			UnitFrame_OnLeave()
		end)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 162, 25)
		self.Power:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', 9, 16)

		-- ***** NAME **********************************************************************************
		self.NameBG = CreateFrame('Frame', nil, self)
		self.NameBG:SetFrameLevel(30)
		self.NameBG:SetPoint('TOPLEFT', self, 'TOPLEFT', 18, 12)
		self.NameBG:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -18, -8)
		self.NameBG.tex = self.NameBG:CreateTexture(nil, 'BACKGROUND')
		self.NameBG.tex:SetAllPoints(self.NameBG)
		self.NameBG.tex:SetTexture(settings.src.textures.solid)
		self.NameBG.tex:SetVertexColor(0.1, 0.1, 0.1)

		self.Name = lib.CreateFontObject(self.NameBG, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.NameBG, 'CENTER')

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_target, -24, 18)

		-- ***** BUFFS/DEBUFFS *************************************************************************
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(200, 28)
		self.Buffs.size = 28
		self.Buffs.spacing = 4
		self.Buffs.num = 6
		self.Buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 5, -15)
		self.Buffs.CreateIcon = lib.CreateAuraIcon
		self.Buffs.CustomFilter = core.FilterBuffs
		self.Buffs.PostUpdateIcon = core.GenericPostUpdateIcon

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(200, 28)
		self.Debuffs.size = 28
		self.Debuffs.spacing = 4
		self.Debuffs.num = 6
		self.Debuffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 5, 25)
		self.Debuffs.CreateIcon = lib.CreateAuraIcon
		self.Debuffs.CustomFilter = core.FilterDebuffs
		self.Debuffs.PostUpdateIcon = core.GenericPostUpdateIcon

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPRIGHT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

 		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** CASTBAR *******************************************************************************
		self.Castbar = core.CreateNameplateCastbar(self.NameBG)

		-- ***** COMBO POINTS **************************************************************************
		self.ComboPoints = CreateFrame('Frame', nil, self)
		self.ComboPoints.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.ComboPoints.value:SetTextColor(unpack(settings.src.default_font))
		self.ComboPoints.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.ComboPoints:RegisterEvent('UNIT_COMBO_POINTS')
		self.ComboPoints:RegisterEvent('PLAYER_TARGET_CHANGED')
		self.ComboPoints:SetScript('OnEvent', core.UpdateComboPoints)

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		self.Power.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		-- ***** ENGINES *******************************************************************************
		self.Health.PostUpdate = core.UpdateHealth_min_percent
		self.Power.PostUpdate = core.UpdatePower
		self.UNIT_NAME_UPDATE = core.UpdateName_target
	end


	--[[
	
	]]
	local function targettarget(self)
		-- lib.debugging('TARGETTARGET')

		self:SetSize(85, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** NAME **********************************************************************************
		self.NameBG = CreateFrame('Frame', nil, self)
		self.NameBG:SetFrameLevel(30)
		self.NameBG:SetPoint('TOPLEFT', self, 'TOPLEFT', 13, 12)
		self.NameBG:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -13, -8)
		self.NameBG.tex = self.NameBG:CreateTexture(nil, 'BACKGROUND')
		self.NameBG.tex:SetAllPoints(self.NameBG)
		self.NameBG.tex:SetTexture(settings.src.textures.solid)
		self.NameBG.tex:SetVertexColor(0.1, 0.1, 0.1)

		self.Name = lib.CreateFontObject(self.NameBG, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.NameBG, 'CENTER')

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_targettarget, -85, 22)

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPRIGHT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		-- ***** ENGINES *******************************************************************************
		self.Health.PostUpdate = core.UpdateHealth_percent
		self.UNIT_NAME_UPDATE = core.UpdateName_targettarget
	end


	--[[
	
	]]
	local function focus(self)
		-- lib.debugging('FOCUS')

		self:SetSize(160, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', function()
			self.Power.value:Show()
			UnitFrame_OnEnter(self)
		end)
		self:SetScript('OnLeave', function()
			self.Power.value:Hide()
			UnitFrame_OnLeave()
		end)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 120, 23)
		self.Power:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -7, 16)

		-- ***** NAME **********************************************************************************
		self.NameBG = CreateFrame('Frame', nil, self)
		self.NameBG:SetFrameLevel(30)
		self.NameBG:SetPoint('TOPLEFT', self, 'TOPLEFT', 15, 12)
		self.NameBG:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -15, -8)
		self.NameBG.tex = self.NameBG:CreateTexture(nil, 'BACKGROUND')
		self.NameBG.tex:SetAllPoints(self.NameBG)
		self.NameBG.tex:SetTexture(settings.src.textures.solid)
		self.NameBG.tex:SetVertexColor(0.1, 0.1, 0.1)

		self.Name = lib.CreateFontObject(self.NameBG, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.NameBG, 'CENTER')

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_focus, -51, 18)

		-- ***** BUFFS/DEBUFFS *************************************************************************
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(200, 28)
		self.Buffs.size = 28
		self.Buffs.spacing = 4
		self.Buffs.num = 5
		self.Buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -3, -15)
		self.Buffs.CreateIcon = lib.CreateAuraIcon
		self.Buffs.CustomFilter = core.FilterBuffs
		self.Buffs.PostUpdateIcon = core.GenericPostUpdateIcon

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(200, 28)
		self.Debuffs.size = 28
		self.Debuffs.spacing = 4
		self.Debuffs.num = 5
		self.Debuffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -3, -20)
		self.Debuffs.CreateIcon = lib.CreateAuraIcon
		self.Debuffs.CustomFilter = core.FilterDebuffs
		self.Debuffs.PostUpdateIcon = core.GenericPostUpdateIcon

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** CASTBAR *******************************************************************************
		self.Castbar = core.CreateNameplateCastbar(self.NameBG)
		self.Castbar.Time:Hide()

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		self.Power.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		-- ***** ENGINES *******************************************************************************
		if ( settings.options.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_percent
		end
		self.Power.PostUpdate = core.UpdatePower
		self.UNIT_NAME_UPDATE = core.UpdateName_focus
	end


	--[[
	
	]]
	local function party(self)
		-- lib.debugging('PARTY')

		self:SetSize(160, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', function()
			self.Power.value:Show()
			UnitFrame_OnEnter(self)
		end)
		self:SetScript('OnLeave', function()
			self.Power.value:Hide()
			UnitFrame_OnLeave()
		end)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 120, 23)
		self.Power:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -7, 16)

		-- ***** NAME **********************************************************************************
		self.NameBG = CreateFrame('Frame', nil, self)
		self.NameBG:SetFrameLevel(30)
		self.NameBG:SetPoint('TOPLEFT', self, 'TOPLEFT', 15, 12)
		self.NameBG:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -15, -8)
		self.NameBG.tex = self.NameBG:CreateTexture(nil, 'BACKGROUND')
		self.NameBG.tex:SetAllPoints(self.NameBG)
		self.NameBG.tex:SetTexture(settings.src.textures.solid)
		self.NameBG.tex:SetVertexColor(0.1, 0.1, 0.1)

		self.Name = lib.CreateFontObject(self.NameBG, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.NameBG, 'CENTER')

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_focus, -51, 18)

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** CASTBAR *******************************************************************************
		self.Castbar = core.CreateNameplateCastbar(self.NameBG)
		self.Castbar.Time:Hide()

		-- ***** RessComm ******************************************************************************
		if ( IsAddOnLoaded('oUF_ResComm') ) then
			self.ResComm = core.CreateRezzComm(self)
		end

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		self.Power.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		-- ***** ENGINES *******************************************************************************
		if ( settings.options.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_percent
		end
		self.Power.PostUpdate = core.UpdatePower
		self.UNIT_NAME_UPDATE = core.UpdateName_focus
	end


	--[[
	
	]]
	local function raid(self)
		-- lib.debugging('TARGETTARGET')

		self:SetSize(70, 28)

		-- ***** MENU **********************************************************************************
		-- self.menu = lib.Menu
		-- self:RegisterForClicks('anyup')
		-- self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)
		self.Health:SetPoint('BOTTOM', 0, 3)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 70, 3)
		self.Power:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT')

		-- ***** NAME **********************************************************************************
		self.Name = lib.CreateFontObject(self.Health, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.Health, 'CENTER', 0, -3)

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_raid, -93, 17)

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPRIGHT', -2, -2)
		self.RaidIcon:SetSize(14, 14)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** RessComm ******************************************************************************
		if ( IsAddOnLoaded('oUF_ResComm') ) then
			self.ResComm = core.CreateRezzComm(self)
		end

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		-- ***** ENGINES *******************************************************************************
		if ( settings.options.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_raid_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_raid
		end
		self.UNIT_NAME_UPDATE = core.UpdateName_raid
	end


	--[[
	
	]]
	local function maintank(self)
		-- lib.debugging('MAINTANK')

		self:SetSize(160, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** NAME **********************************************************************************
		self.NameBG = CreateFrame('Frame', nil, self)
		self.NameBG:SetFrameLevel(30)
		self.NameBG:SetPoint('TOPLEFT', self, 'TOPLEFT', 15, 12)
		self.NameBG:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -15, -8)
		self.NameBG.tex = self.NameBG:CreateTexture(nil, 'BACKGROUND')
		self.NameBG.tex:SetAllPoints(self.NameBG)
		self.NameBG.tex:SetTexture(settings.src.textures.solid)
		self.NameBG.tex:SetVertexColor(0.1, 0.1, 0.1)

		self.Name = lib.CreateFontObject(self.NameBG, 14, settings.src.fonts.name)
		self.Name:SetTextColor(unpack(settings.src.default_font))
		self.Name:SetPoint('CENTER', self.NameBG, 'CENTER')

		-- ***** BORDER ********************************************************************************
		self.Border = core.CreateBorder_Generic(self, settings.src.textures.border_mt, -48, 22)

		-- ***** BUFFS/DEBUFFS *************************************************************************
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(100, 28)
		self.Buffs.size = 28
		self.Buffs.spacing = 4
		self.Buffs.num = 3
		self.Buffs.initialAnchor = 'LEFT'
		self.Buffs['growth-x'] = 'RIGHT'
		self.Buffs:SetPoint('LEFT', self, 'RIGHT', 10, 0)
		self.Buffs.CreateIcon = lib.CreateAuraIcon
		self.Buffs.CustomFilter = core.FilterBuffs
		self.Buffs.PostUpdateIcon = core.GenericPostUpdateIcon

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(100, 28)
		self.Debuffs.size = 28
		self.Debuffs.spacing = 4
		self.Debuffs.num = 3
		self.Debuffs.initialAnchor = 'RIGHT'
		self.Debuffs['growth-x'] = 'LEFT'
		self.Debuffs:SetPoint('RIGHT', self, 'LEFT', -10, 0)
		self.Debuffs.CreateIcon = lib.CreateAuraIcon
		self.Debuffs.CustomFilter = core.FilterDebuffs
		self.Debuffs.PostUpdateIcon = core.GenericPostUpdateIcon

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( settings.options.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( settings.options.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		-- ***** ENGINES *******************************************************************************
		if ( settings.options.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_percent
		end
		self.UNIT_NAME_UPDATE = core.UpdateName_focus
	end


-- *****************************************************************************************************
-- ***** ADDON_LOADED **********************************************************************************
-- *****************************************************************************************************
oUF_PhantomMenace:RegisterEvent('ADDON_LOADED')
oUF_PhantomMenace:SetScript('OnEvent', function(self, event, addon)
	if addon ~= ADDON_NAME then return end				-- jump out, if it's not our addon
	
	local k, v

	-- ***** Loading the SavedVars *********************************************************************

	--[[ Positions
		Check, if our positions in the SavedVars are present and set them to default, if not!
	]]
	-- if not PhantomMenacePositions then
		-- PhantomMenacePositions = {}
	-- end
	-- for k, v in pairs(settings.positions) do
		-- if type(v) ~= type(PhantomMenacePositions[k]) then
			-- PhantomMenacePositions[k] = v
		-- end
	-- end
	
	--[[ Options
		Check, if our options in the SavedVars are present and set them to default, if not!
	]]
	if not PhantomMenaceOptions then
		PhantomMenaceOptions = {}
	end
	for k, v in pairs(settings.options) do
		if type(v) ~= type(PhantomMenaceOptions[k]) then
			PhantomMenaceOptions[k] = v
		end
	end

	if not PhantomMenaceAuraList then
		PhantomMenaceAuraList = {}
		PhantomMenaceAuraList['locale'] = GetLocale()
	end


	-- ***** SPAWNING **********************************************************************************
	oUF:RegisterStyle('oUF_PhantomMenace_player', player)
	oUF:RegisterStyle('oUF_PhantomMenace_target', target)
	oUF:RegisterStyle('oUF_PhantomMenace_targettarget', targettarget)
	oUF:RegisterStyle('oUF_PhantomMenace_focus', focus)
	oUF:RegisterStyle('oUF_PhantomMenace_party', party)
	oUF:RegisterStyle('oUF_PhantomMenace_raid', raid)
	oUF:RegisterStyle('oUF_PhantomMenace_maintank', maintank)

	oUF:SetActiveStyle('oUF_PhantomMenace_player')
	oUF:Spawn('player', 'oUF_PhantomMenace_player'):SetPoint(settings.positions.player.anchorPoint, settings.positions.player.anchorToFrame, settings.positions.player.anchorToPoint, settings.positions.player.x, settings.positions.player.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_target')
	oUF:Spawn('target', 'oUF_PhantomMenace_target'):SetPoint(settings.positions.target.anchorPoint, settings.positions.target.anchorToFrame, settings.positions.target.anchorToPoint, settings.positions.target.x, settings.positions.target.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_focus')
	oUF:Spawn('focus', 'oUF_PhantomMenace_focus'):SetPoint(settings.positions.focus.anchorPoint, settings.positions.focus.anchorToFrame, settings.positions.focus.anchorToPoint, settings.positions.focus.x, settings.positions.focus.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_targettarget')
	oUF:Spawn('targettarget', 'oUF_PhantomMenace_targettarget'):SetPoint(settings.positions.targettarget.anchorPoint, settings.positions.targettarget.anchorToFrame, settings.positions.targettarget.anchorToPoint, settings.positions.targettarget.x, settings.positions.targettarget.y)
	oUF:Spawn('focustarget', 'oUF_PhantomMenace_focustarget'):SetPoint(settings.positions.focustarget.anchorPoint, settings.positions.focustarget.anchorToFrame, settings.positions.focustarget.anchorToPoint, settings.positions.focustarget.x, settings.positions.focustarget.y)

	-- oUF:SetActiveStyle('oUF_PhantomMenace_maintank')
	-- oUF:Spawn('focus', 'oUF_PhantomMenace_maintank'):SetPoint(settings.positions.maintank.anchorPoint, settings.positions.maintank.anchorToFrame, settings.positions.maintank.anchorToPoint, settings.positions.maintank.x, settings.positions.maintank.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_party')
	local partyF
	if ( settings.options.partyLayout == '2x2' ) then
		partyF = oUF:SpawnHeader('oUF_PhantomMenace_party', nil, 'party',
									'showPlayer', false,
									'showParty', true, 
									'showSolo', true,
									'showRaid', true,
									'yOffset', -40,
									'xOffset', -40,
									'maxColumns', 2,
									'unitsPerColumn', 2,
									'columnAnchorPoint', 'LEFT',
									'columnSpacing', 20,
									'oUF-initialConfigFunction', [[
										self:SetWidth(160)
										self:SetHeight(32)
									]]
		)
	elseif ( settings.options.partyLayout == '1x4' ) then
		partyF = oUF:SpawnHeader('oUF_PhantomMenace_party', nil, 'party',
									'showPlayer', false,
									'showParty', true, 
									'showSolo', true,
									'yOffset', -35, 
									'xOffset', 0, 
									'oUF-initialConfigFunction', [[
										self:SetWidth(160)
										self:SetHeight(32)
									]]
		)
	else
		partyF = oUF:SpawnHeader('oUF_PhantomMenace_party', nil, 'party',
									'showPlayer', true,
									'showParty', true, 
									'showSolo', true,
									'yOffset', -35, 
									'xOffset', 0, 
									'oUF-initialConfigFunction', [[
										self:SetWidth(160)
										self:SetHeight(32)
									]]
		)
	end

	if ( PhantomMenaceOptions.healerMode ) then
		partyF:SetPoint(settings.positions.party_healer.anchorPoint, settings.positions.party_healer.anchorToFrame, settings.positions.party_healer.anchorToPoint, settings.positions.party_healer.x, settings.positions.party_healer.y)
	else
		partyF:SetPoint(settings.positions.party.anchorPoint, settings.positions.party.anchorToFrame, settings.positions.party.anchorToPoint, settings.positions.party.x, settings.positions.party.y)
	end

	oUF:SetActiveStyle('oUF_PhantomMenace_raid')
	-- oUF:Spawn('focus', 'oUF_PhantomMenace_raid'):SetPoint(settings.positions.maintank.anchorPoint, settings.positions.maintank.anchorToFrame, settings.positions.maintank.anchorToPoint, settings.positions.maintank.x, settings.positions.maintank.y-75)
	local raidF
	if ( settings.options.raidLayout == 'columns' ) then
		raidF = oUF:SpawnHeader('oUF_PhantomMenace_raid', nil, 'raid',
									'showRaid', true,
									'yOffset', -9, 
									'xOffset', 0,
									'maxColumns', 8, 
									'unitsPerColumn', 5, 
									'columnAnchorPoint', 'LEFT',
									'columnSpacing', 10, 
									'groupFilter', '1,2,3,4,5,6,7,8',
									'groupBy', 'GROUP',
									'groupingOrder', '1,2,3,4,5,6,7,8',
									'oUF-initialConfigFunction', [[
										self:SetWidth(70)
										self:SetHeight(28)
									]]
		)
	elseif ( settings.options.raidLayout == 'row' ) then
		raidF = oUF:SpawnHeader('oUF_PhantomMenace_raid', nil, 'raid',
									'showPlayer', true,
									'showSolo', true,
									'showRaid', true,
									'yOffset', -9, 
									'xOffset', 0,
									'maxColumns', 5, 
									'unitsPerColumn', 8, 
									'columnAnchorPoint', 'BOTTOM',
									'columnSpacing', 10, 
									'groupFilter', '1,2,3,4,5,6,7,8',
									'groupBy', 'GROUP',
									'groupingOrder', '1,2,3,4,5,6,7,8',
									'oUF-initialConfigFunction', [[
										self:SetWidth(70)
										self:SetHeight(28)
									]]
		)
	end

	if ( PhantomMenaceOptions.healerMode ) then
		raidF:SetPoint(settings.positions.raid_healer.anchorPoint, settings.positions.raid_healer.anchorToFrame, settings.positions.raid_healer.anchorToPoint, settings.positions.raid_healer.x, settings.positions.raid_healer.y)
	else
		raidF:SetPoint(settings.positions.raid.anchorPoint, settings.positions.raid.anchorToFrame, settings.positions.raid.anchorToPoint, settings.positions.raid.x, settings.positions.raid.y)
	end

	oUF:SetActiveStyle('oUF_PhantomMenace_maintank')
	local maintankF = oUF:SpawnHeader('oUF_PredatorSimple_MT', nil, 'raid', 
									'showRaid', true, 
									'yOffset', -25, 
									'groupFilter', 'MAINTANK')
	if ( PhantomMenaceOptions.healerMode ) then
		maintankF:SetPoint(settings.positions.maintank_healer.anchorPoint, settings.positions.maintank_healer.anchorToFrame, settings.positions.maintank_healer.anchorToPoint, settings.positions.maintank_healer.x, settings.positions.maintank_healer.y)
	else
		maintankF:SetPoint(settings.positions.maintank.anchorPoint, settings.positions.maintank.anchorToFrame, settings.positions.maintank.anchorToPoint, settings.positions.maintank.x, settings.positions.maintank.y)
	end

	local bossF = {}
	for k = 1, MAX_BOSS_FRAMES do
		bossF[k] = oUF:Spawn('boss'..k, 'oUF_PhantomMenace_boss'..k)
		if ( k == 1 ) then
			bossF[k]:SetPoint(settings.positions.boss.anchorPoint, settings.positions.boss.anchorToFrame, settings.positions.boss.anchorToPoint, settings.positions.boss.x, settings.positions.boss.y)
		else
			bossF[k]:SetPoint('TOPLEFT', bossF[k-1], 'BOTTOMLEFT', 0, -10)
		end
	end
end)