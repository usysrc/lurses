# Lurses

Lurses is a lightweight, pure Lua implementation inspired by the curses library. It provides basic terminal manipulation capabilities for creating text-based user interfaces.

## Features

- Terminal initialization and cleanup
- Screen buffer management
- Color support (8 colors)
- Cursor movement
- Window creation
- Keyboard input handling (including special keys)
- Screen clearing and erasing

## Usage

1. Include the lurses library in your Lua project:

```lua
local lurses = require('lurses')
```

2. Initialize the library:

```lua
lurses.init()
```

3. Use lurses functions to manipulate the terminal:

```lua
lurses.write("Hello, Lurses!", 1, 1, lurses.COLOR_GREEN, lurses.COLOR_BLACK)
lurses.refresh()
```

4. Create windows if needed:

```lua
local win = lurses.create_window(10, 20, 5, 5)
win:write("Window text", 1, 1)
```

5. Handle user input:

```lua
local key = lurses.getch()
```

6. Clean up when done:

```lua
lurses.close()
```

## Main Functions

- `lurses.init()`: Initialize the library and terminal
- `lurses.close()`: Clean up and restore terminal settings
- `lurses.write(str, y, x, fg, bg)`: Write text to the screen buffer
- `lurses.move(y, x)`: Move the cursor
- `lurses.refresh()`: Update the physical screen
- `lurses.getch()`: Get a single keypress
- `lurses.clear()`: Clear the entire screen
- `lurses.erase()`: Erase the screen content
- `lurses.create_window(h, w, y, x)`: Create a new window

## Example

An example is included in this repo. To run the example:

```shell
lua example.lua
```

## Notes

- This library uses ANSI escape codes and may not work on all terminals.
- It's designed for Unix-like systems and may require modifications for Windows.
- The library sets the terminal to non-canonical mode for immediate input handling.

## License

See `LICENSE` file.

## Contributing

Contributions welcome.

## Acknowledgements

This library is inspired by the ncurses library but implemented in pure Lua for simplicity and portability.
