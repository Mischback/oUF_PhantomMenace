--[[ SETTINGS
	@file:			settings.lua
	@file-version:	1.1
	@project:		oUF_PhantomMenace
	@project-url:	https://github.com/Mischback/oUF_PhantomMenace
	@author:		Mischback

	@project-description:
		This is a layout for the incredibly awesome oUF by haste. You can find this addon 
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
		This file (layout.lua) contains all settings, including the defaults for the saved
		variables.
]]

local ADDON_NAME, ns = ...

local settings = {}
-- ************************************************************************************************

settings.fonts = {
	['default'] = [[Interface\AddOns\oUF_PhantomMenace\media\Catenary-Stamp.ttf]],
}

settings.tex = {
	['bar'] = [[Interface\AddOns\oUF_PhantomMenace\media\bar.tga]],
	['solid'] = [[Interface\AddOns\oUF_PhantomMenace\media\solid.tga]],
	['gloss'] = [[Interface\AddOns\oUF_PhantomMenace\media\gloss.tga]],
	['overlay'] = [[Interface\AddOns\oUF_PhantomMenace\media\overlay.tga]],
	['role'] = {
		['tank'] = [[Interface\AddOns\oUF_PhantomMenace\media\role_tank.tga]],
		['heal'] = [[Interface\AddOns\oUF_PhantomMenace\media\role_heal.tga]],
		['damage'] = [[Interface\AddOns\oUF_PhantomMenace\media\role_dd.tga]],
	}
}

settings.colors = setmetatable({
		class = setmetatable({
		},
		{ __index = oUF.colors.class }),

		runes = setmetatable({
			{0.77, 0.12, 0.23},		-- Blood
			{0, 0.5, 0},			-- Frost
			{0, 0.76, 1},			-- Unholy
			{0.78, 0, 0.78}			-- Death
		},
		{ __index = oUF.colors.runes })
	},
	{ __index = oUF.colors })

settings.SpecialAurasFocus = {
	-- Mage
	[118] = true, 		-- Verwandlung (Schaf)
	[28272] = true, 	-- Verwandlung: Schwein
	-- Rogue
	[408] = true, 		-- Nierenhieb
	-- Hunter
	[3355] = true, 		-- Eiskältefalle
	[34477] = true, 	-- Irreführung!
	-- Paladin
	[20066] = true, 	-- Buße
	[53563] = true, 	-- Flamme des Glaubens
	-- Priest
	[6788] = true, 		-- Geschwächte Seele
	[139] = true, 		-- Erneuerung
	[8362] = true, 		-- Erneuerung
	[11640] = true, 	-- Erneuerung
	[25058] = true, 	-- Erneuerung
	[34423] = true, 	-- Erneuerung
	[57777] = true, 	-- Erneuerung
	-- Shaman
	[974] = true, 		-- Erdschild
	[57802] = true, 	-- Erdschild
	[69926] = true, 	-- Erdschild
	[79927] = true, 	-- Erdschild
}

settings.SpecialAurasParty = {
	-- Mage
		-- Magie fokussieren?
	-- Rogue
		-- Schurkenhandel!
	-- Hunter
	[34477] = true, 	-- Irreführung!
	-- Paladin
	[53563] = true, 	-- Flamme des Glaubens
	-- Priest
	[6788] = true, 		-- Geschwächte Seele
	-- Shaman
	[974] = true, 		-- Erdschild
	[57802] = true, 	-- Erdschild
	[69926] = true, 	-- Erdschild
	[79927] = true, 	-- Erdschild
	-- Warrior
	[50720] = true, 	-- Wachsamkeit
}

