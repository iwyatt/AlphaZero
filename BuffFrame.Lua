local mySpecialFrame = CreateFrame("Frame")
mySpecialFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
mySpecialFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
mySpecialFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
mySpecialFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
mySpecialFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
mySpecialFrame:RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_REMOVED")
mySpecialFrame:RegisterEvent("PLAYER_LOGIN")
mySpecialFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
mySpecialFrame:RegisterEvent("UNIT_AURA")

-- triggers to evaluate position of buff frame
BuffFrame:SetScript("OnLoad", function()
    AnchorBuffsOnCastingBar(self)
end)

mySpecialFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5 = ...

	-- player out of combat
	if event == "PLAYER_REGEN_ENABLED" then
		if C_NamePlate.GetNamePlateForUnit("player") ~= nil then return end
		AnchorBuffsOnCastingBar(self)
	end

	-- put buffs on castbar when name plate removed, leading indicator of out of combat
	if event == "NAME_PLATE_UNIT_REMOVED" or event == "FORBIDDEN_NAME_PLATE_UNIT_REMOVED" then
		-- if nameplate removed but player might still be in combat or never entered combat to begin with
		if C_NamePlate.GetNamePlateForUnit("player") == nil then return end
		if arg1 == tostring(C_NamePlate.GetNamePlateForUnit("player"):GetName()):lower() then
			AnchorBuffsOnCastingBar(self)
		end
    end

	-- put buffs on nameplate when player in combat or name plate added
	if event == "PLAYER_REGEN_DISABLED" or event == "NAME_PLATE_UNIT_ADDED" then

		-- end early if no player name plate to prevent false positives
        if C_NamePlate.GetNamePlateForUnit("player", issecure()) == nil or
            UnitAffectingCombat("player") == FALSE then return end
		
		--AnchorCastingBarOnPlayerNamePlate(self)
		-- set position of buffs
		if arg1 == tostring(C_NamePlate.GetNamePlateForUnit("player"):GetName()):lower() then
			AnchorBuffsOnPlayerNamePlate(self)
		end
		--consider adding a return here
    end

	-- when initialization and ui start up
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" or event ==
        "ZONE_CHANGED_NEW_AREA" then
        BuffFrame:SetScale(0.88)
		AnchorBuffsOnCastingBar(self)
    end
end)

-- put buffs on casting bar
function AnchorBuffsOnCastingBar(self, event)
    BuffFrame:SetPoint("TOPRIGHT", CastingBarFrame, "BOTTOMRIGHT", 15, -10)
	BuffFrame:SetAlpha(0.22)
end

-- put buffs on player name plate
function AnchorBuffsOnPlayerNamePlate(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5 = ...
	BuffFrame:SetPoint("TOPRIGHT", C_NamePlate.GetNamePlateForUnit("player"), "BOTTOMRIGHT", 0, 15)
	BuffFrame:SetAlpha(0.75)
end

-- set debuff position
local myDebuffFrame = CreateFrame("Frame")
myDebuffFrame:RegisterEvent("UNIT_AURA")
myDebuffFrame:SetScript("OnEvent", function(self, event, ...)
	local buttonName = "DebuffButton"
	for i = 1, 40 do
        local buffName = buttonName .. i
        local buff = _G[buffName]
        if buff == nil then return end
		buff:SetAlpha(0.75)
		buff:SetPoint("TOPRIGHT", BuffFrame, "TOPRIGHT", (i * 40) - 15, 85)
	end
end
)

--unused
function AnchorCastingBarOnPlayerNamePlate(self, event)
    CastingBarFrame:SetPoint("TOPRIGHT", C_NamePlate.GetNamePlateForUnit("player"), "BOTTOMRIGHT", 0, 15)
end
-- blizzard buff debuff positioning: https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/BuffFrame.lua

-- DebuffButton1:SetPoint("TOPRIGHT",NamePlatePlayerResourceFrame,"TOPRIGHT", (1 * 20), 75)
-- UnitAura("player", 1 ,"HELPFUL")

-- ##Debuffs
-- RegisterUnitEvent("UNIT_AURA","player") https://us.battle.net/forums/en/wow/topic/20744274690
-- event info: https://wow.gamepedia.com/UNIT_AURA
-- Unit Aura returns, filters https://wow.gamepedia.com/API_UnitAura

-- BuffFrame:SetPoint("TOPRIGHT",SpellActivationOverlayFrame,"BOTTOMRIGHT", 15,-173)

-- if event == "NAME_PLATE_UNIT_ADDED" and C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
-- BuffFrame:SetAlpha(0.75)
-- --BuffFrame:SetPoint("TOPRIGHT",C_NamePlate.GetNamePlateForUnit("player",issecure()),"BOTTOMRIGHT")
-- BuffFrame:SetPoint("TOPRIGHT",NamePlatePlayerResourceFrame,"BOTTOMRIGHT",0,-15)

-- az_playerNamePlate = C_NamePlate.GetNamePlateForUnit("player", issecure());
-- end

-- BuffFrame:SetPoint("TOPRIGHT",ClassNameplateManaBarFrame,"BOTTOMRIGHT", 0,0)

-- local function SetupPlayerNamePlate(frame, setupOptions, frameOptions)
-- if not UnitIsUnit(frame.displayedUnit.unit, UnitName("player")) then return end
-- local parent = frame:GetParent()
-- local nameplate = C_NamePlate.GetNamePlateForUnit("player")
-- print(parent:GetName(),frame:Getname(),nameplate:GetName())
-- --apply setpoint to parent
-- print(parent:GetPoint())
-- --parent:ClearAllPoints()
-- --parent:SetPoint("CENTER")
-- end
-- hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", SetupPlayerNamePlate)

-- mySpecialFrame:SetScript("OnEvent", function(self, event, ...)
-- print(event)
-- if event ~= "PLAYER_REGEN_ENABLED" then return end
-- BuffFrame:SetAlpha(0.10)
-- --BuffFrame:SetPoint("TOPRIGHT",C_NamePlate.GetNamePlateForUnit("player"):GetName(),"BOTTOMRIGHT")
-- end)

-- local function SetupPlayerNamePlate(frame, setupOptions, frameOptions)
-- --if not UnitIsUnit(frame.displayedUnit, "player") then return end
-- if not UnitIsPlayer(frame.unit) then return end
-- print(frame.unit)
-- local parent = frame:GetParent()
-- local nameplate = C_NamePlate.GetNamePlateForUnit("player")
-- --print(parent:GetName(),frame:Getname(),nameplate:GetName())
-- --apply setpoint to parent
-- --print(parent:GetPoint())
-- --parent:ClearAllPoints()
-- --parent:SetPoint("CENTER")
-- BuffFrame:SetAlpha(0.50)
-- BuffFrame:SetPoint("BOTTOMRIGHT",nameplate,"BOTTOMRIGHT")
-- end
-- --hooksecurefunc("NamePlateDriverMixin:SetupClassNameplateBars", SetupPlayerNamePlate)
-- ---NamePlateDriverMixin:HookScript("OnNamePlateAdded",SetupPlayerNamePlate)
-- --/run a =C_NamePlate.GetNamePlateForUnit("player"):GetName();BuffFrame:SetPoint("TOPRIGHT",a,"BOTTOMRIGHT")
-- BuffFrame:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT",25,-20)