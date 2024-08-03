-- Function to set terminal to non-canonical mode (no waiting for Enter key)
local function set_non_blocking_mode()
    os.execute("stty -icanon -echo min 1")
end

-- Function to restore terminal to canonical mode
local function restore_terminal_mode()
    os.execute("stty icanon echo")
end

-- Capture a key press without blocking
local function get_key()
    local key = io.read(1) -- Read one character
    return key
end

-- Main loop to demonstrate non-blocking input
local function main()
    set_non_blocking_mode()

    print("Press 'q' to quit.")
    local key
    repeat
        key = get_key()
        if key ~= '' then
            print("Pressed key: " .. key)
        end
        os.execute("sleep 0.1") -- Small delay to prevent busy-waiting
    until key == 'q'

    restore_terminal_mode()
end

-- Ensure the terminal is restored on script exit
local success, message = pcall(main)
if not success then
    print("Error: " .. message)
end
restore_terminal_mode()
