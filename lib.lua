--[[ oUF_PhantomMenace
	This is a layout for the incredibly awesome oUF by haste.
	
	PLEASE NOTE that this layout comes with no warranty and "as it is". It was created to fit my very own
	needs, so please understand, that I'll not put any effort in "fixing" something for you, "adding" something
	for you or make any changes to this.
	Anyway, when you read this, you've already downloaded my layout, so please, feel free to modify it to your
	own needs.
]]

local ADDON_NAME, ns = ...								-- get the addons namespace to exchange functions between core and layout
local lib = {}

local settings = ns.settings							-- get the settings

_, lib.playerclass = UnitClass('player')				-- the players class (this is used throughout the whole addon)

lib.dispelAbility = settings.src.dispelAbilities[lib.playerclass] or nil


	--[[ Debugging to ChatFrame
		VOID debugging(STRING text)
	]]
	lib.debugging = function(text)
		DEFAULT_CHAT_FRAME:AddMessage('|cffffd700oUF_PhantomMenace:|r |cffeeeeee'..text..'|r')
	end


	--[[ When nothing is to do, basically to overwrite certain functions
		VOID noop()
	]]
	lib.noop = function()
		return
	end


	--[[ Is a value in a table?
		BOOL in_array(MIXED e, TABLE t)
	]]
	lib.in_array = function(e, t)
		-- lib.debugging('entering in_array() with spellID='..e)
		for _,v in pairs(t) do
			if ( v == e ) then
				-- lib.debugging('in_array(): v == e: '..v..'/'..e)
				return true
			end
		end
		return false
	end


	--[[ Updates the Tooltip on Auras
		VOID AuraUpdateTooltip(FRAME self)
	]]
	local AuraUpdateTooltip = function(self)
		GameTooltip:SetUnitAura(self.parent:GetParent().unit, self:GetID(), self.filter)
	end


	--[[ Shows the Toolttip on Auras
		VOID AuraTTOnEnter(FRAME self)
	]]
	local AuraTTOnEnter = function(self)
		if(not self:IsVisible()) then return end

		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		self:UpdateTooltip()
	end


	--[[ Hides the Tooltip on Auras
		VOID AuraTTOnLeave()
	]]
	local AuraTTOnLeave = function()
		GameTooltip:Hide()
	end


	--[[ Shortening the values displayed on the Health- and Power-Bars
		STRING Shorten(INT value)
	]]
	lib.Shorten = function(value)
		if value >= 1e7 then
			return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
		elseif value >= 1e6 then
			return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
		elseif value >= 1e5 then
			return ('%.0fk'):format(value / 1e3)
		elseif value >= 1e3 then
			return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
		else
			return value
		end
	end


    --[[ Provides the standard UF-menu
		VOID Menu(FRAME self)
	]]
	lib.Menu = function(self)
        local unit = self.unit:sub(1, -2)
    	local cunit = self.unit:gsub('(.)', string.upper, 1)

    	if(unit == 'party' or unit == 'partypet') then
            ToggleDropDownMenu(1, nil, _G['PartyMemberFrame'..self.id..'DropDown'], 'cursor', 0, 0)
        elseif(_G[cunit..'FrameDropDown']) then
            ToggleDropDownMenu(1, nil, _G[cunit..'FrameDropDown'], 'cursor', 0, 0)
        end
    end


	--[[ Returns the type of a given debuff, if the player has the ability to remove it
		STRING GetDebuff(UNIT unit)
	]]
	lib.GetDebuff = function(unit)
		if not UnitCanAssist('player', unit) then return nil end
		local i, debuffType = 1, nil
		while true do
			local name, _, _, _, debuffType = UnitAura(unit, i, 'HARMFUL')
			--if not name then break end
			if not debuffType then break end
			if ( lib.dispelAbility[debuffType] ) then
				return debuffType
			end
			i = i + 1
		end
	end


	--[[ Updates the (local) table of available debuffing capabilities.
		VOID CheckSpec()
	]]
	lib.CheckSpec = function()
		-- if ( event == 'CHARACTER_POINTS_CHANGED' and levels > 0 ) then return end
		-- lib.debugging('CheckSpec')

		if ( settings.src.improvedDispelAbility[lib.playerclass] ) then
			local talent, tab, name, rank, wanted
			wanted = GetSpellInfo(settings.src.improvedDispelAbility[lib.playerclass])
			for tab = 1, GetNumTalentTabs() do
				for talent = 1, GetNumTalents(tab) do
					name, _, _, _, rank = GetTalentInfo(tab, talent)
					if ( name and ( name == wanted) ) then
						if ( rank and (rank > 0) ) then
							-- lib.debugging('can cure magic')
							lib.dispelAbility['magic'] = true
						else
							-- lib.debugging('can\'t cure magic')
							lib.dispelAbility['magic'] = false
						end
					end
				end
			end
		end
	end


	--[[ Creates a font-object
		FONTOBJECT CreateFontObject(FRAME parent, INT size, STRING font)
		Creates a font-object with the given 'parent' and 'size', using 'font'. Shadow and Outline are constant throughout the layout.
	]]
    lib.CreateFontObject = function(parent, size, font)
    	local fo = parent:CreateFontString(nil, 'OVERLAY')
    	fo:SetFont(font, size, 'OUTLINE')
    	fo:SetJustifyH('LEFT')
    	fo:SetShadowColor(0,0,0)
    	fo:SetShadowOffset(1, -1)
    	return fo
    end


	--[[ Creates a single buff-/debuff-icon
		FRAME CreateAuraIcon(FRAME icons, INT index)
	]]
	lib.CreateAuraIcon = function(icons, index)

		local button = CreateFrame('Frame', nil, icons)
		button:SetWidth(icons.size or 16)
		button:SetHeight(icons.size or 16)

		local icon = button:CreateTexture(nil, 'BACKGROUND')
		icon:SetPoint('TOPLEFT', button, 'TOPLEFT', 2, -2)
		icon:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', -2, 2)
		button.icon = icon

		local count = button:CreateFontString(nil, 'OVERLAY')
		count:SetFontObject(NumberFontNormal)
		count:SetPoint('TOPRIGHT', button, 'TOPRIGHT', 2, 1)
		button.count = count

		local overlay = button:CreateTexture(nil, 'OVERLAY')
		button.overlay = overlay

		local cd = CreateFrame('Cooldown', nil, button)
		cd:SetFrameLevel(0)
		cd:SetAllPoints(icon)
		button.cd = cd

		button:SetBackdrop( {
			bgFile = nil, 
			edgeFile = settings.src.textures.border_generic,
			tile = false, 
			edgeSize = 8,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )
		-- button:SetBackdropBorderColor(0.7, 0.7, 0.7)

		button.UpdateTooltip = AuraUpdateTooltip
		button:SetScript("OnEnter", AuraTTOnEnter)
		button:SetScript("OnLeave", AuraTTOnLeave)

		table.insert(icons, button)

		button.parent = icons

		return button
	end


	--[[ Collects an aura to the SavedVars
		VOID collectAura(INT id, STRING name)
	]]
	lib.collectAura = function(id, name)
		PhantomMenaceAuraList[id] = name
	end


	--[[ Providing blacklisting. Returns "false" if the ID is found.
		BOOL FilterBlacklist(INT spellID, TABLE filterSRC)
	]]
	lib.FilterBlacklist = function(spellID, list)
		if ( #list ~= 0 ) then
			if ( lib.in_array(spellID, list) ) then
				return false
			end
		end
		return true
	end


	--[[ Providing whitelisting. Returns "true" if the ID is found.
		BOOL FilterWhitelist(INT spellID, TABLE filterSRC)
	]]
	lib.FilterWhitelist = function(spellID, list)
		-- lib.debugging('entering FilterWhitelist() with spellID='..spellID)
		if ( #list ~= 0 ) then
			if ( lib.in_array(spellID, list) ) then
				return true
			end
		end
		return false
	end


	--[[ Generic filter-function (distinction between blacklist and whitelist)
		BOOL FilterGeneric(INT spellID, TABLE filterSRC)
	]]
	lib.FilterGeneric = function(spellID, name, filterSRC, icon, caster)
		-- lib.debugging('entering FilterGeneric() with spellID='..spellID..' ('..name..')')
		lib.collectAura(spellID, name)
		icon.caster = caster
		if (filterSRC.mode == 'blacklist') then
			return lib.FilterBlacklist(spellID, filterSRC.list)
		else
			return lib.FilterWhitelist(spellID, filterSRC.list)
		end
	end


	--[[ Modifies the position for OmniCC-timers on buff-icons
		VOID OmniCCHack(BUTTON icon)
	]]
	lib.OmniCCHack = function(icon)
		if icon.timer then return end

		if OmniCC then
			for i = 1, icon:GetNumChildren() do
				local child = select(i, icon:GetChildren())
				if child.text and (child.icon == icon.icon or child.cooldown == icon.cd) then

					child.ClearAllPoints = noop
					child.SetAlpha = noop
					child.SetPoint = noop
					child.SetScale = noop

					child.text:ClearAllPoints()
					child.text.ClearAllPoints = noop

					child.text:SetPoint('CENTER', icon, 'BOTTOM', 0, 4)
					child.text.SetPoint = noop

					child.text:SetFont(settings.src.fonts.value, 17, 'OUTLINE')
					child.text.SetFont = noop

					-- child.text:SetTextColor(1, 0.8, 0)
					-- child.text.SetTextColor = noop
					-- child.text.SetVertexColor = noop

					icon.timer = child.text

					return
				end
			end
		else
			icon.timer = true
		end
	end

-- ************************************************************************************************
ns.lib = lib											-- handover of the core-functions to the namespace