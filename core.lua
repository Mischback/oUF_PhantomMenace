--[[ oUF_PhantomMenace
	This is a layout for the incredibly awesome oUF by haste.
	
	PLEASE NOTE that this layout comes with no warranty and "as it is". It was created to fit my very own
	needs, so please understand, that I'll not put any effort in "fixing" something for you, "adding" something
	for you or make any changes to this.
	Anyway, when you read this, you've already downloaded my layout, so please, feel free to modify it to your
	own needs.
]]

local ADDON_NAME, ns = ...								-- get the addons namespace to exchange functions between core and layout
local core = {}

local lib = ns.lib										-- get the lib
local settings = ns.settings							-- get the settings

--[[ FUNCTIONS
	Now we're starting with our functions. 
	Note that in this file are only the functions, which are used by more than one layout-function.
]]

	--[[ Creates the HealthBar
		FRAME CreateHealthBar(FRAME frame)
	]]
	core.CreateHealthBar = function(frame)
		local hp = CreateFrame('StatusBar', nil, frame)
		hp:SetFrameLevel(10)
		hp:SetAllPoints(frame)
		hp:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		hp:SetStatusBarColor(unpack(settings.src.bar))

		hp.bg = hp:CreateTexture(nil, 'BACKGROUND')
		hp.bg:SetAllPoints(hp)
		hp.bg:SetTexture(settings.src.textures.bar)
		hp.bg:SetVertexColor(unpack(settings.src.bar_bg))

		local mhpb = CreateFrame('StatusBar', nil, self)
		mhpb:SetFrameLevel(11)
		mhpb:SetPoint('TOPLEFT', hp:GetStatusBarTexture(), 'TOPRIGHT')
		mhpb:SetPoint('BOTTOMLEFT', hp:GetStatusBarTexture(), 'BOTTOMRIGHT')
		mhpb:SetWidth(frame:GetWidth())
		mhpb:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		mhpb:SetStatusBarColor(0.3, 0.6, 0.3)
		mhpb:Hide()

		local ohpb = CreateFrame('StatusBar', nil, self)
		ohpb:SetFrameLevel(11)
		ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT')
		ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT')
		ohpb:SetWidth(frame:GetWidth())
		ohpb:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		ohpb:SetStatusBarColor(0.8, 0.7, 0.3)
		ohpb:Hide()

		frame.HealPrediction = {
			['myBar'] = mhpb,
			['otherBar'] = ohpb, 
			['maxOverflow'] = 1.0,
		}

		return hp
	end


	--[[ Creates the PowerBar
		FRAME CreatePowerBar(FRAME frame, INT width, INT height)
	]]
	core.CreatePowerBar = function(frame, width, height)
		local pb = CreateFrame('StatusBar', nil, frame)
		pb:SetFrameLevel(5)
		pb:SetSize(width, height)
		pb:SetStatusBarTexture(settings.src.textures.solid, 'ARTWORK')

		pb.bg = pb:CreateTexture(nil, 'BORDER')
		pb.bg:SetAllPoints(pb)
		pb.bg:SetTexture(settings.src.textures.solid)
		pb.bg:SetAlpha(0.5)

		pb.back = pb:CreateTexture(nil, 'BACKGROUND')
		pb.back:SetAllPoints(pb)
		pb.back:SetTexture(settings.src.textures.solid)
		pb.back:SetVertexColor(0.2, 0.2, 0.2)

		pb.colorDisconnected = true
		pb.colorClass = true
		pb.colorReaction = true

		return pb
	end


	--[[ Generic function to create borders
		FRAME CreateBorder_Generic(FRAME frame, STRING tex, INT xOff, INT yOff)
	]]
	core.CreateBorder_Generic = function(frame, tex, xOff, yOff)
		local b = CreateFrame('Frame', nil, frame)
		b:SetFrameLevel(40)
		b:SetSize(256, 64)
		b:SetPoint('TOPLEFT', frame, 'TOPLEFT', xOff, yOff)
		b.tex = b:CreateTexture(nil, 'ARTWORK')
		b.tex:SetTexture(tex)
		b.tex:SetAllPoints(b)
		return b
	end


	--[[ Creates the Rune frame (for DKs)
		FRAME CreateRuneFrame(FRAME frame)
	]]
	core.CreateRuneFrame = function(frame)
		local rf = CreateFrame('Frame', nil, frame)
		rf:SetFrameLevel(35)

		rf[1] = CreateFrame('StatusBar', nil, rf)
		rf[1]:SetSize(20, 7)
		rf[1]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[1]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 18, 5)
		rf[1].back = rf[1]:CreateTexture(nil, 'BACKGROUND')
		rf[1].back:SetTexture(settings.src.textures.solid)
		rf[1].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[1].back:SetAllPoints(rf[1])

		rf[2] = CreateFrame('StatusBar', nil, rf)
		rf[2]:SetSize(20, 7)
		rf[2]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[2]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 41, 5)
		rf[2].back = rf[2]:CreateTexture(nil, 'BACKGROUND')
		rf[2].back:SetTexture(settings.src.textures.solid)
		rf[2].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[2].back:SetAllPoints(rf[2])

		rf[3] = CreateFrame('StatusBar', nil, rf)
		rf[3]:SetSize(20, 7)
		rf[3]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[3]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 79, 5)
		rf[3].back = rf[3]:CreateTexture(nil, 'BACKGROUND')
		rf[3].back:SetTexture(settings.src.textures.solid)
		rf[3].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[3].back:SetAllPoints(rf[3])

		rf[4] = CreateFrame('StatusBar', nil, rf)
		rf[4]:SetSize(20, 7)
		rf[4]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[4]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 102, 5)
		rf[4].back = rf[4]:CreateTexture(nil, 'BACKGROUND')
		rf[4].back:SetTexture(settings.src.textures.solid)
		rf[4].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[4].back:SetAllPoints(rf[4])

		rf[5] = CreateFrame('StatusBar', nil, rf)
		rf[5]:SetSize(20, 7)
		rf[5]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[5]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 140, 5)
		rf[5].back = rf[5]:CreateTexture(nil, 'BACKGROUND')
		rf[5].back:SetTexture(settings.src.textures.solid)
		rf[5].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[5].back:SetAllPoints(rf[5])

		rf[6] = CreateFrame('StatusBar', nil, rf)
		rf[6]:SetSize(20, 7)
		rf[6]:SetStatusBarTexture(settings.src.textures.bar, 'BORDER')
		rf[6]:SetPoint('TOPLEFT', frame, 'TOPLEFT', 163, 5)
		rf[6].back = rf[6]:CreateTexture(nil, 'BACKGROUND')
		rf[6].back:SetTexture(settings.src.textures.solid)
		rf[6].back:SetVertexColor(0.1, 0.1, 0.1)
		rf[6].back:SetAllPoints(rf[6])

		return rf
	end


	--[[ Creates the HolyPower/SoulShard frame for Paladins/Warlocks
		FRAME CreateHolyShardsFrame(FRAME frame)
		Note: Coloring is done in the layout-function.
	]]
	core.CreateHolyShardsFrame = function(frame)
		local hsf = CreateFrame('Frame', nil, frame)
		hsf:SetFrameLevel(35)

		hsf[1] = hsf:CreateTexture(nil, 'BORDER')
		hsf[1]:SetTexture(settings.src.textures.solid)
		hsf[1]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -114, 5)
		hsf[1]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -92, -3)

		hsf[2] = hsf:CreateTexture(nil, 'BORDER')
		hsf[2]:SetTexture(settings.src.textures.solid)
		hsf[2]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -77, 5)
		hsf[2]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -55, -3)

		hsf[3] = hsf:CreateTexture(nil, 'BORDER')
		hsf[3]:SetTexture(settings.src.textures.solid)
		hsf[3]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -40, 5)
		hsf[3]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -18, -3)

		hsf.back1 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back1:SetTexture(settings.src.textures.solid)
		hsf.back1:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back1:SetAllPoints(hsf[1])

		hsf.back2 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back2:SetTexture(settings.src.textures.solid)
		hsf.back2:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back2:SetAllPoints(hsf[2])

		hsf.back3 = hsf:CreateTexture(nil, 'BACKGROUND')
		hsf.back3:SetTexture(settings.src.textures.solid)
		hsf.back3:SetVertexColor(0.1, 0.1, 0.1)
		hsf.back3:SetAllPoints(hsf[3])

		return hsf
	end


	--[[ Creates the Eclipse-bar for Balance-Druids
		FRAME CreateEclipseBar(FRAME frame)
	]]
	core.CreateEclipseBar = function(frame)
		local eb = CreateFrame('Frame', nil, frame)
		eb:SetFrameLevel(35)
		eb:SetPoint('TOPLEFT', frame, 'TOPLEFT', 18, 5)
		eb:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -18, -3)

		eb.LunarBar = CreateFrame('StatusBar', nil, eb)
		eb.LunarBar:SetFrameLevel(16)
		eb.LunarBar:SetPoint('LEFT', eb, 'LEFT')
		eb.LunarBar:SetSize(164, 8)
		eb.LunarBar:SetStatusBarTexture(settings.src.textures.bar)
		eb.LunarBar:SetStatusBarColor(0.34, 0.1, 0.86)

		eb.SolarBar = CreateFrame('StatusBar', nil, eb)
		eb.SolarBar:SetFrameLevel(16)
		eb.SolarBar:SetPoint('LEFT', eb.LunarBar:GetStatusBarTexture(), 'RIGHT')
		eb.SolarBar:SetSize(164, 8)
		eb.SolarBar:SetStatusBarTexture(settings.src.textures.bar)
		eb.SolarBar:SetStatusBarColor(0.95, 0.73, 0.15)

		return eb
	end


	--[[ Creates the Totem-bar for Shamans (supporting oUF_boring_totembar)
		FRAME CreateTotems(FRAME frame)
	]]
	core.CreateTotems = function(frame)
		local totems = CreateFrame('Frame', nil, frame)
		totems:SetFrameLevel(35)

		totems[1] = CreateFrame('Frame', nil, totems)
		totems[1]:SetFrameLevel(16)
		totems[1]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -151, 5)
		totems[1]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -128, -3)
		totems[1].StatusBar = CreateFrame('StatusBar', nil, totems[1])
		totems[1].StatusBar:SetAllPoints(totems[1])
		totems[1].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[2] = CreateFrame('Frame', nil, frame)
		totems[2]:SetFrameLevel(16)
		totems[2]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -114, 5)
		totems[2]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -91, -3)
		totems[2].StatusBar = CreateFrame('StatusBar', nil, totems[2])
		totems[2].StatusBar:SetAllPoints(totems[2])
		totems[2].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[3] = CreateFrame('Frame', nil, frame)
		totems[3]:SetFrameLevel(16)
		totems[3]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -77, 5)
		totems[3]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -54, -3)
		totems[3].StatusBar = CreateFrame('StatusBar', nil, totems[3])
		totems[3].StatusBar:SetAllPoints(totems[3])
		totems[3].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems[4] = CreateFrame('Frame', nil, frame)
		totems[4]:SetFrameLevel(16)
		totems[4]:SetPoint('TOPLEFT', frame, 'TOPRIGHT', -40, 5)
		totems[4]:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -17, -3)
		totems[4].StatusBar = CreateFrame('StatusBar', nil, totems[4])
		totems[4].StatusBar:SetAllPoints(totems[4])
		totems[4].StatusBar:SetStatusBarTexture(settings.src.textures.bar)

		totems.back = {}
		totems.back[1] = totems:CreateTexture(nil, 'BORDER')
		totems.back[1]:SetAllPoints(totems[1])
		totems.back[1]:SetTexture(settings.src.textures.solid)
		totems.back[1]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[2] = totems:CreateTexture(nil, 'BORDER')
		totems.back[2]:SetAllPoints(totems[2])
		totems.back[2]:SetTexture(settings.src.textures.solid)
		totems.back[2]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[3] = totems:CreateTexture(nil, 'BORDER')
		totems.back[3]:SetAllPoints(totems[3])
		totems.back[3]:SetTexture(settings.src.textures.solid)
		totems.back[3]:SetVertexColor(0.1, 0.1, 0.1)
		totems.back[4] = totems:CreateTexture(nil, 'BORDER')
		totems.back[4]:SetAllPoints(totems[4])
		totems.back[4]:SetTexture(settings.src.textures.solid)
		totems.back[4]:SetVertexColor(0.1, 0.1, 0.1)

		return totems
	end


	--[[ Creates the player's castbar
		FRAME CreatePlayerCastbar()
	]]
	core.CreatePlayerCastbar = function()
		local cb = CreateFrame('StatusBar', nil, UIParent)
		cb:SetStatusBarTexture(settings.src.textures.bar, 'ARTWORK')
		cb:SetStatusBarColor(0.86, 0.5, 0, 1)
		cb:SetWidth(settings.options.castbar.width)
		cb:SetHeight(settings.options.castbar.height)
		cb:SetPoint('CENTER', UIParent, 'CENTER', 15, -175)

		cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
		cb.bg:SetAllPoints(cb)
		cb.bg:SetTexture(settings.src.textures.bar)
		cb.bg:SetVertexColor(0.1, 0.1, 0.1)

		cb.SafeZone = cb:CreateTexture(nil,'BORDER')
		cb.SafeZone:SetPoint('TOPRIGHT')
		cb.SafeZone:SetPoint('BOTTOMRIGHT')
		cb.SafeZone:SetHeight(22)
		cb.SafeZone:SetTexture(settings.src.textures.bar)
		cb.SafeZone:SetVertexColor(.69,.31,.31)

		cb.Text = lib.CreateFontObject(cb, settings.options.castbar.fontSize, settings.src.fonts.value)
		cb.Text:SetPoint('LEFT', 3, 2)
		cb.Text:SetTextColor(0.84, 0.75, 0.65)

		cb.Time = lib.CreateFontObject(cb, settings.options.castbar.fontSize, settings.src.fonts.value)
		cb.Time:SetPoint('RIGHT', -3, 2)
		cb.Time:SetTextColor(0.84, 0.75, 0.65)
		cb.Time:SetJustifyH('RIGHT')

		cb.Icon = cb:CreateTexture(nil, 'ARTWORK')
		cb.Icon:SetHeight(25)
		cb.Icon:SetWidth(25)
		cb.Icon:SetTexCoord(0.1,0.9,0.1,0.9)
		cb.Icon:SetPoint('RIGHT', cb, 'LEFT', -10, 0)

		cb.Border = CreateFrame('Frame', nil, cb)
		cb.Border:SetPoint('TOPLEFT', cb, 'TOPLEFT', -5, 5)
		cb.Border:SetPoint('BOTTOMRIGHT', cb, 'BOTTOMRIGHT', 5, -4)
		cb.Border:SetBackdrop( {
			bgFile = nil, 
			edgeFile = settings.src.textures.border_generic,
			tile = false, 
			edgeSize = 8,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )

		cb.Icon.Border = CreateFrame('Frame', nil, cb)
		cb.Icon.Border:SetPoint('TOPLEFT', cb.Icon, 'TOPLEFT', -5, 5)
		cb.Icon.Border:SetPoint('BOTTOMRIGHT', cb.Icon, 'BOTTOMRIGHT', 5, -4)
		cb.Icon.Border:SetBackdrop( {
			bgFile = nil, 
			edgeFile = settings.src.textures.border_generic,
			tile = false, 
			edgeSize = 8,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		} )

		return cb
	end


	--[[ Creates a generic castbar, which is used on certain unitframes
		FRAME CreateNameplateCastbar(FRAME hold)
	]]
	core.CreateNameplateCastbar = function(hold)
		local cb = CreateFrame('StatusBar', nil, hold)
		cb:SetFrameLevel(35)
		cb:SetStatusBarTexture(settings.src.textures.bar, 'ARTWORK')
		cb:SetStatusBarColor(0.86, 0.5, 0, 1)
		cb:SetAllPoints(hold)

		cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
		cb.bg:SetAllPoints(cb)
		cb.bg:SetTexture(settings.src.textures.solid)
		cb.bg:SetVertexColor(0.1, 0.1, 0.1)

		cb.Text = lib.CreateFontObject(cb, 16, settings.src.fonts.value)
		cb.Text:SetPoint('LEFT', 3, 1)
		cb.Text:SetTextColor(unpack(settings.src.default_font))

		cb.Time = lib.CreateFontObject(cb, 16, settings.src.fonts.value)
		cb.Time:SetPoint('RIGHT', -3, 1)
		cb.Time:SetTextColor(unpack(settings.src.default_font))
		cb.Time:SetJustifyH('RIGHT')

		return cb
	end


	--[[ Creates the overlay for Threat-/Debuff-highlighting
		FRAME CreateOverlay(FRAME frame)
	]]
	core.CreateOverlay = function(frame)
		local t = CreateFrame('Frame', nil, frame)
		t:SetFrameLevel(20)
		t.tex = t:CreateTexture(nil, 'OVERLAY')
		t.tex:SetTexture(settings.src.textures.overlay)
		t.tex:SetAllPoints(frame.Health)

		t:Hide()
		return t
	end


	--[[ Creates a frame for Debuff-highlighting.
		This will actually only be used for event-registrations
		FRAME CreateDebuffHighlight(FRAME frame)
	]]
	core.CreateDebuffHighlight = function(frame)
		local dbh = CreateFrame('FRAME', nil, frame)
		dbh:RegisterEvent('UNIT_AURA')
		dbh:RegisterEvent('PLAYER_TALENT_UPDATE', lib.CheckSpec)
		dbh:RegisterEvent('CHARACTER_POINTS_CHANGED', lib.CheckSpec)
		dbh:SetScript('OnEvent', function(self, event, unit)
			if ( event == 'UNIT_AURA' ) then
				core.UpdateOverlay(self:GetParent(), nil, unit)
			else
				lib.CheckSpec()
			end
		end)
		return dbh
	end


	--[[ Creates a statusbar for incoming resses (support for oUF_ResComm)
		STATUSBAR CreateRezzComm(FRAME frame)
	]]
	core.CreateRezzComm = function(frame)
		local rc = CreateFrame('StatusBar', nil, frame)
		rc:SetFrameLevel(15)
		rc:SetAllPoints(frame.Health)
		rc:SetStatusBarTexture(settings.src.textures.bar)
		rc:SetStatusBarColor(1, 1, 0)

		return rc
	end


-- ***** ENGINES ***************************************************************************************

	--[[ Update player's health
	]]
	core.UpdateHealth_player = function(health, unit, min, max)
		if ( min ~= max ) then
			health.value:SetFormattedText('|cffCC0000-%s|r|cffCCCCCC | %s|r', lib.Shorten((max-min)), lib.Shorten(min))
		else
			health.value:SetText(min)
		end
	end


	--[[ Shows health value and percent text or just the value, if at 100%
	]]
	core.UpdateHealth_min_percent = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.dead)
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.ghost)
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.offline)
		else
			if (min ~= max) then
				health.value:SetFormattedText('|cffCCCCCC%s | %d%%|r', lib.Shorten(min), (min/max)*100)
			else
				health.value:SetText(min)
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as percent only.
	]]
	core.UpdateHealth_percent = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.dead)
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.ghost)
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.offline)
		else
			health.value:SetFormattedText('|cffCCCCCC%d%%|r', (min/max)*100)
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as deficit from MAX.
	]]
	core.UpdateHealth_deficit = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.dead)
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.ghost)
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.offline)
		else
			if ( min ~= max ) then
				health.value:SetFormattedText('|cffCC0000-%s|r', lib.Shorten(max-min))
			else
				health.value:SetText(min)
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as percent.
		Toggles Name-/Health-visibility.
	]]
	core.UpdateHealth_raid = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.dead)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.ghost)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.offline)
			health.value:Show()
			health:GetParent().Name:Hide()
		else
			if ( min ~= max ) then
				health.value:SetFormattedText('|cffCCCCCC%d%%|r', (min/max)*100)
				health.value:Show()
				health:GetParent().Name:Hide()
			else
				health.value:Hide()
				health:GetParent().Name:Show()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Shows the health-value as deficit from MAX.
		Toggles Name-/Health-visibility.
	]]
	core.UpdateHealth_raid_deficit = function(health, unit, min, max)
		if (UnitIsDead(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.dead)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (UnitIsGhost(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.ghost)
			health.value:Show()
			health:GetParent().Name:Hide()
		elseif (not UnitIsConnected(unit)) then
			health:SetValue(0)
			health.value:SetText(settings.options.strings.offline)
			health.value:Show()
			health:GetParent().Name:Hide()
		else
			if ( min ~= max ) then
				health.value:SetFormattedText('|cffCC0000-%s|r', lib.Shorten(max-min))
				health.value:Show()
				health:GetParent().Name:Hide()
			else
				health.value:Hide()
				health:GetParent().Name:Show()
			end
		end
		health:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Update player's power
		This shows the current value of power (mana, rage, energy, focus, runic power).
		For druids, it will show mana at any time.
	]]
	core.UpdatePower_player = function(power, unit, min, max)
		if ( lib.playerclass == 'DRUID' ) then
			min, max = UnitPower(unit, 0), UnitPowerMax(unit, 0)
		end
		power.value:SetText(lib.Shorten(min))
	end


	--[[ Update power
		This shows the current value of power (mana, rage, energy, focus, runic power).
	]]
	core.UpdatePower = function(power, unit, min, max)
		power.value:SetText(lib.Shorten(min))
		power:GetParent():UNIT_NAME_UPDATE(event, unit)
	end


	--[[ Updates the target's name
		Limited to 23 characters.
	]]
	core.UpdateName_target = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 23 then name = name:sub(1, 22)..'...' end
		self.Name:SetText(name)
	end


	--[[ Updates the target's target's name
		Limited to 6 characters.
	]]
	core.UpdateName_targettarget = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 6 then name = name:sub(1, 6) end
		self.Name:SetText(name)
	end


	--[[ Updates the focus' name.
		Limited to 15 characters.
	]]
	core.UpdateName_focus = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 15 then name = name:sub(1, 15) end
		self.Name:SetText(name)
	end


	--[[ Updates the raid-members' names.
		Limited to 6 characters.
	]]
	core.UpdateName_raid = function(self, event, unit)
		local name = UnitName(unit)
		if string.len(name) > 6 then name = name:sub(1, 6) end
		self.Name:SetText(name)
	end


	--[[ Updates the ComboPoints.
		This is applied to the target-frame for ALL classes, since we don't know, which vehicle uses this.
		Main purpose of course for Rogues and Druids.
	]]
	core.UpdateComboPoints = function(frame)
		-- lib.debugging('UpdateComboPoints')
		local cp
		if ( UnitExists('vehicle') ) then
			cp = GetComboPoints('vehicle', 'target')
		else
			cp = GetComboPoints('player', 'target')
		end
		if (cp < 1) then
			frame.value:Hide()
		elseif ( cp < 5 ) then
			frame.value:SetText(cp)
			frame.value:Show()
		else
			frame.value:SetFormattedText('|cffCC0000%s|r', cp)
			frame.value:Show()
		end
	end


	--[[ Updates the EclipseBar's visibility.
		TODO: not working, it seems!
	
	]]
	core.UpdateEclipseBarVisibility = function(unit)
		if(powerType ~= 'ECLIPSE') then return end

		local eb = self.EclipseBar

		local power = UnitPower(unit, SPELL_POWER_ECLIPSE)
		local maxPower = UnitPowerMax(unit, SPELL_POWER_ECLIPSE)

		if(eb.LunarBar) then
			eb.LunarBar:SetMinMaxValues(-maxPower, maxPower)
			eb.LunarBar:SetValue(power)
		end

		if(eb.SolarBar) then
			eb.SolarBar:SetMinMaxValues(-maxPower, maxPower)
			eb.SolarBar:SetValue(power * -1)
		end
	end


	--[[ This updates the overlay.
		Priority is as follows: 
			If we're highlighting debuffs, we first show the debuff, then threat
	]]
	core.UpdateOverlay = function(self, event, unit)
		if ( unit ~= self.unit ) then return end
		local r, g, b, a = 1, 1, 1, 0
		if ( self.Threat ) then
			local status = UnitThreatSituation(unit)
			-- if ( self.threatStatus == status ) then return end
			if not status then status = 0 end
			-- self.threatStatus = status
			-- lib.debugging('UpdateOverlay (THREAT)')
			r, g, b, a = unpack(settings.src.threatColors[status])
			-- lib.debugging('AggroColor: '..r..'/'..g..'/'..b..'/'..a)
		end
		if ( lib.dispelAbility and self.DebuffHighlight ) then
			local debuffType = lib.GetDebuff(unit)
			if ( debuffType ) then
				-- lib.debugging('UpdateOverlay (DEBUFF)')
				r, g, b, a = unpack(settings.src.debuffColors[debuffType])
				-- lib.debugging('DebuffColor: '..r..'/'..g..'/'..b..'/'..a)
			end
		end
		-- lib.debugging('OverlayColor: '..r..'/'..g..'/'..b..'/'..a)
		self.Overlay.tex:SetVertexColor(r, g, b, a)
		self.Overlay:Show()
	end


