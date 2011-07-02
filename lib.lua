--[[ LIBRARY
	Contains library-functions
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings

-- Let's get it on!
local lib = {}
-- ************************************************************************************************

--[[ Debugging to ChatFrame
	VOID debugging(STRING text)
]]
lib.debugging = function(text)
	DEFAULT_CHAT_FRAME:AddMessage('|cffffd700oUF_PhantomMenace:|r |cffeeeeee'..text..'|r')
end

--[[

]]
lib.CreateFontObject = function(parent, size, font)
	local fo = parent:CreateFontString(nil, 'OVERLAY')
	fo:SetFont(font, size, 'OUTLINE')
	fo:SetJustifyH('CENTER')
	-- fo:SetShadowColor(0,0,0)
	-- fo:SetShadowOffset(1, 1)
	return fo
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

--[[

]]
lib.ColorBorder = function(tex, r, g, b, a)

	if (#tex == 0) then 
		lib.debugging('no textures to color!')
		return
	end

	local _, v
	for _, v in pairs(tex) do
		v:SetVertexColor(r, g, b, a)
	end

end

--[[

]]
lib.CreateBack = function(target)

	local back = target:CreateTexture(nil, 'BACKGROUND')
	back:SetPoint('TOPLEFT', target, 'TOPLEFT', -3, 3)
	back:SetPoint('BOTTOMRIGHT', target, 'BOTTOMRIGHT', 3, -3)
	back:SetTexture(unpack(oUF_PhantomMenaceSettings.general.color.background))

	return back
end

--[[

]]
lib.CreateGloss = function(self, target)
	local gloss = CreateFrame('Frame', nil, self)
	gloss:SetFrameLevel(target:GetFrameLevel()+5)
	gloss:SetAllPoints(target)
	gloss.left = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.left:SetSize(13, target:GetHeight())
	gloss.left:SetTexture(settings.tex.gloss)
	gloss.left:SetTexCoord(0, 0.25, 0, 1)
	gloss.left:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.left:SetPoint('TOPLEFT')
	gloss.right = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.right:SetSize(13, target:GetHeight())
	gloss.right:SetTexture(settings.tex.gloss)
	gloss.right:SetTexCoord(0.75, 1, 0, 1)
	gloss.right:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.right:SetPoint('TOPRIGHT')
	gloss.mid = gloss:CreateTexture(nil, 'OVERLAY')
	gloss.mid:SetHeight(target:GetHeight())
	gloss.mid:SetTexture(settings.tex.gloss)
	gloss.mid:SetTexCoord(0.25, 0.75, 0, 1)
	gloss.mid:SetVertexColor(1, 1, 1, oUF_PhantomMenaceSettings.general.glossIntensity)
	gloss.mid:SetPoint('TOPLEFT', gloss.left, 'TOPRIGHT')
	gloss.mid:SetPoint('TOPRIGHT', gloss.right, 'TOPLEFT')

	return gloss
end

-- ************************************************************************************************
ns.lib = lib