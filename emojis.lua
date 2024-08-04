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
    unicorn = utf8(0x1F984)
}

return emojis
