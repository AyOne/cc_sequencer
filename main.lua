local modem = peripheral.find("modem")
local json = require("json")
local config_file = fs.open("config.json", "r")
local config = json.decode(config_file.readAll())
config_file.close()


function main()
	while true do
		loop(1, config.sequence)
		sleep(config.loopDelay / 1000)
	end
end


function send_signal(id, side, state)
	local msg = {
		id = id,
		side = side,
		state = state
	}
	msg = json.encode(msg)
	modem.transmit(826, 0, msg)
end

function loop(count,sequence)
	for j=1, count do
		for i = 1, #sequence do
			execute(sequence[i])
			if (sequence[i].deplay ~= -1 or sequence[i].deplay ~= nil) then
				sleep(sequence[i].delay / 1000)
			end
		end
	end
end


function execute(node)
	if (node.type == "loop") then
		return loop(node.length, node.sequence)
	elseif (node.type == "signal") then
		return send_signal(node.id, node.side, node.state)
	end
end


main()