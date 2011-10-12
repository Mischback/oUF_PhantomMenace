--[[ LAYOUT
	@file:			layout.lua
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
		This file (layout.lua) contains the styling functions and handles the central parts of the 
		layout. It is the only file which will directly interact with the oUF-core.

		A brief description on how this stuff works:
			Once the layout is fully loaded (ADDON_LOADED-event triggers), we will fetch the 
			saved variables.
			Once this is completed, we start the "oUF-magic": Registering our various styles, 
			spawning the frames.
			Note, that the playerframe does not consist a castbar. The player's castbar is
			its own style and thus can be moved speratedly by oUF_MovableFrames.
]]

local ADDON_NAME, ns = ...

local oUF = ns.oUF or oUF
assert(oUF, 'oUF_PhantomMenace was unable to locate oUF install...')

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib
local core = ns.core

-- Let's get it on!
local PhantomMenace = CreateFrame('Frame')
oUF_PhantomMenaceSettings = nil
-- ************************************************************************************************

--[[ Creates a castbar for the player
	This castbar is movable with oUF_MovableFrames, since it is its own unitframe!
]]
local function createPlayerCastbar(self)
	local cfg = oUF_PhantomMenaceSettings['playerCastbar']

	self:SetSize(cfg.width, cfg.height)
	self:EnableMouse(false)

	local cb = CreateFrame('StatusBar', nil, self)
	cb:SetFrameLevel(41)
	cb:SetStatusBarTexture(settings.tex.solid, 'ARTWORK')
	cb:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.castbar))
	cb:SetPoint('TOPLEFT', self, 'TOPLEFT', cfg.height+9, 0)
	cb:SetPoint('BOTTOMRIGHT', self)

	cb.SafeZone = cb:CreateTexture(nil,'BORDER')
	cb.SafeZone:SetPoint('TOPRIGHT')
	cb.SafeZone:SetPoint('BOTTOMRIGHT')
	cb.SafeZone:SetHeight(cfg.height)
	cb.SafeZone:SetTexture(settings.tex.solid)
	cb.SafeZone:SetVertexColor(.69,.31,.31)

	cb.Text = lib.CreateFontObject(cb, 12, settings.fonts['default'])
	cb.Text:SetPoint('LEFT', 3, -1)
	cb.Text:SetPoint('RIGHT', -15, -1)
	cb.Text:SetTextColor(1, 1, 1)
	cb.Text:SetJustifyH('LEFT')

	cb.Time = lib.CreateFontObject(cb, 12, settings.fonts['default'])
	cb.Time:SetPoint('RIGHT', -3, -1)
	cb.Time:SetTextColor(1, 1, 1)
	cb.Time:SetJustifyH('RIGHT')

	cb.Icon = cb:CreateTexture(nil, 'ARTWORK')
	cb.Icon:SetSize(cfg.height, cfg.height)
	cb.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	cb.Icon:SetPoint('TOPLEFT', self)

	cb.back = cb:CreateTexture(nil, 'BACKGROUND')
	cb.back:SetPoint('TOPLEFT', cb, 'TOPLEFT', -3, 3)
	cb.back:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 3, -3)
	cb.back:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

	cb.iback = cb:CreateTexture(nil, 'BACKGROUND')
	cb.iback:SetPoint('TOPLEFT', cb.Icon, 'TOPLEFT', -3, 3)
	cb.iback:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMRIGHT', 3, -3)
	cb.iback:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

	do
		local tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', cb, 'TOPRIGHT', 2, 1)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb.Icon, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', cb.Icon, 'TOPRIGHT', 2, 1)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb.Icon, 'TOPRIGHT', 1, 1)
		tex:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMRIGHT', 2, -2)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb.Icon, 'BOTTOMLEFT', -2, -1)
		tex:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMRIGHT', 1, -2)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))

		tex = cb:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', cb.Icon, 'TOPLEFT', -2, 1)
		tex:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMLEFT', -1, -1)
		tex:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.border))
	end

	self.Castbar = cb

	local gloss = CreateFrame('Frame', nil, self.Castbar)
	gloss:SetFrameLevel(50)
	gloss:SetAllPoints(self)
	gloss.left = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.left:SetHeight(cfg.height)
	gloss.left:SetWidth(13)
	gloss.left:SetTexture(settings.tex.gloss)
	gloss.left:SetTexCoord(0, 0.25, 0, 1)
	gloss.left:SetPoint('TOPLEFT', cb, 'TOPLEFT')
	gloss.right = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.right:SetHeight(cfg.height)
	gloss.right:SetWidth(13)
	gloss.right:SetTexture(settings.tex.gloss)
	gloss.right:SetTexCoord(0.75, 1, 0, 1)
	gloss.right:SetPoint('TOPRIGHT')
	gloss.mid = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.mid:SetHeight(cfg.height)
	gloss.mid:SetTexture(settings.tex.gloss)
	gloss.mid:SetTexCoord(0.25, 0.75, 0, 1)
	gloss.mid:SetPoint('TOPLEFT', gloss.left, 'TOPRIGHT')
	gloss.mid:SetPoint('TOPRIGHT', gloss.right, 'TOPLEFT')

	self.Castbar.gloss = gloss
end

