received.ui = {};

received.ui.createUI = function()
   local container = CreateFrame("Frame", "ReceiveUIContainer", UIParent);
   container:SetSize(400, 210);
   container:SetBackdrop({
         bgFile = "Interface/FrameGeneral/UI-Background-Rock",
         edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
         tile = true, tileSize = 192, edgeSize = 16,
         insets = {left = 4, right = 4, top = 4, bottom = 4}});
   container:SetMovable(true);
   container:EnableMouse(true);
   container:SetPoint("CENTER");
   container:SetScript('OnMouseDown', function(self)
         self:StartMoving();
   end);
   container:SetScript('OnMouseUp', function(self)
         self:StopMovingOrSizing();
   end);
   
   -- close button
   container.close = CreateFrame("Button", "ReceiveUIClose", container, "UIPanelButtonTemplate");
   container.close:SetSize(20, 20);
   container.close:SetText("x");
   container.close:SetPoint("TOPRIGHT", -5, -8);
   container.close:SetScript("OnClick", function()
         container:Hide();
   end);

   -- Start button
   container.start = CreateFrame("Button", "ReceiveUIStart", container, "UIPanelButtonTemplate");
   container.start:SetSize(70, 20);
   container.start:SetText("Start");
   container.start:SetPoint("TOPLEFT", 10, -8);

   -- Stop button
   container.stop = CreateFrame("Button", "ReceiveUIStop", container, "UIPanelButtonTemplate");
   container.stop:SetSize(70, 20);
   container.stop:SetText("Stop");
   container.stop:SetPoint("TOPLEFT", 90, -8);
   
   -- result
   container.result = CreateFrame("Frame", "ReceiveUIEditBox", container);
   container.result:SetPoint("TOP", 0, -30);
   container.result:SetSize(400, 180);
   
   container.result:SetBackdrop({
         bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
         edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
         edgeSize = 16,
         insets = { left = 8, right = 6, top = 8, bottom = 8 },
   });
   
   -- ScrollFrame
   container.result.scrollFrame = CreateFrame("ScrollFrame", "ReceiveUIScrollFrame", container.result, "UIPanelScrollFrameTemplate");
   container.result.scrollFrame:SetPoint("LEFT", 16, 0);
   container.result.scrollFrame:SetPoint("RIGHT", -32, 0);
   container.result.scrollFrame:SetPoint("TOP", 0, -10);
   container.result.scrollFrame:SetPoint("BOTTOM", container.result, "BOTTOM", 0, 10);
   
   -- EditBox
   container.result.editBox = CreateFrame("EditBox", "ReceiveUIEditBox", container.result.scrollFrame);
   container.result.editBox:SetSize(container.result.scrollFrame:GetSize());
   container.result.editBox:SetMultiLine(true);
   container.result.editBox:SetAutoFocus(false);
   container.result.editBox:SetFontObject("ChatFontNormal")
   container.result.editBox:SetScript("OnEscapePressed", function()
      container.result.editBox:ClearFocus();
    end);
   
   container.result.scrollFrame:SetScrollChild(container.result.editBox);
   
   -- don't show container initially
   container:Hide();
   return container;
end
