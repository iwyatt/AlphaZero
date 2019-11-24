-- unit frames (Target, Player, Target's Target)
local MaxUnitFrameAlpha = 0.35
local f = CreateFrame("Frame")
local f2 = CreateFrame("Frame")
local f3 = CreateFrame("Frame")
changeAlpha = 30
f:RegisterEvent("PLAYER_TARGET_CHANGED") -- Run code when player's target changed
f:SetAttribute("fadingOut","false")
f:SetAttribute("fadingIn","false")

--f2:RegisterEvent("PLAYER_REGEN_DISABLED") -- player entered combat
--f3:RegisterEvent("PLAYER_REGEN_ENABLED") -- player left combat

f:SetScript("OnEvent", function(self, event, ...) -- target changed event
	--if f:GetAttribute("fadingOut") or f:GetAttribute("fadingIn") then return end
	if (UnitName("target") == nil or UnitName("target") == UnitName("player")) then -- if player has no target
		f:SetAttribute("fadingOut","true")
        fadeOut(PlayerFrame)
        fadeOut(TargetFrame)
		fadeOut(TargetFrameToT)
		f:SetAttribute("fadingOut","false")
    else -- if player has target
		f:SetAttribute("fadingIn","true")
		fadeIn(TargetFrame)
        fadeIn(TargetFrameToT)
		fadeIn(PlayerFrame)
		f:SetAttribute("fadingIn","false")
    end
end)

function fadeIn(frame, changeAlpha)
	local ticker = C_Timer.NewTicker(0.01, function()
        if (PlayerFrame:GetAlpha() < 0.35 or frame ~= PlayerFrame) then
            frame:SetAlpha(frame:GetAlpha() + 0.09)
		end
    end, 50)
end

function fadeOut(frame)
    local ticker = C_Timer.NewTicker(0.01, function()
		frame:SetAlpha(frame:GetAlpha() - 0.1)
	end, 50)
end

--[[
f2:SetScript("OnEvent", function(self, event, ...)
	if fadingIn or fadingOut then return end
	fadeIn(PlayerFrame) 
end)

f3:SetScript("OnEvent", function(self, event, ...)
    if (UnitName("target") == nil or UnitName("target") == UnitName("player")) then
        fadeOut(PlayerFrame)
    end
end)
]]

-- hide frames when client loads
PlayerFrame:SetAlpha(0)
TargetFrame:SetAlpha(0)
TargetFrameToT:SetAlpha(0)
DropDownList1:Hide()
