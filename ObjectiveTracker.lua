--ObjectiveTrackerFrame:RegisterEvent("CURSOR_UPDATE")

-- manage objective tracker
local function onEnterObjectiveTracker(frame,event)
    if event ~= true then print(event) end
    frame:SetFrameStrata("BACKGROUND")
    PlaySound(821, "SFX")
    ObjectiveTrackerFrame:Show()
end

local function onLeaveObjectiveTracker(frame)
    if MouseIsOver(ObjectiveTrackerFrame) or QuestHeaderFrame:GetAttribute("isSticky") then return end
    ObjectiveTrackerFrame:Hide()
end

local function shortDisplayObjectiveTracker(frame,event)
    ObjectiveTrackerFrame:Show()
    C_Timer.After(10, function()
        ObjectiveTrackerFrame:Hide()
   end)
end

-- initialize tracking frame
local frame = CreateFrame("FRAME", "ObjectiveTrackerTrigger", UIParent)
frame:SetAllPoints(ObjectiveTrackerFrame)
frame:Show()

frame:SetScript("OnEnter", onEnterObjectiveTracker)

frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("QUEST_AUTOCOMPLETE")
frame:RegisterEvent("QUEST_LOG_CRITERIA_UPDATE")
--frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:RegisterEvent("QUEST_POI_UPDATE")
--frame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
--frame:RegisterEvent("QUESTLINE_UPDATE")
frame:RegisterEvent("SUPER_TRACKED_QUEST_CHANGED")
--frame:RegisterEvent("TASK_PROGRESS_UPDATE")
--frame:RegisterEvent("WAYPOINT_UPDATE")


frame:SetScript("OnEvent", shortDisplayObjectiveTracker)

frame:SetScript("OnLeave", onLeaveObjectiveTracker)

-- set defaults on load
ObjectiveTrackerFrame:Hide()

-- enable clicking quest header to make quest tracking sticky
local function SetTransMode()
    if QuestHeaderFrame:GetAttribute("isSticky") then
        QuestHeaderFrame:SetAttribute("isSticky", false)
        print("Objective Tracker is sticky = false")
    else
        QuestHeaderFrame:SetAttribute("isSticky", true)
        print("Objective Tracker is sticky = true")
    end
 end

 --ObjectiveTrackerBlocksFrame.QuestHeader:RegisterEvent("OnClick")
 QuestHeaderFrame = CreateFrame("Button","QuestHeaderButton",ObjectiveTrackerBlocksFrame.QuestHeader, nil)
 QuestHeaderFrame:SetAllPoints(ObjectiveTrackerBlocksFrame.QuestHeader)
 QuestHeaderFrame:SetScript("OnClick", SetTransMode)
 --ObjectiveTrackerBlocksFrame.QuestHeader("isSticky", "true")
