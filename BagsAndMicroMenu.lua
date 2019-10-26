-- set transparency on bags and micromenu

-- set transparency on bags
local kids = {MicroButtonAndBagsBar:GetChildren()}
for _, child in ipairs(kids) do
	child:SetAlpha(0.1)
end

-- micromenu
-- hide background art:
MicroButtonAndBagsBar.MicroBagBar:Hide(1)

-- set transparency on icons
CharacterMicroButton:SetAlpha(0.1)
SpellbookMicroButton:SetAlpha(0.1)
TalentMicroButton:SetAlpha(0.1)
QuestLogMicroButton:SetAlpha(0.1)
LFDMicroButton:SetAlpha(0.1)
CollectionsMicroButton:SetAlpha(0.1)
StoreMicroButton:SetAlpha(0.1)
MainMenuMicroButton:SetAlpha(0.1)
AchievementMicroButton:SetAlpha(0.1)
GuildMicroButton:SetAlpha(0.1)
EJMicroButton:SetAlpha(0.1)

--show / hide on mouseover
local function showFoo(self)
	MicroButtonAndBagsBar.MicroBagBar:Show()
	CharacterMicroButton:SetAlpha(1)
	SpellbookMicroButton:SetAlpha(1)
	TalentMicroButton:SetAlpha(1)
	AchievementMicroButton:SetAlpha(1)
	QuestLogMicroButton:SetAlpha(1)
	GuildMicroButton:SetAlpha(1)
	LFDMicroButton:SetAlpha(1)
	CollectionsMicroButton:SetAlpha(1)
	EJMicroButton:SetAlpha(1)
	StoreMicroButton:SetAlpha(1)
	MainMenuMicroButton:SetAlpha(1)
end
 
local function hideFoo(self)
	MicroButtonAndBagsBar.MicroBagBar:Hide()
	CharacterMicroButton:SetAlpha(0.1)
	SpellbookMicroButton:SetAlpha(0.1)
	TalentMicroButton:SetAlpha(0.1)
	AchievementMicroButton:SetAlpha(0.1)
	QuestLogMicroButton:SetAlpha(0.1)
	GuildMicroButton:SetAlpha(0.1)
	LFDMicroButton:SetAlpha(0.1)
	CollectionsMicroButton:SetAlpha(0.1)
	EJMicroButton:SetAlpha(0.1)
	StoreMicroButton:SetAlpha(0.1)
	MainMenuMicroButton:SetAlpha(0.1)
end

function fadeIn(frame)
	local ticker = C_Timer.NewTicker(0.01, function()
	frame:SetAlpha(frame:GetAlpha()+0.09)
	end, 50)
end

function fadeOut(frame)
	local ticker = C_Timer.NewTicker(0.01, function()
	frame:SetAlpha(frame:GetAlpha()-0.09)
	end, 50)	
end

MicroButtonAndBagsBar:SetScript("OnEnter", showFoo)
MicroButtonAndBagsBar:SetScript("OnLeave", hideFoo)