--[[ Creates the player frame
	VOID createPlayer(FRAME self)

	Used for units:
		* player
	Registered as oUF-style:
		* oUF_PhantomMenace_player
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* power-bar with (toggleable) value
		* (toggleable) Buffs/Debuffs
		* (toggleable) "SpecialPowers"
			* Druid (Balance): Eclipse-bar
			* Warlock: Soul Shards
			* Paladin: Holy Power
			* Deathknight: Runes
			* Shaman: Totems
		* (toggleable) Vengeance-bar (built in) for tank-classes
		* RaidIcon
]]
local function createPlayer(self)

	local cfg = oUF_PhantomMenaceSettings['player']
	local class = settings.playerClass

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Power = core.CreatePowerbarOffsettedBG(self, -cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)
	if ( cfg.showPowerValue ) then
		self.Power.value = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
		self.Power.value:SetJustifyH('LEFT')
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 1, 1)
	end

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+7))
		-- self.Buffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)
		-- self.Buffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
		self.Buffs.size = cfg.auraSize
		self.Buffs.spacing = cfg.auraSpacing
		self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Buffs.PostCreateIcon = core.PostCreateIcon
		self.Buffs.CustomFilter = oUF_BuffFilter_Buffs

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
		self.Debuffs.size = cfg.auraSize
		self.Debuffs.spacing = cfg.auraSpacing
		self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Debuffs.PostCreateIcon = core.PostCreateIcon
		self.Debuffs.CustomFilter = oUF_BuffFilter_Debuffs
	end

	-- ***** BORDER *******************************************************************************
	do
		-- Health Border
		-- Health Border (TOP)
		local tex = self.Border:CreateTexture('TexPMPlayerTop', 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

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

	-- ***** SPECIAL POWERS ***********************************************************************
	self.SpecialPower = CreateFrame('Frame', nil, self)
	if ( class == 'DRUID' and cfg.showSpecialPower ) then
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

		-- ***** BORDER STUFF (fix the border for the eclipse bar) ********************************
		do
			_G['TexPMPlayerTop']:Hide()

			local tex = self.Border:CreateTexture('TexPMPlayerSpecial01', 'BORDER')
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

	elseif ( (class == 'WARLOCK' or class == 'PALADIN') and cfg.showSpecialPower ) then
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
		hs.back[1]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		hs.back[2] = hs:CreateTexture(nil, 'BACKGROUND')
		hs.back[2]:SetPoint('TOPLEFT', hs[2], 'TOPLEFT', -3, 3)
		hs.back[2]:SetPoint('BOTTOMRIGHT', hs[2], 'BOTTOMRIGHT', 3, -3)
		hs.back[2]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		hs.back[3] = hs:CreateTexture(nil, 'BACKGROUND')
		hs.back[3]:SetPoint('TOPLEFT', hs[3], 'TOPLEFT', -3, 3)
		hs.back[3]:SetPoint('BOTTOMRIGHT', hs[3], 'BOTTOMRIGHT', 3, -3)
		hs.back[3]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

		-- ***** BORDER STUFF (create and fix the borders for shards/holy power) ******************
		do
			_G['TexPMPlayerTop']:Hide()

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

	elseif ( class == 'DEATHKNIGHT' and cfg.showSpecialPower ) then
		local rWidth = ((cfg.width-2*cfg.specialPowerOffset)-5*oUF_PhantomMenaceSettings.general.runes.spacing)/6
		local r = CreateFrame('Frame', nil, self)
		r:SetFrameLevel(35)
		r[1] = CreateFrame('StatusBar', nil, r)
		r[1]:SetFrameLevel(36)
		r[1]:SetSize(rWidth, cfg.specialPowerHeight)
		r[1]:SetStatusBarTexture(settings.tex.solid)
		r[1]:SetPoint('LEFT', self, 'TOPLEFT', cfg.specialPowerOffset, 1)
		r[2] = CreateFrame('StatusBar', nil, r)
		r[2]:SetFrameLevel(36)
		r[2]:SetSize(rWidth, cfg.specialPowerHeight)
		r[2]:SetStatusBarTexture(settings.tex.solid)
		r[2]:SetPoint('TOPLEFT', r[1], 'TOPRIGHT', oUF_PhantomMenaceSettings.general.runes.spacing, 0)
		r[3] = CreateFrame('StatusBar', nil, r)
		r[3]:SetFrameLevel(36)
		r[3]:SetSize(rWidth, cfg.specialPowerHeight)
		r[3]:SetStatusBarTexture(settings.tex.solid)
		r[3]:SetPoint('TOPLEFT', r[2], 'TOPRIGHT', oUF_PhantomMenaceSettings.general.runes.spacing, 0)
		r[4] = CreateFrame('StatusBar', nil, r)
		r[4]:SetFrameLevel(36)
		r[4]:SetSize(rWidth, cfg.specialPowerHeight)
		r[4]:SetStatusBarTexture(settings.tex.solid)
		r[4]:SetPoint('TOPLEFT', r[3], 'TOPRIGHT', oUF_PhantomMenaceSettings.general.runes.spacing, 0)
		r[5] = CreateFrame('StatusBar', nil, r)
		r[5]:SetFrameLevel(36)
		r[5]:SetSize(rWidth, cfg.specialPowerHeight)
		r[5]:SetStatusBarTexture(settings.tex.solid)
		r[5]:SetPoint('TOPLEFT', r[4], 'TOPRIGHT', oUF_PhantomMenaceSettings.general.runes.spacing, 0)
		r[6] = CreateFrame('StatusBar', nil, r)
		r[6]:SetFrameLevel(36)
		r[6]:SetSize(rWidth, cfg.specialPowerHeight)
		r[6]:SetStatusBarTexture(settings.tex.solid)
		r[6]:SetPoint('TOPLEFT', r[5], 'TOPRIGHT', oUF_PhantomMenaceSettings.general.runes.spacing, 0)

		r.back = {}
		r.back[1] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[1]:SetPoint('TOPLEFT', r[1], 'TOPLEFT', -3, 3)
		r.back[1]:SetPoint('BOTTOMRIGHT', r[1], 'BOTTOMRIGHT', 3, -3)
		r.back[1]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		r.back[2] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[2]:SetPoint('TOPLEFT', r[2], 'TOPLEFT', -3, 3)
		r.back[2]:SetPoint('BOTTOMRIGHT', r[2], 'BOTTOMRIGHT', 3, -3)
		r.back[2]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		r.back[3] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[3]:SetPoint('TOPLEFT', r[3], 'TOPLEFT', -3, 3)
		r.back[3]:SetPoint('BOTTOMRIGHT', r[3], 'BOTTOMRIGHT', 3, -3)
		r.back[3]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		r.back[4] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[4]:SetPoint('TOPLEFT', r[4], 'TOPLEFT', -3, 3)
		r.back[4]:SetPoint('BOTTOMRIGHT', r[4], 'BOTTOMRIGHT', 3, -3)
		r.back[4]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		r.back[5] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[5]:SetPoint('TOPLEFT', r[5], 'TOPLEFT', -3, 3)
		r.back[5]:SetPoint('BOTTOMRIGHT', r[5], 'BOTTOMRIGHT', 3, -3)
		r.back[5]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		r.back[6] = r:CreateTexture(nil, 'BACKGROUND')
		r.back[6]:SetPoint('TOPLEFT', r[6], 'TOPLEFT', -3, 3)
		r.back[6]:SetPoint('BOTTOMRIGHT', r[6], 'BOTTOMRIGHT', 3, -3)
		r.back[6]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

		-- ***** BORDER STUFF (create and fix the border for the runes) ***************************
		do
			_G['TexPMPlayerTop']:Hide()

			local tex = self.Border:CreateTexture('TexPMPlayerSpecial01', 'BORDER')
			tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('RIGHT', r[1], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial02', 'BORDER')
			tex:SetPoint('TOPLEFT', r[1], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[1], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial03', 'BORDER')
			tex:SetPoint('TOPLEFT', r[1], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[1], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial04', 'BORDER')
			tex:SetPoint('TOPLEFT', r[1], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[1], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial05', 'BORDER')
			tex:SetPoint('TOPLEFT', r[1], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[1], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial06', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', r[1], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', r[2], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial07', 'BORDER')
			tex:SetPoint('TOPLEFT', r[2], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[2], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial08', 'BORDER')
			tex:SetPoint('TOPLEFT', r[2], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[2], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial09', 'BORDER')
			tex:SetPoint('TOPLEFT', r[2], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[2], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial10', 'BORDER')
			tex:SetPoint('TOPLEFT', r[2], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[2], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial11', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', r[2], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', r[3], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial12', 'BORDER')
			tex:SetPoint('TOPLEFT', r[3], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[3], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial13', 'BORDER')
			tex:SetPoint('TOPLEFT', r[3], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[3], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial14', 'BORDER')
			tex:SetPoint('TOPLEFT', r[3], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[3], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial15', 'BORDER')
			tex:SetPoint('TOPLEFT', r[3], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[3], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial16', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', r[3], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', r[4], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial17', 'BORDER')
			tex:SetPoint('TOPLEFT', r[4], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[4], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial18', 'BORDER')
			tex:SetPoint('TOPLEFT', r[4], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[4], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial19', 'BORDER')
			tex:SetPoint('TOPLEFT', r[4], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[4], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial20', 'BORDER')
			tex:SetPoint('TOPLEFT', r[4], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[4], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial21', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', r[4], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', r[5], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial22', 'BORDER')
			tex:SetPoint('TOPLEFT', r[5], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[5], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial23', 'BORDER')
			tex:SetPoint('TOPLEFT', r[5], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[5], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial24', 'BORDER')
			tex:SetPoint('TOPLEFT', r[5], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[5], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial25', 'BORDER')
			tex:SetPoint('TOPLEFT', r[5], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[5], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial26', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', r[5], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', r[6], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial27', 'BORDER')
			tex:SetPoint('TOPLEFT', r[6], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', r[6], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial28', 'BORDER')
			tex:SetPoint('TOPLEFT', r[6], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', r[6], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial29', 'BORDER')
			tex:SetPoint('TOPLEFT', r[6], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', r[6], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial30', 'BORDER')
			tex:SetPoint('TOPLEFT', r[6], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', r[6], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial31', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
			tex:SetPoint('LEFT', r[6], 'RIGHT', 2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)
		end

		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)
		self.Runes = r

	elseif ( class == 'SHAMAN' and cfg.showSpecialPower ) then
		local t = CreateFrame('Frame', nil, self)
		t:SetFrameLevel(35)
		t:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width*4+oUF_PhantomMenaceSettings.general.holyshardtotems.spacing*3, cfg.specialPowerHeight)
		t:SetPoint('RIGHT', self, 'TOPRIGHT', -cfg.specialPowerOffset, 1)

		t[4] = CreateFrame('StatusBar', nil, t)
		t[4]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		t[4]:SetFrameLevel(61)
		t[4]:SetPoint('RIGHT', t, 'RIGHT')
		t[4]:SetStatusBarTexture(settings.tex.solid)
		t[4]:SetStatusBarColor(unpack(self.colors.totems[AIR_TOTEM_SLOT]))
		t[3] = CreateFrame('StatusBar', nil, t)
		t[3]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		t[3]:SetFrameLevel(61)
		t[3]:SetPoint('TOPRIGHT', t[4], 'TOPLEFT', -oUF_PhantomMenaceSettings.general.holyshardtotems.spacing, 0)
		t[3]:SetStatusBarTexture(settings.tex.solid)
		t[3]:SetStatusBarColor(unpack(self.colors.totems[WATER_TOTEM_SLOT]))
		t[2] = CreateFrame('StatusBar', nil, t)
		t[2]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		t[2]:SetFrameLevel(61)
		t[2]:SetPoint('TOPRIGHT', t[3], 'TOPLEFT', -oUF_PhantomMenaceSettings.general.holyshardtotems.spacing, 0)
		t[2]:SetStatusBarTexture(settings.tex.solid)
		t[2]:SetStatusBarColor(unpack(self.colors.totems[EARTH_TOTEM_SLOT]))
		t[1] = CreateFrame('StatusBar', nil, t)
		t[1]:SetSize(oUF_PhantomMenaceSettings.general.holyshardtotems.width, cfg.specialPowerHeight)
		t[1]:SetFrameLevel(61)
		t[1]:SetPoint('TOPRIGHT', t[2], 'TOPLEFT', -oUF_PhantomMenaceSettings.general.holyshardtotems.spacing, 0)
		t[1]:SetStatusBarTexture(settings.tex.solid)
		t[1]:SetStatusBarColor(unpack(self.colors.totems[FIRE_TOTEM_SLOT]))

		t.back = {}
		t.back[1] = t:CreateTexture(nil, 'BACKGROUND')
		t.back[1]:SetPoint('TOPLEFT', t[1], 'TOPLEFT', -3, 3)
		t.back[1]:SetPoint('BOTTOMRIGHT', t[1], 'BOTTOMRIGHT', 3, -3)
		t.back[1]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		t.back[2] = t:CreateTexture(nil, 'BACKGROUND')
		t.back[2]:SetPoint('TOPLEFT', t[2], 'TOPLEFT', -3, 3)
		t.back[2]:SetPoint('BOTTOMRIGHT', t[2], 'BOTTOMRIGHT', 3, -3)
		t.back[2]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		t.back[3] = t:CreateTexture(nil, 'BACKGROUND')
		t.back[3]:SetPoint('TOPLEFT', t[3], 'TOPLEFT', -3, 3)
		t.back[3]:SetPoint('BOTTOMRIGHT', t[3], 'BOTTOMRIGHT', 3, -3)
		t.back[3]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))
		t.back[4] = t :CreateTexture(nil, 'BACKGROUND')
		t.back[4]:SetPoint('TOPLEFT', t[4], 'TOPLEFT', -3, 3)
		t.back[4]:SetPoint('BOTTOMRIGHT', t[4], 'BOTTOMRIGHT', 3, -3)
		t.back[4]:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

		t.c = {}
		t.c[1] = t:CreateTexture(nil, 'ARTWORK')
		t.c[1]:SetAllPoints(t[1])
		t.c[1]:SetTexture(settings.tex.solid)
		t.c[1]:SetVertexColor(unpack(self.colors.totems[FIRE_TOTEM_SLOT]))
		t.c[1]:SetAlpha(0.5)
		t.c[2] = t:CreateTexture(nil, 'ARTWORK')
		t.c[2]:SetAllPoints(t[2])
		t.c[2]:SetTexture(settings.tex.solid)
		t.c[2]:SetVertexColor(unpack(self.colors.totems[EARTH_TOTEM_SLOT]))
		t.c[2]:SetAlpha(0.5)
		t.c[3] = t:CreateTexture(nil, 'ARTWORK')
		t.c[3]:SetAllPoints(t[3])
		t.c[3]:SetTexture(settings.tex.solid)
		t.c[3]:SetVertexColor(unpack(self.colors.totems[WATER_TOTEM_SLOT]))
		t.c[3]:SetAlpha(0.5)
		t.c[4] = t:CreateTexture(nil, 'ARTWORK')
		t.c[4]:SetAllPoints(t[4])
		t.c[4]:SetTexture(settings.tex.solid)
		t.c[4]:SetVertexColor(unpack(self.colors.totems[AIR_TOTEM_SLOT]))
		t.c[4]:SetAlpha(0.5)

		-- ***** BORDER STUFF (create and fix the border for the totems) **************************
		do
			_G['TexPMPlayerTop']:Hide()

			local tex = self.Border:CreateTexture('TexPMPlayerSpecial01', 'BORDER')
			tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('RIGHT', t[1], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial02', 'BORDER')
			tex:SetPoint('TOPLEFT', t[1], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', t[1], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial03', 'BORDER')
			tex:SetPoint('TOPLEFT', t[1], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', t[1], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial04', 'BORDER')
			tex:SetPoint('TOPLEFT', t[1], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', t[1], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial05', 'BORDER')
			tex:SetPoint('TOPLEFT', t[1], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', t[1], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial06', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', t[1], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', t[2], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial07', 'BORDER')
			tex:SetPoint('TOPLEFT', t[2], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', t[2], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial08', 'BORDER')
			tex:SetPoint('TOPLEFT', t[2], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', t[2], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial09', 'BORDER')
			tex:SetPoint('TOPLEFT', t[2], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', t[2], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial10', 'BORDER')
			tex:SetPoint('TOPLEFT', t[2], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', t[2], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial11', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', t[2], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', t[3], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial12', 'BORDER')
			tex:SetPoint('TOPLEFT', t[3], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', t[3], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial13', 'BORDER')
			tex:SetPoint('TOPLEFT', t[3], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', t[3], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial14', 'BORDER')
			tex:SetPoint('TOPLEFT', t[3], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', t[3], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial15', 'BORDER')
			tex:SetPoint('TOPLEFT', t[3], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', t[3], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial16', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOM', self.Health, 'TOP', 0, 1)
			tex:SetPoint('LEFT', t[3], 'RIGHT', 2, 0)
			tex:SetPoint('RIGHT', t[4], 'LEFT', -2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial17', 'BORDER')
			tex:SetPoint('TOPLEFT', t[4], 'TOPLEFT', -2, 2)
			tex:SetPoint('BOTTOMRIGHT', t[4], 'TOPRIGHT', 2, 1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial18', 'BORDER')
			tex:SetPoint('TOPLEFT', t[4], 'TOPRIGHT', 1, 1)
			tex:SetPoint('BOTTOMRIGHT', t[4], 'BOTTOMRIGHT', 2, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial19', 'BORDER')
			tex:SetPoint('TOPLEFT', t[4], 'BOTTOMLEFT', -2, -1)
			tex:SetPoint('BOTTOMRIGHT', t[4], 'BOTTOMRIGHT', 1, -2)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial20', 'BORDER')
			tex:SetPoint('TOPLEFT', t[4], 'TOPLEFT', -2, 1)
			tex:SetPoint('BOTTOMRIGHT', t[4], 'BOTTOMLEFT', -1, -1)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)

			tex = self.Border:CreateTexture('TexPMPlayerSpecial21', 'BORDER')
			tex:SetPoint('TOP', self.Health, 'TOP', 0, 2)
			tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
			tex:SetPoint('LEFT', t[4], 'RIGHT', 2, 0)
			tex:SetTexture(settings.tex.solid)
			table.insert(self.Border.tex, tex)
		end

		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+floor(cfg.specialPowerHeight/2)+1)
		self.Totems = t
		self.Totems.Override = core.TotemOverride
	end

	-- ***** VENGEANCE ****************************************************************************
	if ( (class == 'WARRIOR' or class == 'PALADIN' or class == 'DEATHKNIGHT' or class == 'DRUID') and cfg.showVengeance ) then
		self.Vengeance = CreateFrame('StatusBar', nil, self)
		self.Vengeance:SetFrameLevel(24)
		self.Vengeance:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, 1)
		self.Vengeance:SetPoint('BOTTOMRIGHT', self)
		self.Vengeance:SetStatusBarTexture(settings.tex.solid)
		self.Vengeance:SetStatusBarColor(unpack(oUF_PhantomMenaceSettings.general.color.vengeance))
		self.Vengeance:SetMinMaxValues(0, 1)
		self.Vengeance:SetValue(0)
		self.Vengeance:RegisterEvent('UNIT_AURA')
		self.Vengeance:RegisterEvent('UNIT_MAXHEALTH')
		self.Vengeance:RegisterEvent('UNIT_LEVEL')
		self.Vengeance:RegisterEvent('PLAYER_REGEN_DISABLED')
		self.Vengeance:SetScript('OnEvent', lib.Vengeance.eventHandler)
	end

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = self.Border:CreateTexture(nil, 'OVERLAY')
	self.RaidIcon:SetPoint('CENTER', self, 'TOPLEFT', 0, 0)
	self.RaidIcon:SetSize(16, 16)

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self.Health.PostUpdate = core.UpdateHealth_player
	if ( cfg.showPowerValue ) then
		self.Power.PostUpdate = core.UpdatePower_player
	end
end

--[[ Creates the target frame
	VOID createTarget(FRAME self)

	Used for units:
		* target
	Registered as oUF-style:
		* oUF_PhantomMenace_target
	Inherites:
		core.CreateUnitFrameCastbar()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* Nameplate including name-string
		* RaidIcon
		* built-in castbar with spell-name and time
		* power-bar with (toggleable) value
		* (toggleable) Buffs/Debuffs
]]
local function createTarget(self)

	local cfg = oUF_PhantomMenaceSettings['target']

	core.CreateUnitFrameCastbar(self, cfg.width, cfg.height, cfg.nameplateOffset)

	self.Power = core.CreatePowerbarOffsettedBG(self, cfg.powerOffset, 0, cfg.powerWidth, -cfg.powerWidth)
	if ( cfg.showPowerValue ) then
		self.Power.value = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
		self.Power.value:SetJustifyH('LEFT')
		self.Power.value:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 1, 1)
	end

	-- ***** CASTBAR ******************************************************************************
	self.Castbar.Text:SetPoint('RIGHT', -20, 0)
	self.Castbar.Time = lib.CreateFontObject(self.Castbar, 12, settings.fonts['default'])
	self.Castbar.Time:SetPoint('BOTTOMRIGHT', -3, 1)
	self.Castbar.Time:SetTextColor(1, 1, 1)
	self.Castbar.Time:SetJustifyH('RIGHT')

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+7))
		self.Buffs.size = cfg.auraSize
		self.Buffs.spacing = cfg.auraSpacing
		self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Buffs.PostCreateIcon = core.PostCreateIcon
		self.Buffs.CustomFilter = oUF_BuffFilter_Buffs

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+10)
		self.Debuffs.size = cfg.auraSize
		self.Debuffs.spacing = cfg.auraSpacing
		self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Debuffs.PostCreateIcon = core.PostCreateIcon
		self.Debuffs.CustomFilter = oUF_BuffFilter_Debuffs
	end

	-- ***** BORDER *******************************************************************************
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

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self.Health.PostUpdate = core.UpdateHealth_target
	if ( cfg.showPowerValue ) then
		self.Power.PostUpdate = core.UpdatePower_target
	end
end

--[[ Creates the focus frame
	VOID createFocus(FRAME self)

	Used for units:
		* focus
	Registered as oUF-style:
		* oUF_PhantomMenace_focus
	Inherites:
		core.CreateUnitFrameCastbar()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* Nameplate including name-string
		* RaidIcon
		* built-in castbar with spell-name
		* power-bar
		* (toggleable) Buffs/Debuffs/Auras
			* Auras are atm filtered with core.FilterSpecialsFocus()
]]
local function createFocus(self)

	local cfg = oUF_PhantomMenaceSettings['focus']

	core.CreateUnitFrameCastbar(self, cfg.width, cfg.height, cfg.nameplateOffset)

	self.Power = core.CreatePowerbarOffsettedBG(self, -cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+6))
		self.Buffs.size = cfg.auraSize
		self.Buffs.spacing = cfg.auraSpacing
		self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Buffs.PostCreateIcon = core.PostCreateIcon
		self.Buffs.CustomFilter = oUF_BuffFilter_Buffs

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing+10)
		self.Debuffs.size = cfg.auraSize
		self.Debuffs.spacing = cfg.auraSpacing
		self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Debuffs.PostCreateIcon = core.PostCreateIcon
		self.Debuffs.CustomFilter = oUF_BuffFilter_Debuffs

		self.Auras = CreateFrame('Frame', nil, self)
		self.Auras:SetSize(3*cfg.height+2*cfg.auraSpacing, cfg.height)
		self.Auras:SetPoint('RIGHT', self, 'LEFT', -(9+cfg.powerWidth), 0)
		self.Auras.size = cfg.height
		self.Auras['growth-x'] = 'LEFT'
		self.Auras.initialAnchor = 'RIGHT'
		self.Auras.spacing = cfg.auraSpacing
		self.Auras.PostCreateIcon = core.PostCreateIcon
		self.Auras.CustomFilter = core.FilterSpecialsFocus
	end

	-- ***** BORDER *******************************************************************************
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

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
end

--[[ Creates the target of a target
	VOID createTargetTarget(FRAME self, STRING unit)

	Used for units:
		* targettarget
		* focustarget
	Registered as oUF-style:
		* oUF_PhantomMenace_targettarget
	Inherites:
		core.CreateUnitFrameName()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* Nameplate including name-string
		* RaidIcon
]]
local function createTargetTarget(self, unit)

	local cfg = oUF_PhantomMenaceSettings[unit] or oUF_PhantomMenaceSettings['targettarget']

	core.CreateUnitFrameName(self, cfg.width, cfg.height, cfg.nameplateOffset)

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
end

--[[ Creates the player's pet
	VOID createPet(FRAME self)

	Used for units:
		* pet
	Registered as oUF-style:
		* oUF_PhantomMenace_pet
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* power-bar (with player's class color)
		* (toggleable) Buffs/Debuffs
]]
local function createPet(self)

	local cfg = oUF_PhantomMenaceSettings['pet']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Power = core.CreatePowerbarOffsettedFG(self, 2*cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)
	self.Power.Override = core.PetPowerUpdate

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -(cfg.powerWidth+3+6))
		self.Buffs.size = cfg.auraSize
		self.Buffs.spacing = cfg.auraSpacing
		self.Buffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Buffs.PostCreateIcon = core.PostCreateIcon
		self.Buffs.CustomFilter = oUF_BuffFilter_Buffs

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetSize(floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))*(cfg.auraSize+cfg.auraSpacing)-cfg.auraSpacing, cfg.auraSize)
		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
		self.Debuffs.size = cfg.auraSize
		self.Debuffs.spacing = cfg.auraSpacing
		self.Debuffs.num = floor(cfg.width/(cfg.auraSize+cfg.auraSpacing))
		self.Debuffs.PostCreateIcon = core.PostCreateIcon
		self.Debuffs.CustomFilter = oUF_BuffFilter_Debuffs
	end

	-- ***** BORDER *******************************************************************************
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

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self.Health.PostUpdate = core.UpdateHealth_pet
end

--[[ Creates (one) party frame
	VOID createParty(FRAME self)

	Used for units:
		* party (header, so party1-party5)
	Registered as oUF-style:
		* oUF_PhantomMenace_party
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* name (inside the health-bar)
		* power-bar
		* (toggleable) Auras
			* Auras are atm filtered with core.FilterSpecialsParty()
		* RaidIcon
		* (toggleable) LfD-role
		* ReadyCheck
		* RangeCheck
]]
local function createParty(self)

	local cfg	= oUF_PhantomMenaceSettings['party']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -1, 3)

	self.Name = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Name:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 1, 4)
	self.Name:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -1, 4)

	self.Power = core.CreatePowerbarOffsettedFG(self, 2*cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Auras = CreateFrame('Frame', nil, self)
		self.Auras:SetSize(3*cfg.height+2*cfg.auraSpacing, cfg.height)
		self.Auras:SetPoint('RIGHT', self, 'LEFT', -(9+cfg.powerWidth), 0)
		self.Auras.size = cfg.height
		self.Auras['growth-x'] = 'LEFT'
		self.Auras.initialAnchor = 'RIGHT'
		self.Auras.spacing = cfg.auraSpacing
		self.Auras.PostCreateIcon = core.PostCreateIcon
		self.Auras.CustomFilter = core.FilterSpecialsParty
	end

	-- ***** BORDER ***************************************************************************
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

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** LFD ROLE *****************************************************************************
	if ( cfg.showLFD ) then
		self.LFDRole = self.Border:CreateTexture(nil, 'OVERLAY')
		self.LFDRole:SetSize(16, 16)
		self.LFDRole:SetPoint('TOPLEFT', self, 'TOPLEFT', 1, -1)
		self.LFDRole.Override = core.LFDOverride
	end

	-- ***** READY CHECK **************************************************************************
	self.ReadyCheck = self.Border:CreateTexture(nil, 'OVERLAY')
	self.ReadyCheck:SetSize(16, 16)
	self.ReadyCheck:SetPoint('LEFT', self, 'LEFT', 1, 0)

	-- ***** RANGE ********************************************************************************
	self.Range = {
		['insideAlpha'] = 1.0,
		['outsideAlpha'] = 0.4
	}

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	self.Health.value:Hide()
	if ( oUF_PhantomMenaceSettings.configuration.healerMode ) then
		self.Health.PostUpdate = core.UpdateHealth_raidHealer
	else
		self.Health.PostUpdate = core.UpdateHealth_raid
	end
	self.UNIT_NAME_UPDATE = core.UpdateName
end

--[[ Creates (one) raid frame
	VOID createRaid(FRAME self)

	Used for units:
		* raid (header, so raid1-raid40)
	Registered as oUF-style:
		* oUF_PhantomMenace_raid
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* power-bar
		* name (inside the health-bar)
		* RaidIcon
		* ReadyCheck
		* RangeCheck
]]
local function createRaid(self)

	local cfg = oUF_PhantomMenaceSettings['raid']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -1, 4)

	self.Power = core.CreatePowerbarOffsettedFG(self, 2*cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	self.Name = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Name:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 1, 4)
	self.Name:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -1, 4)

	-- ***** BORDER *******************************************************************************
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

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** READY CHECK **************************************************************************
	self.ReadyCheck = self.Border:CreateTexture(nil, 'OVERLAY')
	self.ReadyCheck:SetSize(16, 16)
	self.ReadyCheck:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 0, 0)

	-- ***** RANGE ********************************************************************************
	self.Range = {
		['insideAlpha'] = 1.0,
		['outsideAlpha'] = 0.4
	}

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	self.Health.value:Hide()
	if ( oUF_PhantomMenaceSettings.configuration.healerMode ) then
		self.Health.PostUpdate = core.UpdateHealth_raidHealer
	else
		self.Health.PostUpdate = core.UpdateHealth_raid
	end
	self.UNIT_NAME_UPDATE = core.UpdateName
end

--[[ Creates (one) maintank frame
	VOID createMT(FRAME self)

	Used for units:
		* maintanks (header, so maintank1-maintankX)
	Registered as oUF-style:
		* oUF_PhantomMenace_mt
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction and value
		* Threat-highlighting
		* name (inside the health-bar)
		* RaidIcon
		* RangeCheck
]]
local function createMT(self)

	local cfg = oUF_PhantomMenaceSettings['maintank']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -1, 3)

	self.Name = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Name:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 1, 3)
	self.Name:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -1, 3)

	-- ***** BORDER *******************************************************************************
	do
		-- Health Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

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
	end

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** RANGE ********************************************************************************
	self.Range = {
		['insideAlpha'] = 1.0,
		['outsideAlpha'] = 0.4
	}

	-- ***** ENGINES ******************************************************************************
	lib.ColorBorder(self.Border.tex, unpack(oUF_PhantomMenaceSettings.general.color.border))
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	self.Health.value:Hide()
	if ( oUF_PhantomMenaceSettings.configuration.healerMode ) then
		self.Health.PostUpdate = core.UpdateHealth_raidHealer
	else
		self.Health.PostUpdate = core.UpdateHealth_raid
	end
	self.UNIT_NAME_UPDATE = core.UpdateName
end

--[[ Creates (one) grouptarget frame
	VOID createGroupTarget(FRAME self)

	Used for units:
		* grouptarget (1-5)
		* maintanktarget (1-X)
	Registered as oUF-style:
		* oUF_PhantomMenace_grouptarget
	Inherites
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction
		* Threat-highlighting
		* name (inside the health-bar)
		* RaidIcon
]]
local function createGroupTarget(self)

	local cfg = oUF_PhantomMenaceSettings['grouptarget']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Health.value:Hide()

	self.Name = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Name:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 1, 3)
	self.Name:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -1, 3)

	-- ***** BORDER *******************************************************************************
	do
		-- Health Border
		local tex = self.Border:CreateTexture(nil, 'BORDER')
		tex:SetPoint('TOPLEFT', self.Health, 'TOPLEFT', -2, 2)
		tex:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 1)
		tex:SetTexture(settings.tex.solid)
		table.insert(self.Border.tex, tex)

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
	end

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** ENGINES ******************************************************************************
	self.Health.PostUpdate = core.UpdateName_PartyTarget
	self.UNIT_NAME_UPDATE = core.UpdateName
