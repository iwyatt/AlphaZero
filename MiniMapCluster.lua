-- Define Functions

--- When leaving minimap tracker frame, begin fade out
function onLeave(frame)
    if frame:GetAttribute("isFadingIn") or MinimapCluster:GetAttribute("isFadingIn") or MinimapZoneTextButton:GetAttribute("isSticky") then return end
    if frame:GetAttribute("isFadingOut") or MinimapCluster:GetAttribute("isFadingOut") then return end
    if MouseIsOver(frame) or MouseIsOver(MinimapCluster) then return end

    frame:SetAttribute("isFadingOut",true)
    MinimapCluster:SetAttribute("isFadingOut",true)
    
    local fadeRate = 0.05
    local ticker = C_Timer.NewTicker(fadeRate, function()
        
        --if mouse re-enters frame while in fade out, need to stop fading out and set bools
        if MouseIsOver(frame) or MouseIsOver(MinimapCluster)
            or frame:GetAttribute("isFadingIn")
            or MinimapCluster:GetAttribute("isFadingIn")
            or MinimapZoneTextButton:GetAttribute("isSticky") then
                frame:SetAttribute("isFadingOut",false)
                MinimapCluster:SetAttribute("isFadingOut",false)

            return
        end
        
        Minimap:SetAlpha(Minimap:GetAlpha() - fadeRate)

        if Minimap:GetAlpha() < .01 then
            MinimapCluster:Hide()
        end
    end, 1/fadeRate)

    frame:SetAttribute("isFadingOut",false)
    MinimapCluster:SetAttribute("isFadingOut",false)
    triggerFrame:SetFrameStrata("MEDIUM")
end

--- when entering tracking frame, begin fade in
function onEnter(frame)
    if frame:GetAttribute("isFadingIn") or MinimapCluster:GetAttribute("isFadingIn") then return end
    if not(MouseIsOver(frame) or MouseIsOver(MinimapCluster)) then return end
    if MinimapCluster:IsShown() or Minimap:GetAlpha() == 1 then return end

    if MouseIsOver(frame) or MouseIsOver(MinimapCluster) then
        triggerFrame:SetFrameStrata("BACKGROUND")

        frame:SetAttribute("isFadingIn",true)
        MinimapCluster:SetAttribute("isFadingIn",true)

        PlaySound(821, "SFX")

        MinimapCluster:Show()
        Minimap:SetAlpha(1)
    
        frame:SetAttribute("isFadingIn",false)
        MinimapCluster:SetAttribute("isFadingIn",false)
    end
end

-- Create Tracking Frame and Set Scripts
triggerFrame = CreateFrame("FRAME", "MinimapTrigger", UIParent)
triggerFrame:SetAllPoints(MinimapCluster)
triggerFrame:Show()
triggerFrame:SetScript("OnEnter", onEnter)
triggerFrame:SetScript("OnLeave", onLeave)
triggerFrame:SetFrameStrata("MEDIUM")

-- Set initial conditions
Minimap:SetScript("OnLeave",onLeave)
MinimapCluster:SetScript("OnLeave",onLeave)
onLeave(Minimap)

-- enable clicking zone text to make cluster sticky
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
 MinimapZoneTextButton:SetAttribute("isSticky", false)

 -- hide minimap arrow per HideQuestArrow.lua add on
QuestSuperTracking_CheckSelection = function() end

hooksecurefunc('SetSuperTrackedQuestID', function(questID)
    if questID ~= 0 then SetSuperTrackedQuestID(0) end
end)



-- Resources:
---from: https://www.wowinterface.com/forums/archive/index.php/t-52801.html
-- name inspired by: https://www.wowinterface.com/forums/showthread.php?t=55800

-- For audio tracking feature:
--- https://wow.gamepedia.com/API_Minimap_SetBlipTexture
--- https://wow.gamepedia.com/API_GetObjectIconTextureCoords
--- https://wow.gamepedia.com/API_C_Vignettes.GetVignetteInstanceID
--- https://wow.gamepedia.com/VIGNETTE_MINIMAP_UPDATED
--- https://www.curseforge.com/wow/addons/simplevingette/download
--- https://wow.gamepedia.com/API_Minimap_SetBlipTexture


--[[myTable = nil

local fa = CreateFrame("Frame")
print("frame created")
fa:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
fa:RegisterEvent("VIGNETTES_UPDATED")
fa:SetScript("OnEvent", function(self, event, vignetteInstanceID, onMiniMap, ...)
    local arg1, arg2, arg3, arg4 = ...
    if not(vignetteInstanceID and onMiniMap) then return end
    -- print(vignetteInstanceID)    
    local SV_Table = C_VignetteInfo.GetVignetteInfo(vignetteInstanceID)
    if not SV_Table then return end
    myTable = SV_Table
    local name = SV_Table.name
    local atlasName = SV_Table.atlasName
    if name then print(name.." "..atlasName) end
    PlaySound(821, "SFX")
end
)]]--