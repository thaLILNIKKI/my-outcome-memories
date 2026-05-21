print("[so-dont-blink] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/so-dont-blink.mp3",
    "cache/so-dont-blink.mp3"
)

local RS = game:GetService("ReplicatedStorage")
local GameProperties = workspace:WaitForChild("GameProperties")
local stateValue = GameProperties:WaitForChild("State")

local sonicSound = nil

local function applyReplacement()
    local ok, result = pcall(function()
        local soloTheme = RS
            :WaitForChild("ClientAssets", 10)
            :WaitForChild("Sounds", 10)
            :WaitForChild("mus", 10)
            :WaitForChild("Game", 10)
            :WaitForChild("Round", 10)
            :WaitForChild("SoloTheme", 10)

        sonicSound = soloTheme:WaitForChild("SonicSolo", 10)
        if sonicSound and sonicSound:IsA("Sound") then
            sonicSound.SoundId = MUSIC_ID
            sonicSound.Looped = true
            sonicSound:GetPropertyChangedSignal("SoundId"):Connect(function()
                if sonicSound.SoundId ~= MUSIC_ID then
                    sonicSound.SoundId = MUSIC_ID
                end
            end)
            print("[so-dont-blink] Replaced successfully")
        end
    end)
    if not ok then
        warn("[so-dont-blink] Failed: " .. tostring(result))
    end
end

applyReplacement()

stateValue.Changed:Connect(function(newState)
    if newState == "RE" and sonicSound and sonicSound.IsPlaying then
        sonicSound.Looped = false
        sonicSound.TimePosition = 289 -- 4:49
    end
end)

print("[so-dont-blink] Ready! Made by lil2kki <3")
print("[so-dont-blink] https://github.com/thaLILNIKKI/my-outcome-memories")
