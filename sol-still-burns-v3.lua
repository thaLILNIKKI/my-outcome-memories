print("[sol-still-burns-v3] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

pcall(delfile, "sol-still-burns-v3.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/sol-still-burns-v3.mp3",
    "cache/sol-still-burns-v3.mp3"
)

local RS = game:GetService("ReplicatedStorage")
local GameProperties = workspace:WaitForChild("GameProperties")
local stateValue = GameProperties:WaitForChild("State")

local blazeSound = nil

local function applyReplacement()
    local ok, result = pcall(function()
        local soloTheme = RS
            :WaitForChild("ClientAssets", 10)
            :WaitForChild("Sounds", 10)
            :WaitForChild("mus", 10)
            :WaitForChild("Game", 10)
            :WaitForChild("Round", 10)
            :WaitForChild("SoloTheme", 10)

        blazeSound = soloTheme:WaitForChild("BlazeSolo", 10)
        if blazeSound and blazeSound:IsA("Sound") then
            blazeSound.SoundId = MUSIC_ID
            blazeSound.Looped = true
            blazeSound:GetPropertyChangedSignal("SoundId"):Connect(function()
                if blazeSound.SoundId ~= MUSIC_ID then
                    blazeSound.SoundId = MUSIC_ID
                end
            end)
            print("[sol-still-burns-v3] Replaced successfully")
        end
    end)
    if not ok then
        warn("[sol-still-burns-v3] Failed: " .. tostring(result))
    end
end

applyReplacement()

stateValue.Changed:Connect(function(newState)
    -- print("[sol-still-burns-v3] State: " .. tostring(newState)) "RE", "ING"
    if newState == "RE" and blazeSound and blazeSound.IsPlaying then
        blazeSound.Looped = false
        blazeSound.TimePosition = 207 -- 3:27
        -- print("[sol-still-burns-v3] Seeked to 3:27 (end)")
    end
end)

print("[sol-still-burns-v3] Ready! Made by lil2kki <3")
print("[sol-still-burns-v3] https://scriptblox.com/u/lil2kki")
print("[sol-still-burns-v3] https://github.com/thaLILNIKKI/my-outcome-memories")
