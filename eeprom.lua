local cl = component.list
local cp = component.proxy
local gpu = cp(cl("gpu")())

local resX, resY = gpu.getResolution()

local bw
if gpu.getDepth() > 1 then
	bw = false
else
	bw = true
end

local function input(x, y)
    local output = ""
    local running = true
    
    while running do
        local e, _, c, _ = computer.pullSignal()
        if e == "key_down" then
            if c == 13 then
                running = false
            elseif string.match(string.char(c), "^[0-9a-zA-ZабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ/.]$") then
                output = output .. string.char(c)
            end
            
            gpu.set(x, y, ">" .. output)
        end
    end
    
    return output
end

while true do
	if bw == true then
		gpu.setBackground(0x000000)
	else
		gpu.setBackground(0xFF0000)
	end
	gpu.setForeground(0xFFFFFF)
	gpu.fill(1, 1, resX, resY, " ")
	gpu.set(1, 1, "Компьютер заблокирован")
	gpu.set(1, 2, "Для разблокировки:")
	gpu.set(1, 3, "  Пади туда, не знаю куда")
	gpu.set(1, 4, "  Заплати стока, не знаю скока")
	gpu.set(1, 5, "  Получишь то, не знаю шо -")
	gpu.set(1, 6, "  Напиши сюда")
	local pwd = input(1, 7)
	if pwd == "/../yadebil.//." then
		error("Поздравляем, это правильный пароль, но вас НАДУРИЛИ!!! АХАХАХАХАХАХАХХАХАХАХАХАХХАХАХАХАХХАХХАХАХХАХАХХХААХАХХАХА!!!!!", 0)
	end
end
