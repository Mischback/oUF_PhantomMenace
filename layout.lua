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


		-- ***** HEALTH ********************************************************************************
		self.Health = core.CreateHealthBar(self)

		-- ***** POWER *********************************************************************************
		self.Power = core.CreatePowerBar(self, 162, 25)
		self.Power:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -9, 16)

		-- ***** ONMOUSEOVER ***************************************************************************
		-- self:SetScript('OnEnter', UnitFrame_OnEnter)
		-- self:SetScript('OnLeave', UnitFrame_OnLeave)

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
		elseif ( lib.playerclass == 'SHAMAN' and IsAddOnLoaded('oUF_boring_totembar') ) then
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

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
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
		self.Health.value:Hide()

		self.Power.value = lib.CreateFontObject(self.Text, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		self.Health:RegisterEvent('PLAYER_REGEN_ENABLED')
		self.Health:RegisterEvent('PLAYER_REGEN_DISABLED')
		self.Health:SetScript('OnEvent', core.CombatShowHealthPlayer)
		if ( PhantomMenaceOptions.showPlayerPower ) then
			self.Power:RegisterEvent('PLAYER_REGEN_ENABLED')
			self.Power:RegisterEvent('PLAYER_REGEN_DISABLED')
			self.Power:SetScript('OnEvent', core.CombatShowPowerPlayer)
		end
		self:SetScript('OnEnter', function()
			self.Health.value:Show()
			self.Power.value:Show()
		end)
		self:SetScript('OnLeave', function()
			self.Health.value:Hide()
			self.Power.value:Hide()
		end)

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

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
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

		if ( PhantomMenaceOptions.showTargetPower ) then
			self.Power:RegisterEvent('PLAYER_REGEN_ENABLED')
			self.Power:RegisterEvent('PLAYER_REGEN_DISABLED')
			self.Power:SetScript('OnEvent', core.CombatShowPowerTarget)
		end

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', function()
			self.Power.value:Show()
			UnitFrame_OnEnter(self)
		end)
		self:SetScript('OnLeave', function()
			self.Power.value:Hide()
			UnitFrame_OnLeave()
		end)

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
		self.Debuffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -3, 20)
		self.Debuffs.CreateIcon = lib.CreateAuraIcon
		self.Debuffs.CustomFilter = core.FilterDebuffs
		self.Debuffs.PostUpdateIcon = core.GenericPostUpdateIcon

		-- ***** RAID ICON *****************************************************************************
		self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
		self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
		self.RaidIcon:SetSize(16, 16)

		-- ***** THREAT/DEBUFF HIGHLIGHTING ************************************************************
		self.Overlay = core.CreateOverlay(self)

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
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
		if ( PhantomMenaceOptions.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_percent
		end
		self.Power.PostUpdate = core.UpdatePower
		self.UNIT_NAME_UPDATE = core.UpdateName_focus
	end


	--[[ This is the style "big" for party-frames
	
	]]
	local function party(self)
		-- lib.debugging('PARTY')

		self:SetSize(160, 32)

		-- ***** MENU **********************************************************************************
		self.menu = lib.Menu
		self:RegisterForClicks('anyup')
		self:SetAttribute('*type2', 'menu')

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

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
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
		self.Health.value:Hide()

		self.Power.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 2, 3)
		self.Power.value:SetTextColor(unpack(settings.src.default_font))
		self.Power.value:Hide()

		-- ***** ONMOUSEOVER ***************************************************************************
		self:SetScript('OnEnter', function()
			self.Health.value:Show()
			self.Power.value:Show()
			UnitFrame_OnEnter(self)
		end)
		self:SetScript('OnLeave', function()
			self.Health.value:Hide()
			self.Power.value:Hide()
			UnitFrame_OnLeave()
		end)

		-- ***** ENGINES *******************************************************************************
		if ( PhantomMenaceOptions.healerMode ) then
			self.Health.PostUpdate = core.UpdateHealth_deficit
		else
			self.Health.PostUpdate = core.UpdateHealth_percent
		end
		self.Power.PostUpdate = core.UpdatePower
		self.UNIT_NAME_UPDATE = core.UpdateName_focus
	end


	--[[ This is the style for Raid-frames aswell as the style "raid" for party-frames
	
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

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
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

		-- ***** READY CHECK ***************************************************************************
		self.ReadyCheck = self.Border:CreateTexture(nil, 'OVERLAY')
		self.ReadyCheck:SetSize(16, 16)
		self.ReadyCheck:SetPoint('CENTER', self, 'RIGHT', -2, 0)

		-- ***** ENGINES *******************************************************************************
		if ( PhantomMenaceOptions.healerMode ) then
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

		if ( PhantomMenaceOptions.aggroHighlight ) then
			self.Threat = CreateFrame('Frame', nil, self)
			self.Threat.Override = core.UpdateOverlay
		end

		if ( PhantomMenaceOptions.debuffHighlight ) then
			self.DebuffHighlight = core.CreateDebuffHighlight(self)
		end

		-- ***** TEXT **********************************************************************************
		self.Health.value = lib.CreateFontObject(self.Border, 16, settings.src.fonts.value)
		self.Health.value:SetTextColor(unpack(settings.src.default_font))
		self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 3)

		-- ***** ENGINES *******************************************************************************
		if ( PhantomMenaceOptions.healerMode ) then
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
	if not PhantomMenacePositions then
		PhantomMenacePositions = {}
	end
	for k, v in pairs(settings.positions) do
		if type(v) ~= type(PhantomMenacePositions[k]) then
			PhantomMenacePositions[k] = v
		end
	end
	
	--[[ Options
		Check, if our options in the SavedVars are present and set them to default, if not!
	]]
	if not PhantomMenaceOptions then
		lib.debugging('???')
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
	oUF:Spawn('player', settings.src.unitNames.player):SetPoint(PhantomMenacePositions.player.anchorPoint, PhantomMenacePositions.player.anchorToFrame, PhantomMenacePositions.player.anchorToPoint, PhantomMenacePositions.player.x, PhantomMenacePositions.player.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_target')
	oUF:Spawn('target', settings.src.unitNames.target):SetPoint(PhantomMenacePositions.target.anchorPoint, PhantomMenacePositions.target.anchorToFrame, PhantomMenacePositions.target.anchorToPoint, PhantomMenacePositions.target.x, PhantomMenacePositions.target.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_focus')
	oUF:Spawn('focus', settings.src.unitNames.focus):SetPoint(PhantomMenacePositions.focus.anchorPoint, PhantomMenacePositions.focus.anchorToFrame, PhantomMenacePositions.focus.anchorToPoint, PhantomMenacePositions.focus.x, PhantomMenacePositions.focus.y)

	oUF:SetActiveStyle('oUF_PhantomMenace_targettarget')
	oUF:Spawn('targettarget', settings.src.unitNames.targettarget):SetPoint(PhantomMenacePositions.targettarget.anchorPoint, PhantomMenacePositions.targettarget.anchorToFrame, PhantomMenacePositions.targettarget.anchorToPoint, PhantomMenacePositions.targettarget.x, PhantomMenacePositions.targettarget.y)
	oUF:Spawn('focustarget', settings.src.unitNames.focustarget):SetPoint(PhantomMenacePositions.focustarget.anchorPoint, PhantomMenacePositions.focustarget.anchorToFrame, PhantomMenacePositions.focustarget.anchorToPoint, PhantomMenacePositions.focustarget.x, PhantomMenacePositions.focustarget.y)
	oUF:Spawn('pet', settings.src.unitNames.pet):SetPoint(PhantomMenacePositions.pet.anchorPoint, PhantomMenacePositions.pet.anchorToFrame, PhantomMenacePositions.pet.anchorToPoint, PhantomMenacePositions.pet.x, PhantomMenacePositions.pet.y)

	local partyF
	if ( PhantomMenaceOptions.partyStyle == settings.src.partyStyles.big ) then
		oUF:SetActiveStyle('oUF_PhantomMenace_party')
		if ( PhantomMenaceOptions.partyLayout == settings.src.partyLayouts['2x2'] ) then
			partyF = oUF:SpawnHeader(settings.src.unitNames.party, nil, 'party',
										'showPlayer', false,
										'showParty', true, 
										'showSolo', false,
										'showRaid', false,
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
		elseif ( PhantomMenaceOptions.partyLayout == settings.src.partyLayouts['1x4'] ) then
			partyF = oUF:SpawnHeader(settings.src.unitNames.party, nil, 'party',
										'showPlayer', false,
										'showParty', true, 
										'showSolo', false,
										'showRaid', false,
										'yOffset', -35, 
										'xOffset', 0, 
										'oUF-initialConfigFunction', [[
											self:SetWidth(160)
											self:SetHeight(32)
										]]
			)
		else
			partyF = oUF:SpawnHeader(settings.src.unitNames.party, nil, 'party',
										'showPlayer', false,
										'showParty', true, 
										'showSolo', false,
										'showRaid', false,
										'yOffset', -35, 
										'xOffset', 0, 
										'oUF-initialConfigFunction', [[
											self:SetWidth(160)
											self:SetHeight(32)
										]]
			)
		end
	end

	if ( PhantomMenaceOptions.healerMode ) then
		partyF:SetPoint(PhantomMenacePositions.party_healer.anchorPoint, PhantomMenacePositions.party_healer.anchorToFrame, PhantomMenacePositions.party_healer.anchorToPoint, PhantomMenacePositions.party_healer.x, settings.positions.party_healer.y)
	else
		partyF:SetPoint(PhantomMenacePositions.party.anchorPoint, PhantomMenacePositions.party.anchorToFrame, PhantomMenacePositions.party.anchorToPoint, PhantomMenacePositions.party.x, PhantomMenacePositions.party.y)
	end

	oUF:SetActiveStyle('oUF_PhantomMenace_raid')
	-- oUF:Spawn('focus', 'oUF_PhantomMenace_raid'):SetPoint(settings.positions.maintank.anchorPoint, settings.positions.maintank.anchorToFrame, settings.positions.maintank.anchorToPoint, settings.positions.maintank.x, settings.positions.maintank.y-75)
	local raidF
	if ( PhantomMenaceOptions.raidLayout == settings.src.raidLayouts['2'] ) then
		raidF = oUF:SpawnHeader(settings.src.unitNames.raid, nil, 'raid',
									'showPlayer', true,
									'showParty', false, 
									'showSolo', false,
									'showRaid', true,
									'groupFilter', '1,2,3,4,5,6,7,8',
									'point', 'LEFT',
									'xOffset', 10,
									'yOffset', -9, 
									'groupBy', 'GROUP',
									'groupingOrder', '1,2,3,4,5,6,7,8',
									'maxColumns', 5, 
									'unitsPerColumn', 5, 
									'columnSpacing', 10, 
									'columnAnchorPoint', 'BOTTOM',
									'oUF-initialConfigFunction', [[
										self:SetWidth(70)
										self:SetHeight(28)
									]]
		)
	elseif ( PhantomMenaceOptions.raidLayout == settings.src.raidLayouts['3'] ) then
		raidF = oUF:SpawnHeader(settings.src.unitNames.raid, nil, 'raid',
									'showPlayer', false,
									'showParty', false, 
									'showSolo', false,
									'showRaid', true,
									'groupFilter', '1,2,3,4,5,6,7,8',
									'point', 'LEFT',
									'xOffset', 10,
									'yOffset', -9, 
									'groupBy', 'GROUP',
									'groupingOrder', '1,2,3,4,5,6,7,8',
									'maxColumns', 3, 
									'unitsPerColumn', 3, 
									'columnSpacing', 10, 
									'columnAnchorPoint', 'BOTTOM',
									'oUF-initialConfigFunction', [[
										self:SetWidth(70)
										self:SetHeight(28)
									]]
		)
	elseif ( PhantomMenaceOptions.raidLayout == settings.src.raidLayouts['5'] ) then
		raidF = oUF:SpawnHeader(settings.src.unitNames.raid, nil, 'raid',
									'showPlayer', true,
									'showParty', false, 
									'showSolo', false,
									'showRaid', true,
									'groupFilter', '1,2,3,4,5,6,7,8',
									'point', 'TOP',
									'xOffset', 0,
									'yOffset', -9, 
									'groupBy', 'GROUP',
									'groupingOrder', '1,2,3,4,5,6,7,8',
									'maxColumns', 8, 
									'unitsPerColumn', 5, 
									'columnSpacing', 10, 
									'columnAnchorPoint', 'LEFT',
									'oUF-initialConfigFunction', [[
										self:SetWidth(70)
										self:SetHeight(28)
									]]
		)
	end

	if ( PhantomMenaceOptions.healerMode ) then
		raidF:SetPoint(PhantomMenacePositions.raid_healer.anchorPoint, PhantomMenacePositions.raid_healer.anchorToFrame, PhantomMenacePositions.raid_healer.anchorToPoint, PhantomMenacePositions.raid_healer.x, PhantomMenacePositions.raid_healer.y)
	else
		raidF:SetPoint(PhantomMenacePositions.raid.anchorPoint, PhantomMenacePositions.raid.anchorToFrame, PhantomMenacePositions.raid.anchorToPoint, PhantomMenacePositions.raid.x, PhantomMenacePositions.raid.y)
	end

	oUF:SetActiveStyle('oUF_PhantomMenace_maintank')
	local maintankF = oUF:SpawnHeader(settings.src.unitNames.maintank, nil, 'raid', 
									'showRaid', true, 
									'yOffset', -25, 
									'groupFilter', 'MAINTANK')
	if ( PhantomMenaceOptions.healerMode ) then
		maintankF:SetPoint(PhantomMenacePositions.maintank_healer.anchorPoint, PhantomMenacePositions.maintank_healer.anchorToFrame, PhantomMenacePositions.maintank_healer.anchorToPoint, PhantomMenacePositions.maintank_healer.x, PhantomMenacePositions.maintank_healer.y)
	else
		maintankF:SetPoint(PhantomMenacePositions.maintank.anchorPoint, PhantomMenacePositions.maintank.anchorToFrame, PhantomMenacePositions.maintank.anchorToPoint, PhantomMenacePositions.maintank.x, PhantomMenacePositions.maintank.y)
	end

	local bossF = {}
	for k = 1, MAX_BOSS_FRAMES do
		bossF[k] = oUF:Spawn('boss'..k, 'oUF_PhantomMenace_boss'..k)
		if ( k == 1 ) then
			bossF[k]:SetPoint(PhantomMenacePositions.boss.anchorPoint, PhantomMenacePositions.boss.anchorToFrame, PhantomMenacePositions.boss.anchorToPoint, PhantomMenacePositions.boss.x, PhantomMenacePositions.boss.y)
		else
			bossF[k]:SetPoint('TOPLEFT', bossF[k-1], 'BOTTOMLEFT', 0, -10)
		end
	end
end)