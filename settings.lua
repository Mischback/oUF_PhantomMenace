--[[ SETTINGS
	Contains the addons settings
]]

local ADDON_NAME, ns = ...

local settings = {}
-- *********************************************************************************

settings.fonts = {
	[1] = [[Interface\AddOns\oUF_PredatorPlay\media\BIRTH_OF_A_HERO.ttf]],
	[2] = [[Interface\AddOns\oUF_PredatorPlay\media\Catenary-Stamp.ttf]],
	[3] = [[Interface\AddOns\oUF_PredatorPlay\media\EuropeUnderground_worn.ttf]],
	-- [1] = [[Interface\AddOns\oUF_PredatorPlay\media]],
}

settings.tex = {
	['bar'] = [[Interface\AddOns\oUF_PredatorPlay\media\bar.tga]],
	['solid'] = [[Interface\AddOns\oUF_PredatorPlay\media\solid.tga]],
	['gloss'] = [[Interface\AddOns\oUF_PredatorPlay\media\gloss.tga]],
	['overlay'] = [[Interface\AddOns\oUF_PredatorPlay\media\overlay.tga]],
}

settings.colors = setmetatable({
		class = setmetatable({
		},
		{ __index = oUF.colors.class }),

		runes = setmetatable({
			{0.77, 0.12, 0.23},
			{0, 0.5, 0},
			{0, 0.76, 1},
			{0.78, 0, 0.78}
		},
		{ __index = oUF.colors.runes })
	},
	{ __index = oUF.colors })

settings.init = {
	['general'] = {
		['healerMode'] = false,
		['color'] = {
			['background'] = { 0, 0, 0, 1 },
			['border'] = { 1, 1, 1, 0.2 },
			-- ['border'] = { 1, 0, 0, 1 },
			['healthBarFG'] = { 0.05, 0.05, 0.05 },
			['healthBarBG'] = { 0.25, 0.25, 0.25 },
			['healthBarMyHeal'] = { 0.3, 0.6, 0.3 },
			['healthBarHeal'] = { 0.8, 0.7, 0.3 },
			['healthValue'] = 'DDDDDD',
			['healthDeficit'] = 'CC0000',
			['name'] = 'DDDDDD',
			['nameBG'] = { 0.1, 0.1, 0.1 },
			['castbar'] = { 0.86, 0.5, 0, 1 },
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
		['glossIntensity'] = 0.7
	},
	['player'] = {
		['width'] = 180,
		['height'] = 24,
		['powerWidth'] = 6,
		['powerOffset'] = 40,
		['specialPowerHeight'] = 3,
		['specialPowerOffset'] = 18,
		['auraSize'] = 18,
		['auraSpacing'] = 9,
	},
	['target'] = {
		['width'] = 180,
		['height'] = 24,
		['powerWidth'] = 6,
		['powerOffset'] = 40,
		['nameplateOffset'] = 18,
		['auraSize'] = 18,
		['auraSpacing'] = 9,
	},
	['focus'] = {
		['width'] = 120,
		['height'] = 24,
		['powerWidth'] = 5,
		['powerOffset'] = 25,
		['nameplateOffset'] = 12,
		['auraSize'] = 14,
		['auraSpacing'] = 9,
	},
	['pet'] = {
		['width'] = 120,
		['height'] = 24,
		['powerWidth'] = 3,
		['powerOffset'] = 45,
		['nameplateOffset'] = 12,
		['auraSize'] = 14,
		['auraSpacing'] = 9,
	},
	['targettarget'] = {
		['width'] = 80,
		['height'] = 24,
		['nameplateOffset'] = 10,
	}
}


-- *********************************************************************************

settings.playerClass = select(2, UnitClass('player'))

-- *********************************************************************************
ns.settings = settings