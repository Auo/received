received.helper = {};

received.helper.getItem = function(str)
    return string.match(str, ": (.*%\|r)");
 end
 
 received.helper.getCount = function(str)
    local val = string.match(str, "x(.*)\%.");
    if val then
       return val;
    else
       return 1;
    end
 end
 
 received.helper.getOrDefault = function(table, key, defaultValue)
    local val = table[key];
    if val then
       return val;
    else
       return defaultValue;
    end
 end

 received.helper.prettyTime = function(seconds)   
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

 received.helper.prettyResult = function(startTime, storage) 
    local time = received.helper.prettyTime(GetTime() - startTime);
    local result = "Total time: " .. time .. "\n";

    for key,value in pairs(storage) do 
        result = result .. key .. "x" .. value .."\n";
    end

    return result;
 end