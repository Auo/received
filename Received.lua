local storage = nil;
local time = nil;

local function getItem(str)
   return string.match(str, ": (.*%\|r)x");
end

local function getCount(str)
   local val = string.match(str, "x(.*)\%.");
   if val then
      return val;
   else
      return 1;
   end
end

local function getOrDefault(table, key, defaultValue)
   local val = table[key];
   if val then
      return val;
   else
      return defaultValue;
   end
end

local function start() 
   if storage ~= nil then
      print("it's already running!");
      return;
   end
   
   time = GetTime();
   storage = {};
end

local function prettyTime(seconds)   
   local minutes = math.floor(seconds / 60);
   local remaningSeconds = math.floor(seconds) - (minutes * 60);
   
   local message = "";
   
   if minutes > 0 then
      message = minutes .. " minutes";
   end
   
   if remaningSeconds > 0 then
      message = message .. " " .. remaningSeconds .. " seconds";
   end

   return message;
end

local function printInfo() 
   local seconds = GetTime() - time;
   
   for key,value in pairs(storage) do 
      print(key .. "x" .. value)
   end

   print(prettyTime(seconds));
end

local function stop() 
   time = nil;
   storage = nil;
end

SLASH_SENDER1 = '/received'
function SlashCmdList.SENDER(msg, editbox) 
   if msg == "start" then
      print("Data collection started: happy farming.");
      start();
   elseif msg == "stop" then
      print("Data collection stopped.");
      printInfo();
      stop();
   elseif msg == "status" then
      print("Your collected items so far.")
      printInfo();
   end
end

local frame = CreateFrame("frame");

local CHAT_MSG_LOOT = "CHAT_MSG_LOOT";

local function OnEvent(self, event, arg1, arg5, ...)
   if event ~= CHAT_MSG_LOOT then
      return;
   end
   
   if storage == nil then
      return;
   end
   
   local player = GetUnitName("player") .. "-" .. GetRealmName();
   
   if arg5 ~= player then
      return;
   end
   
   local key = getItem(arg1);
   local count = getCount(arg1);
   local total = getOrDefault(storage, key, 0) + count;
   storage[key] = total;
end


frame:SetScript("OnEvent", OnEvent);
frame:RegisterEvent(CHAT_MSG_LOOT);
