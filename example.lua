local lurses = require('lurses')

lurses.init()
lurses.clear()

local win = lurses.create_window(30, 30, 0, 0)
win:write("Hello, lurses!", 5, 5, lurses.COLOR_GREEN, lurses.COLOR_BLACK)

lurses.refresh()
local ch = lurses.getch()
if ch == "q" then
    lurses.close()
    return
end

local x, y = 5, 5
win:write("@", x, y, lurses.COLOR_GREEN, lurses.COLOR_BLACK)
while true do
    local ch = lurses.getch()
    if ch == "KEY_LEFT" then x = x - 1 end
    if ch == "KEY_RIGHT" then x = x + 1 end
    if ch == "KEY_DOWN" then y = y + 1 end
    if ch == "KEY_UP" then y = y - 1 end
    if ch == "q" then break end
    lurses.clear()
    win:write("@", y, x, lurses.COLOR_GREEN, lurses.COLOR_BLACK)
    lurses.refresh()
end

lurses.close()
