local function utf8(decimal)
    local bytemarkers = { { 0x7FF, 192 }, { 0xFFFF, 224 }, { 0x1FFFFF, 240 } }
    if decimal < 128 then return string.char(decimal) end
    local charbytes = {}
    for bytes, vals in ipairs(bytemarkers) do
        if decimal <= vals[1] then
            for b = bytes + 1, 2, -1 do
                local mod = decimal % 64
                decimal = (decimal - mod) / 64
                charbytes[b] = string.char(128 + mod)
            end
            charbytes[1] = string.char(vals[2] + decimal)
            return table.concat(charbytes)
        end
    end
end

-- Currently incomplete list of emojis
local emojis = {
    -- Smileys & Emotion
    grinning_face = utf8(0x1F600),
    grinning_face_with_big_eyes = utf8(0x1F603),
    grinning_face_with_smiling_eyes = utf8(0x1F604),
    beaming_face_with_smiling_eyes = utf8(0x1F601),
    grinning_squinting_face = utf8(0x1F606),
    grinning_face_with_sweat = utf8(0x1F605),
    rolling_on_the_floor_laughing = utf8(0x1F923),
    face_with_tears_of_joy = utf8(0x1F602),
    slightly_smiling_face = utf8(0x1F642),
    upside_down_face = utf8(0x1F643),
    winking_face = utf8(0x1F609),
    smiling_face_with_smiling_eyes = utf8(0x1F60A),
    smiling_face_with_halo = utf8(0x1F607),
    smiling_face_with_hearts = utf8(0x1F970),
    smiling_face_with_heart_eyes = utf8(0x1F60D),
    star_struck = utf8(0x1F929),
    face_blowing_a_kiss = utf8(0x1F618),
    kissing_face = utf8(0x1F617),
    smiling_face = utf8(0x263A),
    kissing_face_with_closed_eyes = utf8(0x1F61A),
    face_savoring_food = utf8(0x1F60B),
    face_with_tongue = utf8(0x1F61B),
    winking_face_with_tongue = utf8(0x1F61C),
    zany_face = utf8(0x1F92A),
    squinting_face_with_tongue = utf8(0x1F61D),
    money_mouth_face = utf8(0x1F911),
    hugging_face = utf8(0x1F917),
    face_with_hand_over_mouth = utf8(0x1F92D),
    shushing_face = utf8(0x1F92B),
    thinking_face = utf8(0x1F914),
    zipper_mouth_face = utf8(0x1F910),

    -- Animals & Nature
    monkey_face = utf8(0x1F435),
    monkey = utf8(0x1F412),
    gorilla = utf8(0x1F98D),
    orangutan = utf8(0x1F9A7),
    dog_face = utf8(0x1F436),
    dog = utf8(0x1F415),
    guide_dog = utf8(0x1F9AE),
    poodle = utf8(0x1F429),
    wolf = utf8(0x1F43A),
    fox = utf8(0x1F98A),
    raccoon = utf8(0x1F99D),
    cat_face = utf8(0x1F431),
    cat = utf8(0x1F408),
    lion = utf8(0x1F981),
    tiger_face = utf8(0x1F42F),
    tiger = utf8(0x1F405),
    leopard = utf8(0x1F406),
    horse_face = utf8(0x1F434),
    horse = utf8(0x1F40E),
    unicorn = utf8(0x1F984),
    zebra = utf8(0x1F993),
    deer = utf8(0x1F98C),
    bison = utf8(0x1F9AC),
    cow_face = utf8(0x1F42E),
    ox = utf8(0x1F402),
    water_buffalo = utf8(0x1F403),
    cow = utf8(0x1F404),
    pig_face = utf8(0x1F437),
    pig = utf8(0x1F416),
    boar = utf8(0x1F417),
    pig_nose = utf8(0x1F43D),

    -- Food & Drink
    grapes = utf8(0x1F347),
    melon = utf8(0x1F348),
    watermelon = utf8(0x1F349),
    tangerine = utf8(0x1F34A),
    lemon = utf8(0x1F34B),
    banana = utf8(0x1F34C),
    pineapple = utf8(0x1F34D),
    mango = utf8(0x1F96D),
    red_apple = utf8(0x1F34E),
    green_apple = utf8(0x1F34F),
    pear = utf8(0x1F350),
    peach = utf8(0x1F351),
    cherries = utf8(0x1F352),
    strawberry = utf8(0x1F353),
    hamburger = utf8(0x1F354),
    pizza = utf8(0x1F355),

    -- Travel & Places
    automobile = utf8(0x1F697),
    taxi = utf8(0x1F695),
    bus = utf8(0x1F68C),
    trolleybus = utf8(0x1F68E),
    racing_car = utf8(0x1F3CE),
    police_car = utf8(0x1F693),
    ambulance = utf8(0x1F691),
    fire_engine = utf8(0x1F692),
    minibus = utf8(0x1F690),
    truck = utf8(0x1F69A),
    articulated_lorry = utf8(0x1F69B),
    tractor = utf8(0x1F69C),
    motorcycle = utf8(0x1F3CD),
    bicycle = utf8(0x1F6B2),

    -- Activities
    soccer_ball = utf8(0x26BD),
    basketball = utf8(0x1F3C0),
    american_football = utf8(0x1F3C8),
    baseball = utf8(0x26BE),
    softball = utf8(0x1F94E),
    tennis = utf8(0x1F3BE),
    volleyball = utf8(0x1F3D0),
    rugby_football = utf8(0x1F3C9),

    -- Objects
    mobile_phone = utf8(0x1F4F1),
    laptop = utf8(0x1F4BB),
    desktop_computer = utf8(0x1F5A5),
    printer = utf8(0x1F5A8),
    keyboard = utf8(0x2328),
    computer_mouse = utf8(0x1F5B1),
    trackball = utf8(0x1F5B2),
    joystick = utf8(0x1F579),

    -- Symbols
    heart = utf8(0x2764),
    orange_heart = utf8(0x1F9E1),
    yellow_heart = utf8(0x1F49B),
    green_heart = utf8(0x1F49A),
    blue_heart = utf8(0x1F499),
    purple_heart = utf8(0x1F49C),
    black_heart = utf8(0x1F5A4),
    broken_heart = utf8(0x1F494),
    heavy_check_mark = utf8(0x2714),
    check_mark_button = utf8(0x2705),
    cross_mark = utf8(0x274C),
    cross_mark_button = utf8(0x274E),
    question_mark = utf8(0x2753),
    exclamation_mark = utf8(0x2757),
}

return emojis
