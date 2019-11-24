-- from: https://www.wowinterface.com/forums/archive/index.php/t-52801.html
ObjectiveTrackerFrame:RegisterEvent("CURSOR_UPDATE")
local isFadingIn = 0
local isFadingOut = 0

local function onLeave(frame)
    if MouseIsOver(frame) or isFadingOut == 1 or MinimapZoneTextButton:GetAttribute("isSticky") then return end
    isFadingOut = 1
    local i = 0
    local ticker = C_Timer.NewTicker(0.01, function()
        i = i + 1
        Minimap:SetAlpha(Minimap:GetAlpha() - 0.01)
        if i == 90 then
            MinimapCluster:Hide()
        end
    end, 100)
    isFadingOut = 0
end

local function onEnter(frame)
    if isFadingIn == 1 then return end
    frame:SetFrameStrata("BACKGROUND")
    PlaySound(821, "SFX")
    MinimapCluster:Show()
    Minimap:SetAlpha(1)
    local ticker = C_Timer.NewTicker(0.01, function()
        if MouseIsOver(frame) or isFadingOut == 1 then return end
        onLeave(frame)
    end, 10)
end

-- manage objective tracker
local function onEnterObjectiveTracker(frame)
    frame:SetFrameStrata("BACKGROUND")
    PlaySound(821, "SFX")
    ObjectiveTrackerFrame:Show()
end

local function onLeaveObjectiveTracker(frame)
    if MouseIsOver(ObjectiveTrackerFrame) then return end
    ObjectiveTrackerFrame:Hide()
end

-- create tracking frames
local function HideAdvancedInderface()
    -- [[ ###### HIDE/SHOW MINIMAP ON MOUSE ENTER/LEAVE ###### ]]
    local function MinimapTrigger()
        local frame = CreateFrame("FRAME", "MinimapTrigger", UIParent)
        frame:SetAllPoints(MinimapCluster)
        frame:Show()
        frame:SetScript("OnEnter", onEnter)
        frame:SetScript("OnLeave", onLeave)
        MinimapCluster:SetScript("OnLeave", onLeave)
    end
    MinimapTrigger()

    -- [[ ###### HIDE/SHOW OBJECTIVE TRACKER ON MOUSE ENTER/LEAVE ###### ]]
    local function ObjectiveTrackerTrigger()
        local frame = CreateFrame("FRAME", "ObjectiveTrackerTrigger", UIParent)
        frame:SetAllPoints(ObjectiveTrackerFrame)
        frame:Show()

        frame:SetScript("OnEnter", onEnterObjectiveTracker)
        frame:SetScript("OnLeave", onLeaveObjectiveTracker)
    end
    ObjectiveTrackerTrigger()
end

-- enable sticky clicking
local function SetTransMode()
   if MinimapZoneTextButton:GetAttribute("isSticky") then
       MinimapZoneTextButton:SetAttribute("isSticky", false)
       print("is sticky = false")
   else
       MinimapZoneTextButton:SetAttribute("isSticky", true)
       print("is sticky = true")
   end
end

MinimapZoneTextButton:SetScript("OnClick", SetTransMode)
MinimapZoneTextButton:SetAttribute("isSticky", "true")

-- set default interface
HideAdvancedInderface()

-- hide minimap arrow per HideQuestArrow.lua add on
QuestSuperTracking_CheckSelection = function() end

hooksecurefunc('SetSuperTrackedQuestID', function(questID)
    if questID ~= 0 then SetSuperTrackedQuestID(0) end
end)
