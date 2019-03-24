received = {};

local frame = CreateFrame("Frame");
local storage = nil;
local time = nil;
local CHAT_MSG_LOOT = "CHAT_MSG_LOOT";
local PLAYER_ENTERING_WORLD = "PLAYER_ENTERING_WORLD";
local ui = nil; 

local function start() 
   if storage ~= nil then
      print("it's already running!");
      return;
   end
   
   time = GetTime();
   storage = {};
end

local function stop() 
   time = nil;
   storage = nil;
end

SLASH_RECEIVED1 = '/received'
SlashCmdList["RECEIVED"] = function(message)
   ui:Show();
end

local function OnEvent(self, event, arg1, arg5, ...)
   if event == PLAYER_ENTERING_WORLD then
      ui = received.ui.createUI();

      ui.start:SetScript("OnClick", function()
         print("start");
         start();
      end);
      
      ui.stop:SetScript("OnClick", function()
         print("stop");
         ui.result.editBox:SetText(received.helper.prettyResult(time, storage));
         stop();
      end);

      frame:UnRegisterEvent(PLAYER_ENTERING_WORLD);
   elseif event ~= CHAT_MSG_LOOT then
      return;
   end
   
   if storage == nil then
      return;
   end
   
   -- store this value, and reuse
   local player = GetUnitName("player") .. "-" .. GetRealmName();
   
   if arg5 ~= player then
      return;
   end
   
   local key = received.helper.getItem(arg1);
   local count = received.helper.getCount(arg1);
   local total = received.helper.getOrDefault(storage, key, 0) + count;

   storage[key] = total;
end

frame:SetScript("OnEvent", OnEvent);
frame:RegisterEvent(CHAT_MSG_LOOT);
frame:RegisterEvent(PLAYER_ENTERING_WORLD);