end

--[[ Creates (one) boss frame
	VOID createBoss(FRAME self)

	Used for units:
		* boss1
		* boss2
		* boss3
		* boss4
		* boss5
	Registered as oUF-style:
		* oUF_PhantomMenace_boss
	Inherites:
		core.CreateUnitFrame()

	Features:
		* health-bar with heal prediction (should not be needed, but hey...)
		* Threat-highlighting
		* power-bar
		* name
		* (toggleable) Buffs/Debuffs
		* RaidIcon
]]
local function createBoss(self)

	local cfg = oUF_PhantomMenaceSettings['boss']

	core.CreateUnitFrame(self, cfg.width, cfg.height)

	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -1, 3)

	self.Power = core.CreatePowerbarOffsettedFG(self, 2*cfg.powerWidth, 0, -cfg.powerOffset, -cfg.powerWidth)

	self.Name = lib.CreateFontObject(self.Text, 12, settings.fonts['default'])
	self.Name:SetJustifyH('LEFT')
	self.Name:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 1, 3)
	self.Name:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -40, 3)

	-- ***** BUFFS/DEBUFFS ************************************************************************
	if ( cfg.showAura ) then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetSize(3*cfg.height+2*cfg.auraSpacing, cfg.height)
		self.Buffs:SetPoint('RIGHT', self, 'LEFT', -9, 0)
		self.Buffs.size = cfg.height
		self.Buffs.spacing = cfg.auraSpacing
		self.Buffs.num = 3
		self.Buffs['growth-x'] = 'LEFT'
		self.Buffs.initialAnchor = 'RIGHT'
		self.Buffs.PostCreateIcon = core.PostCreateIcon

		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs.size = floor((cfg.width-6*cfg.auraSpacing)/7)
		self.Debuffs:SetSize((7*(self.Debuffs.size+cfg.auraSpacing))-cfg.auraSpacing, self.Debuffs.size)
		self.Debuffs:SetPoint('BOTTOM', self, 'TOP', 0, cfg.auraSpacing)
		self.Debuffs.spacing = cfg.auraSpacing
		self.Debuffs.num = 7
		self.Debuffs.PostCreateIcon = core.PostCreateIcon
		self.Debuffs.CustomFilter = oUF_BuffFilter_PvEBossDebuffs
	end

	-- ***** BORDER *******************************************************************************
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

	-- ***** RAID ICON ****************************************************************************
	self.RaidIcon = CreateFrame('Frame', nil, self)
	self.RaidIcon.Override = core.UpdateName

	-- ***** ENGINES ******************************************************************************
	self.Health.PostUpdate = core.UpdateHealth_percent
	self.UNIT_NAME_UPDATE = core.UpdateName
