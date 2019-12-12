bitser = require 'lib/bitser' 

channel = ...


-- this is the basic call to save the file when the thread is started
local status, err = pcall(function()
    print("Waiting")
    data = channel:pop()
    print("Saving..")
    if (data[1] == "game") then
    	bitser.dumpLoveFile('save-data.dat', data[2])
    end
    if (data[1] == "achievements") then
    	bitser.dumpLoveFile("achievement-data.dat", data[2])
    end
    print("Finished saving")
end)
print(status, err)