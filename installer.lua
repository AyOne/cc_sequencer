local raw_json = http.get("https://raw.githubusercontent.com/rxi/json.lua/master/json.lua")
local json_file = fs.open("json.lua", "w")
json_file.write(raw_json.readAll())
json_file.close()

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)
print("What computer is this ?")
print("0 : Main computer")
print("1-99 : Receiver")
print("\n")
print(">>")
local cx, cy = term.getCursorPos()
term.setCursorPos(4, cy - 1)
local id = tonumber(read())

if (id == 0) then
	local raw_startup = http.get("https://raw.githubusercontent.com/AyOne/cc_sequencer/main/main.lua")
	local startup_file = fs.open("startup.lua", "w")
	startup_file.write(raw_startup.readAll())
	startup_file.close()
	term.clear()
	term.setCursorPos(1,1)
	print("Setup complete. Rebooting...")
	sleep(1)
	os.reboot()
end

local raw_startup = http.get("https://raw.githubusercontent.com/AyOne/cc_sequencer/main/receiver.lua")
local startup_file = fs.open("startup.lua", "w")
startup_file.write(raw_startup.readAll())
startup_file.close()

local raw_config = "{\"id\":"..id.."}"
local config_file = fs.open("config.json", "w")
config_file.write(raw_config)
config_file.close()

term.clear()
term.setCursorPos(1,1)
print("Setup complete. Rebooting...")
sleep(1)
os.reboot()


