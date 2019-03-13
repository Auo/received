local storage = nil;
local time = nil;

local function getItem(str)
   return string.match(str, "\%[([^\%]]+)");
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

local function stop() 
   for key,value in pairs(storage) do 
      print(key, value)
   end
   
   local seconds = GetTime() - time;
   print(seconds);
   time = nil;
   storage = nil;
end

SLASH_SENDER1 = '/receive'
function SlashCmdList.SENDER(msg, editbox) 
   if msg == "start" then
      print("start");
      start();
   elseif msg == "stop" then
      print("stop");
      stop();
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
   --print("key: " .. key);
   --print("count: " .. count);
   
   local total = getOrDefault(storage, key, 0) + count;
   --print("total: " .. total);
   
   storage[key] = total;
end


frame:SetScript("OnEvent", OnEvent);
frame:RegisterEvent(CHAT_MSG_LOOT);