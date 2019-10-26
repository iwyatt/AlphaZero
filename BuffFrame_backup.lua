local mySpecialFrame = CreateFrame("Frame")
mySpecialFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
mySpecialFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
mySpecialFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
mySpecialFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
mySpecialFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
mySpecialFrame:RegisterEvent("PLAYER_LOGIN")
mybuffFrame = nil
mynamePalte = nil

-- testing
BuffFrame:SetScript("OnLoad", function()
	BuffFrame:SetAlpha(0.25)
	BuffFrame:SetScale(0.87)
	--if CastingBarFrame == nil then print("no casting bar frame!") return end
	BuffFrame:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT", 15,-10)
end)

mySpecialFrame:SetScript("OnEvent", function(self, event, unit, ...)
  if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" then
	--if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then BuffFrame:ClearAllPoints() end
	BuffFrame:SetAlpha(0.25)
	BuffFrame:SetScale(0.87)
	if CastingBarFrame == nil then print("no casting bar frame!") return end
	BuffFrame:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT", 15,-10)
  end
  if event == "PLAYER_REGEN_ENABLED" then
	-- print("event: player regen enabled")
	BuffFrame:SetAlpha(0.25)
	BuffFrame:SetScale(0.87)
	BuffFrame:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT", 15,-10)
  end
 if event == "PLAYER_REGEN_DISABLED" or event == "NAME_PLATE_UNIT_ADDED" then
	if C_NamePlate.GetNamePlateForUnit("player", issecure()) == nil then return end
	--print("event: player regen disabled")
	BuffFrame:SetAlpha(0.75)
	--BuffFrame:ClearAllPoints()
	--BuffFrame:SetPoint("TOPRIGHT",NamePlatePlayerResourceFrame,"BOTTOMRIGHT", 20,-15)
	BuffFrame:SetPoint("TOPRIGHT",C_NamePlate.GetNamePlateForUnit("player"):GetName(),"BOTTOMRIGHT", 15,-10)
  end
  if event == "NAME_PLATE_UNIT_REMOVED" then
	if not UnitAffectingCombat("player") then return end
	-- print("event: name plate removed")
	-- BuffFrame:ClearAllPoints();
	--BuffFrame:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT", 20,-10)
  end
end
)

-- set debuff position
local myDebuffFrame = CreateFrame("Frame")
myDebuffFrame:RegisterEvent("UNIT_AURA")
myDebuffFrame:HookScript("OnEvent", function(self, event, ...)
	for i = 1,40 do
		local buttonName = "DebuffButton"
		local buffName = buttonName..i
		local buff = _G[buffName]
		if buff == nil then return end
		if UnitAffectingCombat("player") then
			if C_NamePlate.GetNamePlateForUnit("player", issecure()) == nil then return end
			buff:SetPoint("TOPRIGHT",C_NamePlate.GetNamePlateForUnit("player"):GetName(),"TOPRIGHT", (i*40)-40, 75)
		else
			buff:SetPoint("TOPRIGHT",CastingBarFrame,"TOPRIGHT", (i*40)-40, 75)
		end
	end
end
)


-- blizzard buff debuff positioning: https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/BuffFrame.lua

-- DebuffButton1:SetPoint("TOPRIGHT",NamePlatePlayerResourceFrame,"TOPRIGHT", (1 * 20), 75)
-- UnitAura("player", 1 ,"HELPFUL")

-- ##Debuffs
-- RegisterUnitEvent("UNIT_AURA","player") https://us.battle.net/forums/en/wow/topic/20744274690
-- event info: https://wow.gamepedia.com/UNIT_AURA
-- Unit Aura returns, filters https://wow.gamepedia.com/API_UnitAura


	--BuffFrame:SetPoint("TOPRIGHT",SpellActivationOverlayFrame,"BOTTOMRIGHT", 15,-173)

  -- if event == "NAME_PLATE_UNIT_ADDED" and C_NamePlate.GetNamePlateForUnit("player", issecure()) ~= nil then
	-- BuffFrame:SetAlpha(0.75)
	-- --BuffFrame:SetPoint("TOPRIGHT",C_NamePlate.GetNamePlateForUnit("player",issecure()),"BOTTOMRIGHT")
	-- BuffFrame:SetPoint("TOPRIGHT",NamePlatePlayerResourceFrame,"BOTTOMRIGHT",0,-15)
	
	-- az_playerNamePlate = C_NamePlate.GetNamePlateForUnit("player", issecure());
  -- end




--BuffFrame:SetPoint("TOPRIGHT",ClassNameplateManaBarFrame,"BOTTOMRIGHT", 0,0)

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