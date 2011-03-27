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
		['fonts'] = {
			['value'] = [[Interface\AddOns\oUF_PhantomMenace\media\accid__.ttf]],
			['name'] = [[Interface\AddOns\oUF_PhantomMenace\media\cityburn.ttf]],
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
		['partyLayout'] = '2x2',
		['raidLayout'] = 'columns',
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
			['y'] = 100,
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