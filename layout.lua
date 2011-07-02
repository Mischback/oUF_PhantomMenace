--[[ LAYOUT
	Contains the layout
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib
local core = ns.core

-- Let's get it on!
local PhantomMenace = CreateFrame('Frame')
oUF_PhantomMenaceSettings = nil
-- ************************************************************************************************

--[[

]]
local function createPlayer(self)

	local cfg = oUF_PhantomMenaceSettings['player']
	local class = settings.playerClass

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Power = core.CreatePowerbarOffsettedBG(self, -cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	-- ***** BUFFS/DEBUFFS ************************************************************************
	self.Buffs = CreateFrame('Frame', nil, self)
	self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+7))
	-- self.Buffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)
	-- self.Buffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
	self.Buffs.size = cfg.auraSize
	self.Buffs.spacing = cfg.auraSpacing
	self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Buffs.PostCreateIcon = core.PostCreateIcon

	self.Debuffs = CreateFrame('Frame', nil, self)
	self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
	self.Debuffs.size = cfg.auraSize
	self.Debuffs.spacing = cfg.auraSpacing
	self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Debuffs.PostCreateIcon = core.PostCreateIcon

	-- ***** SPECIAL POWERS ***********************************************************************
	if ( class == 'DRUID' ) then
		-- Eclipse Bar
		local ebWidth = cfg.width-(2*cfg.specialPowerOffset)

		local eb = CreateFrame('Frame', nil, self)
		eb:SetFrameLevel(35)
		eb:SetHeight(cfg.specialPowerHeight)
		eb:SetPoint('LEFT', self, 'TOPLEFT', cfg.specialPowerOffset, 1)
		eb:SetPoint('RIGHT', self, 'TOPRIGHT', -cfg.specialPowerOffset, 1)

		eb.back = lib.CreateBack(eb)

		eb.LunarBar = CreateFrame('StatusBar', nil, eb)
		eb.LunarBar:SetPoint('LEFT')
		eb.LunarBar:SetSize(ebWidth, cfg.specialPowerHeight)
		eb.LunarBar:SetStatusBarTexture(settings.tex.solid)
		eb.LunarBar:SetStatusBarColor(0.34, 0.1, 0.86)

		eb.SolarBar = CreateFrame('StatusBar', nil, eb)
		eb.SolarBar:SetPoint('LEFT', eb.LunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
		eb.SolarBar:SetSize(ebWidth, cfg.specialPowerHeight)
		eb.SolarBar:SetStatusBarTexture(settings.tex.solid)
		eb.SolarBar:SetStatusBarColor(0.95, 0.73, 0.15)

		do
			-- Health Border (TOP)
			local tex = self.Border:CreateTexture('TexPMPlayerTop', 'BORDER')
			tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)
			tex:Hide()

			tex = self.Border:CreateTexture('TexPMPlayerSpecial01', 'BORDER')
			tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('RIGHT', eb, 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial02', 'BORDER')
			tex:SetPoint('TOPLEFT', eb, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', eb, 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial03', 'BORDER')
			tex:SetPoint('TOPLEFT', eb, 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', eb, 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial04', 'BORDER')
			tex:SetPoint('TOPLEFT', eb, 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', eb, 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial05', 'BORDER')
			tex:SetPoint('TOPLEFT', eb, 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', eb, 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial06', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
			tex:SetPoint('LEFT', eb, 'RIGHT', 2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)
		end

		self.EclipseBar = eb
		self.EclipseBar.PostUpdateVisibility = core.EclipseBarVisibility
	elseif ( class == 'WARLOCK' or class == 'PALADIN' ) then
		local hs = CreateFrame('Frame', nil, self)
		hs:SetFrameLevel(35)
		hs:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width*3+oUF_PhantomMenaceSettings.general.holyshardtotems.spacing*2, cfg.specialPowerHeight)
		hs:SetPoint('RIGHT', self, 'TOPRIGHT', -cfg.specialPowerOffset, 1)

		hs[3] = hs:CreateTexture(nil, 'ARTWORK')
		hs[3]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		hs[3]:SetPoint('RIGHT', hs, 'RIGHT')
		hs[3]:SetTexture(settings.tex.solid)
		hs[3]:SetVertexColor(unpack(oUF_PhantomMenaceSettings.general.holyshardtotems[class]))
		hs[2] = hs:CreateTexture(nil, 'ARTWORK')
		hs[2]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		hs[2]:SetPoint('TOPRIGHT', hs[3], 'TOPLEFT', -oUF_PhantomMenaceSettings.general.holyshardtotems.spacing, 0)
		hs[2]:SetTexture(settings.tex.solid)
		hs[2]:SetVertexColor(unpack(oUF_PhantomMenaceSettings.general.holyshardtotems[class]))
		hs[1] = hs:CreateTexture(nil, 'ARTWORK')
		hs[1]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		hs[1]:SetPoint('TOPRIGHT', hs[2], 'TOPLEFT', -oUF_PhantomMenaceSettings.general.holyshardtotems.spacing, 0)
		hs[1]:SetTexture(settings.tex.solid)
		hs[1]:SetVertexColor(unpack(oUF_PhantomMenaceSettings.general.holyshardtotems[class]))

		hs.back = {}
		hs.back[1] = hs:CreateTexture(nil, 'BACKGROUND')
		hs.back[1]:SetPoint('TOPLEFT', hs[1], 'TOPLEFT', -3, 3)
		hs.back[1]:SetPoint('BOTTOMRIGHT', hs[1], 'BOTTOMRIGHT', 3, -3)
		hs.back[1]:SetTexture(0, 0, 0, 1)
		hs.back[2] = hs:CreateTexture(nil, 'BACKGROUND')
		hs.back[2]:SetPoint('TOPLEFT', hs[2], 'TOPLEFT', -3, 3)
		hs.back[2]:SetPoint('BOTTOMRIGHT', hs[2], 'BOTTOMRIGHT', 3, -3)
		hs.back[2]:SetTexture(0, 0, 0, 1)
		hs.back[3] = hs:CreateTexture(nil, 'BACKGROUND')
		hs.back[3]:SetPoint('TOPLEFT', hs[3], 'TOPLEFT', -3, 3)
		hs.back[3]:SetPoint('BOTTOMRIGHT', hs[3], 'BOTTOMRIGHT', 3, -3)
		hs.back[3]:SetTexture(0, 0, 0, 1)

		do
			local tex = self.Border:CreateTexture('TexPMPlayerSpecial01', 'BORDER')
			tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('RIGHT', hs[1], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial02', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[1], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', hs[1], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial03', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[1], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[1], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial04', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[1], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', hs[1], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial05', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[1], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[1], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial06', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', hs[1], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', hs[2], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial07', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[2], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', hs[2], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial08', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[2], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[2], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial09', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[2], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', hs[2], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial10', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[2], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[2], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial11', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', hs[2], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', hs[3], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial12', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[3], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', hs[3], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial13', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[3], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[3], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial14', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[3], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', hs[3], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial15', 'BORDER')
			tex:SetPoint('TOPLEFT', hs[3], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', hs[3], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial16', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
			tex:SetPoint('LEFT', hs[3], 'RIGHT', 2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)
		end

		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)

		if ( class == 'PALADIN' ) then
			self.HolyPower = hs
			self.HolyPower.Override = core.HolyPowerOverride
		else
			self.SoulShards = hs
			self.SoulShards.Override = core.SoulShardOverride
		end
	else
		-- Health Border (TOP)
		local tex = self.Border:CreateTexture('TexPMPlayerTop', 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** BORDER *******************************************************************************
	do
		-- Health Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
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

		-- Power Border
		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOM', self.Power, 'TOP', 0, 1)
		tex:SetPoint('RIGHT', self.Health, 'LEFT', -2, 0)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('LEFT', self.Power, 'RIGHT', 1, 0)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 2, -2)
		tex:SetPoint('TOP', self.Health, 'BOTTOM', 0, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
	self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
	self.RaidIcon:SetSize(16, 16)

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	-- self.Health.value:Hide()
	self.Health.PostUpdate = core.UpdateHealth_player
end

--[[

]]
local function createTarget(self)

	local cfg = oUF_PhantomMenaceSettings['target']

	core.CreateUnitFrameCastbar(self, cfg.width, cfg.height, cfg.nameplateOffset)

	self.Power = core.CreatePowerbarOffsettedBG(self, cfg.powerOffset, 0, cfg.powerWidth, -cfg.powerWidth)

	-- ***** CASTBAR *******************************************************************************
	self.Castbar.Text:SetPoint('RIGHT', -15, 0)
	self.Castbar.Time = lib.CreateFontObject(self.Castbar, 12, settings.fonts[2])
	self.Castbar.Time:SetPoint('BOTTOMRIGHT', -3, 1)
	self.Castbar.Time:SetTextColor(1, 1, 1)
	self.Castbar.Time:SetJustifyH('RIGHT')

	-- ***** BUFFS/DEBUFFS *************************************************************************
	self.Buffs = CreateFrame('Frame', nil, self)
	self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+7))
	-- self.Buffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+10)
	self.Buffs.size = cfg.auraSize
	self.Buffs.spacing = cfg.auraSpacing
	self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Buffs.PostCreateIcon = core.PostCreateIcon

	self.Debuffs = CreateFrame('Frame', nil, self)
	self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+10)
	self.Debuffs.size = cfg.auraSize
	self.Debuffs.spacing = cfg.auraSpacing
	self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Debuffs.PostCreateIcon = core.PostCreateIcon

	-- ***** BORDER ********************************************************************************
	do
		-- Power Border
		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0)
		tex:SetPoint('BOTTOM', self.Power, 'TOP', 0, 1)
		tex:SetPoint('TOPRIGHT', self.Power, 'TOPRIGHT', 2, 2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOP', self.Health, 'BOTTOM', 0, -2)
		tex:SetPoint('LEFT', self.Power, 'LEFT', -2, 0)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** ENGINES *******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self.Health.PostUpdate = core.UpdateHealth_target
end

--[[

]]
local function createFocus(self, unit)

	local cfg = oUF_PhantomMenaceSettings[unit]

	core.CreateUnitFrameCastbar(self, cfg.width, cfg.height, cfg.nameplateOffset)

	self.Power = core.CreatePowerbarOffsettedBG(self, -cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	-- ***** BUFFS/DEBUFFS *************************************************************************
	self.Buffs = CreateFrame('Frame', nil, self)
	self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+6))
	self.Buffs.size = cfg.auraSize
	self.Buffs.spacing = cfg.auraSpacing
	self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Buffs.PostCreateIcon = core.PostCreateIcon

	self.Debuffs = CreateFrame('Frame', nil, self)
	self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+10)
	self.Debuffs.size = cfg.auraSize
	self.Debuffs.spacing = cfg.auraSpacing
	self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Debuffs.PostCreateIcon = core.PostCreateIcon

	-- ***** BORDER ********************************************************************************
	do
		-- Power Border
		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOM', self.Power, 'TOP', 0, 1)
		tex:SetPoint('RIGHT', self.Health, 'LEFT', -2, 0)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('LEFT', self.Power, 'RIGHT', 1, 0)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 2, -2)
		tex:SetPoint('TOP', self.Health, 'BOTTOM', 0, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** ENGINES *******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
end

--[[

]]
local function createTargetTarget(self, unit)

	local cfg = oUF_PhantomMenaceSettings[unit] or oUF_PhantomMenaceSettings['targettarget']

	core.CreateUnitFrameName(self, cfg.width, cfg.height, cfg.nameplateOffset)

	-- ***** ENGINES *******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
end

--[[

]]
local function createPet(self)

	local cfg = oUF_PhantomMenaceSettings['pet']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Power = core.CreatePowerbarOffsettedFG(self, 2*cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)
	self.Power.Override = core.PetPowerUpdate

	-- ***** BUFFS/DEBUFFS *************************************************************************
	self.Buffs = CreateFrame('Frame', nil, self)
	self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+6))
	self.Buffs.size = cfg.auraSize
	self.Buffs.spacing = cfg.auraSpacing
	self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Buffs.PostCreateIcon = core.PostCreateIcon

	self.Debuffs = CreateFrame('Frame', nil, self)
	self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
	self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
	self.Debuffs.size = cfg.auraSize
	self.Debuffs.spacing = cfg.auraSpacing
	self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
	self.Debuffs.PostCreateIcon = core.PostCreateIcon

	-- ***** BORDER ********************************************************************************
	do
		-- Health Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
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
		tex:SetPoint('BOTTOM', self.Health, 'BOTTOM', 0, -2)
		tex:SetPoint('RIGHT', self.Power, 'LEFT', -2, 0)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOP', self.Health, 'BOTTOM', 0, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 1, -2)
		tex:SetPoint('LEFT', self.Power, 'RIGHT', 2, 0)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		-- Power Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

		tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Power, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)
	end

	-- ***** ENGINES *******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	-- self.Health.value:Hide()
	self.Health.PostUpdate = core.UpdateHealth_pet