settings.init = {
	['configuration'] = {
		['healerMode'] = true,
		['highlightDebuffs'] = true,			-- new in 1.1!
		['showAllDebuffs'] = true,				-- new in 1.1!
		['playerInGroup'] = true,
		['hideRaidManager'] = false, 			-- new in 1.1!
		['showUnit'] = {						-- new in 1.1!
			['player'] = true,					-- new in 1.1!
			['playerCastbar'] = true,			-- new in 1.1!
			['playerPet'] = true,				-- new in 1.1!
			['target'] = true,					-- new in 1.1!
			['focus'] = true,					-- new in 1.1!
			['targettarget'] = true,			-- new in 1.1!
			['focustarget'] = true,				-- new in 1.1!
			['party'] = true,					-- new in 1.1!
			['raid'] = true,					-- new in 1.1!
			['maintank'] = true,				-- new in 1.1!
			['partytarget'] = true,				-- new in 1.1!
			['mtTarget'] = true,				-- new in 1.1!
			['boss'] = true,					-- new in 1.1!
		},
		['strings'] = {
			['off'] = 'off',
			['dead'] = 'dead',
		},
	},
	['general'] = {
		['color'] = {
			['background'] = { 0, 0, 0, 1 },
			['border'] = { 1, 1, 1, 0.2 },
			['healthBarFG'] = { 0.05, 0.05, 0.05 },
			['healthBarBG'] = { 0.25, 0.25, 0.25 },
			['healthBarMyHeal'] = { 0.3, 0.6, 0.3 },
			['healthBarHeal'] = { 0.8, 0.7, 0.3 },
			['healthValue'] = 'DDDDDD',
			['healthDeficit'] = 'CC0000',
			['name'] = 'DDDDDD',
			['nameBG'] = { 0.1, 0.1, 0.1 },
			['castbar'] = { 0.86, 0.5, 0, 1 },
			['castbarNoInterrupt'] = { 1, 0, 0, 1 },
			['vengeance'] = { 1, 1, 1, 1 },
			['threat'] = {
				[1] = {0.8, 0.8, 0, 0.9},
				[2] = {1, 0.6, 0, 0.7},
				[3] = {1, 0, 0, 0.4},
			},
		},
		['holyshardtotems'] = {
			['width'] = 20, 
			['spacing'] = 9,
			['WARLOCK'] = { 1, 0, 1 },
			['PALADIN'] = { 1, 1, 0 }
		},
		['runes'] = {
			['spacing'] = 9,
		},
		['glossIntensity'] = 0.7, 
		['debuffHighlightIntensity'] = 0.7		-- new in 1.1!
	},
	['playerCastbar'] = {
		['width'] = 250,
		['height'] = 18,
	},
	['player'] = {
		['width'] = 180,
		['height'] = 24,
		['powerWidth'] = 6,
		['powerOffset'] = 40,
		['specialPowerHeight'] = 3,
		['specialPowerOffset'] = 18,
		['showPowerValue'] = true,
		['showAura'] = true,
		['auraSize'] = 18,
		['auraSpacing'] = 9,
		['showSpecialPower'] = true,
		['showVengeance'] = true,
	},
	['target'] = {
		['width'] = 180,
		['height'] = 24,
		['powerWidth'] = 6,
		['powerOffset'] = 40,
		['nameplateOffset'] = 18,
		['showPowerValue'] = true,
		['showAura'] = true,
		['auraSize'] = 18,
		['auraSpacing'] = 9,
	},
	['focus'] = {
		['width'] = 120,
		['height'] = 24,
		['powerWidth'] = 5,
		['powerOffset'] = 25,
		['nameplateOffset'] = 12,
		['showAura'] = true,
		['auraSize'] = 14,
		['auraSpacing'] = 9,
	},
	['pet'] = {
		['width'] = 120,
		['height'] = 24,
		['powerWidth'] = 3,
		['powerOffset'] = 45,
		['nameplateOffset'] = 12,
		['showAura'] = true,
		['auraSize'] = 14,
		['auraSpacing'] = 9,
	},
	['targettarget'] = {
		['width'] = 80,
		['height'] = 24,
		['nameplateOffset'] = 10,
	},
	['party'] = {
		['width'] = 100,
		['height'] = 20,
		['powerWidth'] = 3,
		['powerOffset'] = 35,
		['xOffset'] = 8,
		['yOffset'] = 12,
		['showAura'] = true,
		['auraSpacing'] = 9,
		['showLFD'] = true,
	},
	['raid'] = {
		['width'] = 80,
		['height'] = 20,
		['powerWidth'] = 3,
		['powerOffset'] = 25,
		['xOffset'] = 8,
		['yOffset'] = 12,
	},
	['maintank'] = {
		['width'] = 100,
		['height'] = 20,
	},
	['boss'] = {
		['width'] = 150, 
		['height'] = 20, 
		['powerWidth'] = 3,
		['powerOffset'] = 25,
		['buffSize'] = 18,
		['showAura'] = true,
		['auraSpacing'] = 9,
	},
	['grouptarget'] = {
		['width'] = 80,
		['height'] = 20,
	},
}


-- ************************************************************************************************

settings.playerClass = select(2, UnitClass('player'))

-- ************************************************************************************************
ns.settings = settings