end


-- ************************************************************************************************
PhantomMenace:RegisterEvent('ADDON_LOADED')
PhantomMenace:SetScript('OnEvent', function(self, event, addon)
	if ( addon ~= ADDON_NAME ) then return end

--	if ( not oUF_PhantomMenaceSettings ) then
--		lib.debugging('setting up SavedVariables')
		oUF_PhantomMenaceSettings = settings.init
		oUF_PhantomMenaceSettings.colors = settings.colors
		oUF_PhantomMenaceSettings.SpecialAurasFocus = settings.SpecialAurasFocus
		oUF_PhantomMenaceSettings.SpecialAurasParty = settings.SpecialAurasParty
--	end

	oUF:RegisterStyle('oUF_PhantomMenace_player', createPlayer)
	oUF:RegisterStyle('oUF_PhantomMenace_castbar', createPlayerCastbar)
	oUF:RegisterStyle('oUF_PhantomMenace_target', createTarget)
	oUF:RegisterStyle('oUF_PhantomMenace_focus', createFocus)
	oUF:RegisterStyle('oUF_PhantomMenace_pet', createPet)
	oUF:RegisterStyle('oUF_PhantomMenace_party', createParty)
	oUF:RegisterStyle('oUF_PhantomMenace_raid', createRaid)
	oUF:RegisterStyle('oUF_PhantomMenace_mt', createMT)
	oUF:RegisterStyle('oUF_PhantomMenace_targettarget', createTargetTarget)
	oUF:RegisterStyle('oUF_PhantomMenace_grouptarget', createGroupTarget)
	oUF:RegisterStyle('oUF_PhantomMenace_boss', createBoss)

	oUF:SetActiveStyle('oUF_PhantomMenace_player')
	oUF:Spawn('player', 'oUF_PhantomMenace_player'):SetPoint('RIGHT', UIParent, 'CENTER', -100, -200)
	oUF:SetActiveStyle('oUF_PhantomMenace_castbar')
	oUF:Spawn('player', 'oUF_PhantomMenace_castbar'):SetPoint('CENTER', UIParent, 'CENTER', 0, -230)

	oUF:SetActiveStyle('oUF_PhantomMenace_pet')
	oUF:Spawn('pet', 'oUF_PhantomMenace_pet'):SetPoint('RIGHT', 'oUF_PhantomMenace_player', 'LEFT', -15, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_target')
	oUF:Spawn('target', 'oUF_PhantomMenace_target'):SetPoint('LEFT', UIParent, 'CENTER', 100, -200)

	oUF:SetActiveStyle('oUF_PhantomMenace_focus')
	oUF:Spawn('focus', 'oUF_PhantomMenace_focus'):SetPoint('LEFT', UIParent, 'CENTER', 300, 0)	

	oUF:SetActiveStyle('oUF_PhantomMenace_targettarget')
	oUF:Spawn('targettarget', 'oUF_PhantomMenace_targettarget'):SetPoint('LEFT', 'oUF_PhantomMenace_target', 'RIGHT', 15, 0)
	oUF:Spawn('focustarget', 'oUF_PhantomMenace_focustarget'):SetPoint('LEFT', 'oUF_PhantomMenace_focus', 'RIGHT', 10, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_party')
	oUF:SpawnHeader('oUF_PhantomMenace_party', nil, 
		'custom [@raid6,exists] hide; [@raid1,exists] show; [group:party,nogroup:raid] show; hide',
		'showPlayer', oUF_PhantomMenaceSettings.configuration.playerInGroup,
		'showParty', true,
		'showSolo', false,
		'showRaid', false,
		'groupBy', 'ROLE',
		'groupingOrder', 'TANK,HEAL,DAMAGE',
		'sortMethod', 'NAME',
		'point', 'BOTTOM',
		'maxColumns', 1,
		'unitsPerColumn', 5,
		'columnSpacing', 0, 
		'xOffset', oUF_PhantomMenaceSettings.raid.xOffset,
		'yOffset', oUF_PhantomMenaceSettings.raid.yOffset,
		'columnAnchorPoint', 'BOTTOM',
		'oUF-initialConfigFunction', format([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]], oUF_PhantomMenaceSettings.raid.width, oUF_PhantomMenaceSettings.raid.height)
	):SetPoint('LEFT', UIParent, 'LEFT', 100, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_raid')
	-- oUF:SpawnHeader('oUF_PhantomMenace_raid', nil, 'solo,raid',
	oUF:SpawnHeader('oUF_PhantomMenace_raid', nil, 
		'custom [@raid6,exists] show; hide',
		'showPlayer', true,
		'showParty', false,
		'showSolo', true,
		'showRaid', true,
		'groupFilter', '1,2,3,4,5,6,7,8',
		'groupBy', 'GROUP',
		'groupingOrder', '1,2,3,4,5,6,7,8',
		'sortMethod', 'INDEX',
		'point', 'LEFT',
		'maxColumns', 5,
		'unitsPerColumn', 5,
		'columnSpacing', oUF_PhantomMenaceSettings.raid.yOffset, 
		'xOffset', oUF_PhantomMenaceSettings.raid.xOffset,
		'yOffset', 0,
		'columnAnchorPoint', 'BOTTOM',
		'oUF-initialConfigFunction', format([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]], oUF_PhantomMenaceSettings.raid.width, oUF_PhantomMenaceSettings.raid.height)
	):SetPoint('LEFT', UIParent, 'LEFT', 100, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_mt')
	oUF:SpawnHeader('oUF_PhantomMenace_mt', nil, 
		'raid', 
		'showRaid', true, 
		'yOffset', 8, 
		'groupFilter', 'MAINTANK',
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', format([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]], oUF_PhantomMenaceSettings.maintank.width, oUF_PhantomMenaceSettings.maintank.height)
	):SetPoint('TOPLEFT', UIParent, 'LEFT', 20, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_grouptarget')
	oUF:SpawnHeader('oUF_PhantomMenace_partytarget', nil, 
		'custom [@raid6,exists] hide; [@raid1,exists] show; [group:party,nogroup:raid] show; hide',
		'showPlayer', oUF_PhantomMenaceSettings.configuration.playerInGroup,
		'showParty', true,
		'showSolo', false,
		'showRaid', false,
		'groupBy', 'ROLE',
		'groupingOrder', 'TANK,HEAL,DAMAGE',
		'sortMethod', 'NAME',
		'point', 'BOTTOM',
		'maxColumns', 1,
		'unitsPerColumn', 5,
		'columnSpacing', 0, 
		'xOffset', oUF_PhantomMenaceSettings.raid.xOffset,
		'yOffset', oUF_PhantomMenaceSettings.raid.yOffset,
		'columnAnchorPoint', 'BOTTOM',
		'oUF-initialConfigFunction', format([[
			self:SetWidth(%d)
			self:SetHeight(%d)
			self:SetAttribute('unitsuffix', 'target')
		]], oUF_PhantomMenaceSettings.grouptarget.width, oUF_PhantomMenaceSettings.grouptarget.height)
	):SetPoint('LEFT', 'oUF_PhantomMenace_party', 'RIGHT', 10, 0)

	oUF:SpawnHeader('oUF_PhantomMenace_mttarget', nil, 
		'raid', 
		'showRaid', true, 
		'yOffset', 8, 
		'groupFilter', 'MAINTANK',
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', format([[
			self:SetWidth(%d)
			self:SetHeight(%d)
			self:SetAttribute('unitsuffix', 'target')
		]], oUF_PhantomMenaceSettings.grouptarget.width, oUF_PhantomMenaceSettings.grouptarget.height)
	):SetPoint('TOPLEFT', 'oUF_PhantomMenace_mt', 'TOPRIGHT', 10, 0)

	oUF:SetActiveStyle('oUF_PhantomMenace_boss')
	oUF:Spawn('boss1', 'oUF_PhantomMenace_boss1'):SetPoint('CENTER', UIParent, 'CENTER', 300, 0)
	oUF:Spawn('boss2', 'oUF_PhantomMenace_boss2'):SetPoint('BOTTOM', 'oUF_PhantomMenace_boss1', 'TOP', 0, 40)
	oUF:Spawn('boss3', 'oUF_PhantomMenace_boss3'):SetPoint('BOTTOM', 'oUF_PhantomMenace_boss2', 'TOP', 0, 40)
	oUF:Spawn('boss4', 'oUF_PhantomMenace_boss4'):SetPoint('BOTTOM', 'oUF_PhantomMenace_boss3', 'TOP', 0, 40)
	oUF:Spawn('boss5', 'oUF_PhantomMenace_boss5'):SetPoint('BOTTOM', 'oUF_PhantomMenace_boss4', 'TOP', 0, 40)

	--[[
		Remove all focus stuff from menus
	]]
	do -- fix SET_FOCUS & CLEAR_FOCUS errors
		for k,v in pairs(UnitPopupMenus) do
			for x,y in pairs(UnitPopupMenus[k]) do
				if y == "SET_FOCUS" then
					table.remove(UnitPopupMenus[k],x)
				elseif y == "CLEAR_FOCUS" then
					table.remove(UnitPopupMenus[k],x)
				end
			end
		end
	end
end)