end

-- ************************************************************************************************
PhantomMenace:RegisterEvent('ADDON_LOADED')
PhantomMenace:SetScript('OnEvent', function(self, event, addon)
	if ( addon ~= ADDON_NAME ) then return end

	oUF_PhantomMenaceSettings = settings.init
	oUF_PhantomMenaceSettings.colors = settings.colors

	oUF:RegisterStyle('oUF_PhantomMenace_player', createPlayer)
	oUF:RegisterStyle('oUF_PhantomMenace_target', createTarget)
	oUF:RegisterStyle('oUF_PhantomMenace_focus', createFocus)
	oUF:RegisterStyle('oUF_PhantomMenace_pet', createPet)
	oUF:RegisterStyle('oUF_PhantomMenace_targettarget', createTargetTarget)

	oUF:SetActiveStyle('oUF_PhantomMenace_player')
	oUF:Spawn('player', 'oUF_PhantomMenace_player'):SetPoint('RIGHT', UIParent, 'CENTER', -100, -200)

	oUF:SetActiveStyle('oUF_PhantomMenace_pet')
	oUF:Spawn('pet', 'oUF_PhantomMenace_pet'):SetPoint('RIGHT', 'oUF_PhantomMenace_player', 'LEFT', -15, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_target')
	oUF:Spawn('target', 'oUF_PhantomMenace_target'):SetPoint('LEFT', UIParent, 'CENTER', 100, -200)

	oUF:SetActiveStyle('oUF_PhantomMenace_focus')
	oUF:Spawn('focus', 'oUF_PhantomMenace_focus'):SetPoint('LEFT', UIParent, 'CENTER', 300, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_targettarget')
	oUF:Spawn('targettarget', 'oUF_PhantomMenace_targettarget'):SetPoint('LEFT', 'oUF_PhantomMenace_target', 'RIGHT', 15, 0)
	oUF:Spawn('focustarget', 'oUF_PhantomMenace_focustarget'):SetPoint('LEFT', 'oUF_PhantomMenace_focus', 'RIGHT', 10, 0)
end)