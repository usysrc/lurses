local lurses = {}

-- ANSI escape codes
local ESC = string.char(27)
local CSI = ESC .. '['

-- Screen buffer
local buffer = {}
local width, height

-- Colors
lurses.COLOR_BLACK = 0
lurses.COLOR_RED = 1
lurses.COLOR_GREEN = 2
lurses.COLOR_YELLOW = 3
lurses.COLOR_BLUE = 4
lurses.COLOR_MAGENTA = 5
lurses.COLOR_CYAN = 6
lurses.COLOR_WHITE = 7

-- Function to set terminal to non-canonical mode (no waiting for Enter key)
local function set_non_blocking_mode()
    os.execute("stty -icanon -echo min 1")
end

-- Function to restore terminal to canonical mode
local function restore_terminal_mode()
    os.execute("stty icanon echo")
end

function lurses.init()
    set_non_blocking_mode()
    io.write(CSI .. '?25l') -- Hide cursor
    io.write(CSI .. '2J')   -- Clear screen
    io.write(CSI .. 'H')    -- Move cursor to home position
    io.flush()

    -- Get terminal size
    os.execute('stty size > /tmp/ttysize')
    local f = io.open('/tmp/ttysize', 'r')
    height, width = f:read('*n', '*n')
    f:close()

    -- Initialize buffer
    for y = 1, height do
        buffer[y] = {}
        for x = 1, width do
            buffer[y][x] = { char = ' ', fg = 7, bg = 0 }
        end
    end
end

function lurses.close()
    restore_terminal_mode()
    io.write(CSI .. '?25h') -- Show cursor
    io.write(CSI .. '2J')   -- Clear screen
    io.write(CSI .. 'H')    -- Move cursor to home position
    io.write(CSI .. '0m')   -- Reset colors
    io.flush()
end

function lurses.move(y, x)
    io.write(CSI .. y .. ';' .. x .. 'H')
end

function lurses.write(str, y, x, fg, bg)
    for i = 1, #str do
        local cx = x + i - 1
        if cx <= width and y <= height then
            buffer[y][cx] = { char = str:sub(i, i), fg = fg or 7, bg = bg or 0 }
        end
    end
end

function lurses.getch()
    local char = io.read(1)
    if char == nil then
        return "ERR" -- curses returns ERR on read error or no input
    end

    if char == ESC then
        -- Check if it's the start of an escape sequence
        local ok, next_char = pcall(io.read, 1)
        if not ok or next_char ~= '[' then
            return "KEY_ESC" -- It's just the ESC key
        end

        -- Read the next character of the escape sequence
        ok, char = pcall(io.read, 1)
        if not ok then
            return "ERR"
        end

        -- Map the escape sequence to curses key names
        local key_map = {
            A = "KEY_UP",
            B = "KEY_DOWN",
            C = "KEY_RIGHT",
            D = "KEY_LEFT",
            ['5'] = "KEY_PPAGE", -- Page Up
            ['6'] = "KEY_NPAGE", -- Page Down
            ['2'] = "KEY_IC",    -- Insert
            ['3'] = "KEY_DC",    -- Delete
            H = "KEY_HOME",
            F = "KEY_END",
        }

        if key_map[char] then
            return key_map[char]
        elseif char >= '0' and char <= '9' then
            -- Consume the trailing '~' for keys that have it
            _ = io.read(1)
        end

        return "ERR" -- Unknown escape sequence
    elseif char:byte() < 32 then
        -- Map control characters to curses names
        local ctrl_map = {
            [9] = "KEY_TAB",
            [10] = "KEY_ENTER",
            [27] = "KEY_ESC",
            -- Add more as needed
        }
        return ctrl_map[char:byte()] or string.format("^%c", char:byte() + 64)
    else
        return char
    end
end

function lurses.clear()
    for y = 1, height do
        for x = 1, width do
            buffer[y][x] = { char = ' ', fg = 7, bg = 0 }
        end
    end
    -- Set a flag to force a complete redraw on next refresh
    lurses.needs_clear = true
    -- Move cursor to home position
    lurses.move(1, 1)
end

function lurses.erase()
    for y = 1, height do
        for x = 1, width do
            buffer[y][x] = { char = ' ', fg = 7, bg = 0 }
        end
    end
    -- Move cursor to home position
    lurses.move(1, 1)
end

function lurses.refresh()
    if lurses.needs_clear then
        io.write(CSI .. '2J') -- Clear entire screen
        lurses.needs_clear = false
    end
    for y = 1, height do
        lurses.move(y, 1)
        for x = 1, width do
            local cell = buffer[y][x]
            io.write(CSI .. '38;5;' .. cell.fg .. 'm')
            io.write(CSI .. '48;5;' .. cell.bg .. 'm')
            io.write(cell.char)
        end
    end
    io.flush()
end

function lurses.create_window(h, w, y, x)
    local win = {
        height = h,
        width = w,
        y = y,
        x = x,
        cursor_y = 1,
        cursor_x = 1
    }

    function win:write(str, y, x, fg, bg)
        y = y or self.cursor_y
        x = x or self.cursor_x
        for i = 1, #str do
            local cy = self.y + y - 1
            local cx = self.x + x + i - 2
            if cx <= width and cy <= height and cx > 0 and cy > 0 then
                buffer[cy][cx] = { char = str:sub(i, i), fg = fg or 7, bg = bg or 0 }
            end
        end
        self.cursor_x = x + #str
        self.cursor_y = y
    end

    return win
end

return lurses
