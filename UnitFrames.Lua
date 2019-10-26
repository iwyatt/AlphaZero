-- unit frames (Target, Player, Target's Target)
local MaxUnitFrameAlpha = 0.35
local f = CreateFrame("Frame")
local f2 = CreateFrame("Frame");
local f3 = CreateFrame("Frame");
changeAlpha = 30
f:RegisterEvent("PLAYER_TARGET_CHANGED") -- Run code when player's target changed
f2:RegisterEvent("PLAYER_REGEN_DISABLED") --player entered combat
f3:RegisterEvent("PLAYER_REGEN_ENABLED")--player left combat

f:SetScript("OnEvent", function(self, event, ...) --target changed event
	if(UnitName("target") == nil or UnitName("target") == UnitName("player")) then --if player has no target
		fadeOut(PlayerFrame)
		fadeOut(TargetFrame)
		fadeOut(TargetFrameToT)
	else --if player has target
		fadeIn(TargetFrame)
		fadeIn(TargetFrameToT)
		fadeIn(PlayerFrame)
	end
end)

f2:SetScript("OnEvent", function(self, event, ...)
	fadeIn(PlayerFrame)
end)

f3:SetScript("OnEvent", function(self, event, ...)
	if(UnitName("target") == nil or UnitName("target") == UnitName("player")) then
		fadeOut(PlayerFrame)
	end
end)

function fadeIn(frame, changeAlpha)
	local ticker = C_Timer.NewTicker(0.01, function()
	if(PlayerFrame:GetAlpha() < 0.35 or frame ~= PlayerFrame) then
		frame:SetAlpha(frame:GetAlpha()+0.09)
	end
	end, 50)

end

function fadeOut(frame)
	local ticker = C_Timer.NewTicker(0.01, function()
	frame:SetAlpha(frame:GetAlpha()-0.1)
	end, 50)	
end

--hide frames when client loads
PlayerFrame:SetAlpha(0)
TargetFrame:SetAlpha(0)
TargetFrameToT:SetAlpha(0)
DropDownList1:Hide();