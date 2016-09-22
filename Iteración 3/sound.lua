
SOUNDS = {}
_sound_path = "/sounds"
_instr_index = { "Piano", "Double_Bass", "Nylon", "Violin", "Violin_Short", "Chimes", "Chimes_Short" }

_sound_index = { "A#", "A", "B", "C#", "C", "D#", "D", "E", "F#", "F", "G#", "G" }

function loadSounds()

    for i = 1, #_instr_index do
        local init = {}
        for j = 1, #_sound_index do
            init[j] = nil
        end
        table.insert(SOUNDS, init)
    end

    for i = 1, #_instr_index do
        for j = 1, #_sound_index do
            SOUNDS[i][j] = love.audio.newSource(_sound_path.."/".._instr_index[i].."/".._sound_index[j]..".wav", "static")
        end
    end

    local instr = "\t"
    print("Instruments: ")
    
    for i = 1, #_sound_index do
        instr = instr.._sound_index[i].." "
    end

    for i = 1, #_instr_index do
        print("\t".._instr_index[i])
        print(instr.."\n")
    end
end