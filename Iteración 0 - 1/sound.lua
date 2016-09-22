
SOUNDS = {}
_sound_index = { "A", "B", "Bb", "C", "C#", "D", "E", "Eb", "F", "F#", "G", "G#" }


function loadSounds()
    SOUNDS["A"] =  love.audio.newSource(_sound_path.."a.wav", "static")
    SOUNDS["B"] =  love.audio.newSource(_sound_path.."b.wav", "static")
    SOUNDS["Bb"] =  love.audio.newSource(_sound_path.."bb.wav", "static")
    SOUNDS["C"] =  love.audio.newSource(_sound_path.."c.wav", "static")
    SOUNDS["C#"] =  love.audio.newSource(_sound_path.."c1.wav", "static")
    SOUNDS["D"] =  love.audio.newSource(_sound_path.."d.wav", "static")
    SOUNDS["E"] =  love.audio.newSource(_sound_path.."e.wav", "static")
    SOUNDS["Eb"] =  love.audio.newSource(_sound_path.."eb.wav", "static")
    SOUNDS["F"] =  love.audio.newSource(_sound_path.."f.wav", "static")
    SOUNDS["F#"] = love.audio.newSource(_sound_path.."f1.wav", "static")
    SOUNDS["G"] = love.audio.newSource(_sound_path.."g.wav", "static")
    SOUNDS["G#"] = love.audio.newSource(_sound_path.."g1.wav", "static")
end