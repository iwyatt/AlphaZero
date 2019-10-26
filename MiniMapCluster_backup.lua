-- minimap cluster: need to change this to mouse hover
-- /run local m=MinimapCluster local n=ObjectiveTrackerFrame if m:IsShown()then m:Hide();n:Hide() else m:Show();n:Show() end

local m=MinimapCluster
local n=ObjectiveTrackerFrame
local b=MinimapBackdrop
local frameFadingIn = false
local frameFadingOut = false

local psuedoFrame = CreateFrame("Frame",nil,UIParent)
local mapRegionBottom = MinimapCluster:GetBottom()
local mapRegionTop = MinimapCluster:GetTop()
local mapRegionLeft = MinimapCluster:GetLeft()
local mapRegionRight = MinimapCluster:GetRight()

m:fadeOut()
n:fadeOut()
b:fadeOut()

-- hide questing arrows
hooksecurefunc('SetSuperTrackedQuestID',
	function(questID)
	if questID ~= 0 then SetSuperTrackedQuestID(0) end
end)

function fadeIn(frame)
	print("fadein"..frame:GetName())
	--print(mapRegionTop .. mapRegionBottom .. mapRegionLeft .. mapRegionRight)
	--print(psuedoFrame:IsMouseOver(mapRegionTop, mapRegionBottom, mapRegionLeft, mapRegionRight))
	--if not psuedoFrame:IsMouseOver(mapRegionTop, mapRegionBottom, mapRegionLeft, mapRegionRight) then return end
	--frame:Show()
	if frameFadingOut or frameFadingIn then return end
	frameFadingIn = true
	local ticker = C_Timer.NewTicker(0.01, function()
		
		frame:SetAlpha(frame:GetAlpha()+0.09)
		if frame:GetAlpha() > 0.90 then frameFadingIn = false end
	end, 50)
end

function fadeOut(frame)
	print("fadeout"..frame:GetName())
	--frame:SetAlpha(0)
	--frame:Show()
	--print(psuedoFrame:IsMouseOver(mapRegionTop, mapRegionBottom, mapRegionLeft, mapRegionRight))
	--print(mapRegionTop .. mapRegionBottom .. mapRegionLeft .. mapRegionRight)
	--if psuedoFrame:IsMouseOver(mapRegionTop, mapRegionBottom, mapRegionLeft, mapRegionRight) then return end
	if frameFadingIn or frameFadingOut then return end
	local ticker = C_Timer.NewTicker(0.01, function()
		frameFadingOut = true
		frame:SetAlpha(frame:GetAlpha()-0.09)
		if frame:GetAlpha() < 0.09 then
			frameFadingOut = false
			--frame:Hide()
		end
	end, 50)
end

ObjectiveTrackerFrame:HookScript("OnEnter", fadeIn)
--ObjectiveTrackerFrame:HookScript("OnLeave", fadeOut)
MinimapCluster:HookScript("OnEnter", fadeIn)
--MinimapCluster:HookScript("OnLeave", fadeOut)
MinimapBackdrop:HookScript("OnEnter", fadeIn)

--fadeOut(m)
--fadeOut(n)