-- ***** BUFFS/DEBUFFS *********************************************************************************

	--[[ Filter the players buffs
		BOOL FilterBuffs_player(..., INT spellID)
	]]
	core.FilterBuffs_player = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		-- lib.debugging(spellID..'('..name..')')
		return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.playerBuffs, icon, caster)
	end


	--[[ Filter the players debuffs
		BOOL FilterDebuffs_player(..., INT spellID)
	]]
	core.FilterDebuffs_player = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.playerDebuffs, icon, caster)
	end


	--[[ Filter buffs
		BOOL FilterBuffs(..., INT spellID)
	]]
	core.FilterBuffs = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		-- lib.debugging('entering FilterBuffs() with spellID='..spellID)
		if ( UnitIsFriend(unit, 'player') ) then
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.friendsBuffs, icon, caster)
		else
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.enemyBuffs, icon, caster)
		end
	end


	--[[ Filter debuffs
		BOOL FilterDebuffs(..., INT spellID)
	]]
	core.FilterDebuffs = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
		if ( UnitIsFriend(unit, 'player') ) then
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.friendsDebuffs, icon, caster)
		else
			return lib.FilterGeneric(spellID, name, PhantomMenaceOptions.enemyDebuffs, icon, caster)
		end
	end


	--[[ Generic PostUpdate-function to apply the OmniCC-hack
		VOID GenericPostUpdateIcon(FRAME icons, UNIT unit, BUTTON icon, INT index, INT offset, STRING filter, BOOL isDebuff)
	]]
	core.GenericPostUpdateIcon = function(icons, unit, icon, index, offset, filter, isDebuff)
		lib.OmniCCHack(icon)
	end

-- *****************************************************************************************************
ns.core = core											-- handover of the core-functions to the namespace