-- chat: need to change this to mouse hover and hide social button and chat frame button and ChatEditBox1
-- /run _CHATHIDE=not _CHATHIDE for i=1,NUM_CHAT_WINDOWS do for _,v in pairs{"","Tab"}do local f=_G["ChatFrame"..i..v]if _CHATHIDE then f.v=f:IsVisible()end f.ORShow=f.ORShow or f.Show f.Show=_CHATHIDE and f.Hide or f.ORShow if f.v then f:Show()end end end
local isHidden = "TRUE";
local isWorking = "FALSE";
local function eventHandler(self, event, ...)
	if(isWorking == "FALSE") then
		print("IsHidden = " .. isHidden .. " | isWorking = " .. isWorking)
		if (isHidden == "TRUE") then
			isWorking="TRUE";
			fadeOut(ChatFrame1)
			fadeOut(GeneralDockManager)
			fadeOut(ChatFrame1EditBox)
			fadeOut(QuickJoinToastButton)
			fadeOut(ChatFrameChannelButton)
			fadeOut(ChatFrameMenuButton)
			isHidden = "FALSE";
			isWorking = "FALSE";
		else
			isWorking="TRUE"
			fadeIn(ChatFrame1)
			fadeIn(GeneralDockManager)
			fadeIn(ChatFrame1EditBox)
			fadeIn(QuickJoinToastButton)
			fadeIn(ChatFrameChannelButton)	w
			fadeIn(ChatFrameMenuButton)
			isHidden = "TRUE";
			isWorking = "FALSE";
		end
	end
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

ChatFrame1:SetScript("OnEnter", eventHandler);
--ChatFrame1:SetScript("OnLeave", eventHandler);
GeneralDockManager:SetScript("OnEnter",eventHandler);
GeneralDockManager:SetScript("OnLeave",eventHandler);

eventHandler();

-- /run QuickJoinToastButton:Hide(); ChatFrameChannelButton:Hide(); ChatFrameToggleVoiceDeafenButton:Hide(); ChatFrameToggleVoiceMuteButton:Hide(); ChatFrameMenuButton:Hide();ChatFrame1EditBox:Hide();
-- /run _CHATHIDE=not _CHATHIDE for i=1,NUM_CHAT_WINDOWS do for _,v in pairs{"","Tab"}do local f=_G["ChatFrame"..i..v]if _CHATHIDE then f.v=f:IsVisible()end f.ORShow=f.ORShow or f.Show f.Show=_CHATHIDE and f.Hide or f.ORShow if f.v then f:Show()end end end
