<<<<<<< HEAD
--[[ SETTINGS
	Contains the addons settings
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
		-- Irreführung!
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
		['playerInGroup'] = true,
		['strings'] = {
			['off'] = 'off',
			['dead'] = 'dead',
		},
	},
	['general'] = {
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
		['glossIntensity'] = 0.7
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
	},
	['party'] = {
		['width'] = 100,
		['height'] = 20,
		['powerWidth'] = 3,
		['powerOffset'] = 35,
		['xOffset'] = 8,
		['yOffset'] = 12,
		['auraSpacing'] = 9,
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
local settings = {}

--[[ SETTINGS
	We'll set some basic settings here, which are used throughout the layout.
	Furthermore you can find the default-values of the SavedVars in here
]]

	--[[ 
	
	]]
	settings.src = {
		['unitNames'] = {
			['UIParent'] = UIParent,
			['player'] = 'oUF_PhantomMenace_player',
			['pet'] = 'oUF_PhantomMenace_pet',
			['target'] = 'oUF_PhantomMenace_target',
			['focus'] = 'oUF_PhantomMenace_focus',
			['targettarget'] = 'oUF_PhantomMenace_targettarget',
			['focustarget'] = 'oUF_PhantomMenace_focustarget',
			['party'] = 'oUF_PhantomMenace_party',
			['raid'] = 'oUF_PhantomMenace_raid',
			['maintank'] = 'oUF_PredatorSimple_MT',
			['boss'] = 'oUF_PhantomMenace_boss1',
		},
		['fonts'] = {
			['value'] = [[Interface\AddOns\oUF_PhantomMenace\media\accid__.ttf]],
			['name'] = [[Interface\AddOns\oUF_PhantomMenace\media\Cartoon_Regular.ttf]],
			-- ['name'] = [[Interface\AddOns\oUF_PhantomMenace\media\cityburn.ttf]],
		},
		['textures'] = {
			['bar'] = [[Interface\AddOns\oUF_PhantomMenace\media\bar]],
			['solid'] = [[Interface\AddOns\oUF_PhantomMenace\media\solid]],
			['overlay'] = [[Interface\AddOns\oUF_PhantomMenace\media\overlay]],
			['border_player_standard'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_player_standard]],
			['border_player_bar'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_player_bar]],
			['border_player_3'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_player_3]],
			['border_player_4'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_player_4]],
			['border_player_6'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_player_6]],
			['border_target'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_target]],
			['border_targettarget'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_targettarget]],
			['border_focus'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_focus]],
			['border_mt'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_mt]],
			['border_raid'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_raid]],
			['border_generic'] = [[Interface\AddOns\oUF_PhantomMenace\media\border_generic]],
		},
		['borderColor'] = { 0.3, 0.3, 0.3 },
		['threatColors'] = {
			[0] = { 0, 0, 0, 0 },
			[1] = { 0.8, 0.8, 0, 0.5 },
			[2] = { 1, 0.6, 0, 0.5 },
			[3] = { 1, 0, 0, 0.5 },
		},
		['bar'] = { 0.25, 0.25, 0.25 },
		['bar_bg'] = { 0.6, 0.6, 0.6 },
		['default_font'] = { 0.8, 0.8, 0.8 },
		['outOfRangeAlpha'] = 0.7,
		['playerUnits'] = {
			player = true,
			pet = true,
			vehicle = true,
		},
		['debuffColors'] = {
			['Magic'] = { 0.1, 0.5, 1, 0.5 }, 
			['Curse'] = { 0.6, 0, 1, 0.5 },
			['Disease'] = { 1, 0.7, 0, 0.5 },
			['Poison'] = { 0, 1, 0, 0.5 },
		},
		['dispelAbilities'] = {
			['PRIEST'] = { ['Magic'] = true, ['Disease'] = true },
			['SHAMAN'] = { ['Magic'] = false, ['Curse'] = true },
			['PALADIN'] = { ['Magic'] = false, ['Poison'] = true, ['Disease'] = true },
			['DRUID'] = { ['Magic'] = false, ['Curse'] = true, ['Poison'] = true },
			['MAGE'] = { ['Curse'] = true },
		},
		['improvedDispelAbility'] = {
			['SHAMAN'] = 77130,		-- "Improved Clease Spirit"
			['PALADIN'] = 53551,	-- "Sacred Cleansing"
			['DRUID'] = 88423,		-- "Natures's Cure"
		},
		['partyStyles'] = {
			['big'] = 'big',
			['raid'] = 'raid'
		},
		['partyLayouts'] = {
			['2x2'] = '2x2', 		-- 2 columns, 2 rows
			['1x4'] = '1x4', 		-- 1 column, 4 rows
			['4x1'] = '4x1'			-- 4 columns, 1 row
		},
		['raidLayouts'] = {
			-- this references the number of rows of that layout, number of columns is calculated
			['2'] = '2', 	-- 2 rows and either 5 columns (raid10), 7 columns (raid15, no player), 12 columns (raid25) or 20 columns (raid40)
			['3'] = '3',	-- 3 rows and either 3 columns (raid10, no player), 5 columns (raid15) or 8 columns (raid25, no player) or 13 columns (raid 40, no player)
			['5'] = '5', 	-- 5 rows and either 2 columns (raid10), 3 columns (raid15), 5 columns (raid25) or 8 columns (raid40) --> basically the default!
			['10'] = '10'	-- 10 rows and 1 column (raid10 only)
		}
	}


	--[[
	
	]]
	settings.options = {
		['healerMode'] = false,
		['debuffHighlight'] = false,
		['aggroHighlight'] = true,
		['castbar'] = {
			['width'] = 300, 
			['height'] = 25, 
			['fontSize'] = 18,
		},
		['partyStyle'] = 'big',
		['partyLayout'] = '2x2',
		['raidLayout'] = '5',
		['playerBuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {
				93795, 	-- Champion von Sturmwind
				93821, 	-- Champion von Gnomeregan
				93806, 	-- Champion von Darnassus
				93811, 	-- Champion der Exodar
				93816, 	-- Champion von Gilneas
				93825, 	-- Champion von Orgrimmar
				93827, 	-- Champion der Dunkelspeere
				93830, 	-- Champion des Bilgewasserkartells
				93347, 	-- Champion von Therazane
				93368, 	-- Champion des Wildhammerklans
				93337, 	-- Champion von Ramkahen
				93339, 	-- Champion des Irdenen Rings
				93341, 	-- Champion der Wächter des Hyjal
			},
		},
		['playerDebuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {},
		},
		['friendsBuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {
				93795, 	-- Champion von Sturmwind
				93821, 	-- Champion von Gnomeregan
				93806, 	-- Champion von Darnassus
				93811, 	-- Champion der Exodar
				93816, 	-- Champion von Gilneas
				93825, 	-- Champion von Orgrimmar
				93827, 	-- Champion der Dunkelspeere
				93830, 	-- Champion des Bilgewasserkartells
				93347, 	-- Champion von Therazane
				93368, 	-- Champion des Wildhammerklans
				93337, 	-- Champion von Ramkahen
				93339, 	-- Champion des Irdenen Rings
				93341, 	-- Champion der Wächter des Hyjal
			},
		},
		['friendsDebuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {},
		},
		['enemyBuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {
				93795, 	-- Champion von Sturmwind
				93821, 	-- Champion von Gnomeregan
				93806, 	-- Champion von Darnassus
				93811, 	-- Champion der Exodar
				93816, 	-- Champion von Gilneas
				93825, 	-- Champion von Orgrimmar
				93827, 	-- Champion der Dunkelspeere
				93830, 	-- Champion des Bilgewasserkartells
				93347, 	-- Champion von Therazane
				93368, 	-- Champion des Wildhammerklans
				93337, 	-- Champion von Ramkahen
				93339, 	-- Champion des Irdenen Rings
				93341, 	-- Champion der Wächter des Hyjal
			},
		},
		['enemyDebuffs'] = {
			['mode'] = 'blacklist',
			['list'] = {},
		},
		['strings'] = {
			['dead'] = 'dead', 
			['ghost'] = 'ghost', 
			['offline'] = 'off', 
		},
		['showPlayerPower'] = true,
		['showTargetPower'] = true,
	}


	--[[
	
	]]
	settings.positions = {
		['player'] = {
			['x'] = -100,
			['y'] = -250,
			['anchorPoint'] = 'TOPRIGHT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['pet'] = {
			['x'] = -25,
			['y'] = 0,
			['anchorPoint'] = 'TOPRIGHT',
			['anchorToPoint'] = 'TOPLEFT',
			['anchorToFrame'] = 'oUF_PhantomMenace_player',
		},
		['target'] = {
			['x'] = 100,
			['y'] = -250,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['focus'] = {
			['x'] = 330,
			['y'] = -145,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['targettarget'] = {
			['x'] = 25,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'TOPRIGHT',
			['anchorToFrame'] = 'oUF_PhantomMenace_target',
		},
		['focustarget'] = {
			['x'] = 15,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'TOPRIGHT',
			['anchorToFrame'] = 'oUF_PhantomMenace_focus',
		},
		['party'] = {
			['x'] = 50,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'LEFT',
			['anchorToFrame'] = 'UIParent',
		},
		['party_healer'] = {
			['x'] = 250,
			['y'] = 100,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['raid'] = {
			['x'] = 50,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'LEFT',
			['anchorToFrame'] = 'UIParent',
		},
		['raid_healer'] = {
			['x'] = 250,
			['y'] = 50,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['maintank'] = {
			['x'] = 400,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['maintank_healer'] = {
			['x'] = 300,
			['y'] = 150,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'CENTER',
			['anchorToFrame'] = 'UIParent',
		},
		['boss'] = {
			['x'] = -200,
			['y'] = 0,
			['anchorPoint'] = 'TOPLEFT',
			['anchorToPoint'] = 'RIGHT',
			['anchorToFrame'] = 'UIParent',
		},
	}

-- *****************************************************
ns.settings = settings									-- handover of the settings to the namespace
>>>>>>> 5cdeb3ca4ce54e72e6a343f53c244f640f1cb02c
