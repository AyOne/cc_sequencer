local modem = peripheral.find("modem")
local json = require("json")


local config_file = fs.open("config.json", "r")
local config = json.decode(config_file.readAll())
config_file.close()
modem.open(826)




for i in {"left", "right", "top", "bottom", "front", "back"} do
	redstone.setOutput(i, false)
end

redstone.setOutput("left", false)



while true do
	local event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
	local msg = json.decode(message)
	if msg.id == config.id then
		redstone.setOutput(msg.side, msg.state)
	end
end