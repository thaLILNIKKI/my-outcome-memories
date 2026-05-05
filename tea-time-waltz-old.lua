print("[tea-time-waltz-old] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

pcall(delfile, "cache/tea-time-waltz-old.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/tea-time-waltz-old.mp3",
    "cache/tea-time-waltz-old.mp3"
)

local RS = game:GetService("ReplicatedStorage")
local GameProperties = workspace:WaitForChild("GameProperties")
local stateValue = GameProperties:WaitForChild("State")

local creamSound = nil

local function applyReplacement()
    local ok, result = pcall(function()
        local soloTheme = RS
            :WaitForChild("ClientAssets", 10)
            :WaitForChild("Sounds", 10)
            :WaitForChild("mus", 10)
            :WaitForChild("Game", 10)
            :WaitForChild("Round", 10)
            :WaitForChild("SoloTheme", 10)

        creamSound = soloTheme:WaitForChild("CreamSolo", 10)
        if creamSound and creamSound:IsA("Sound") then
            creamSound.SoundId = MUSIC_ID
            creamSound.Looped = true
            creamSound:GetPropertyChangedSignal("SoundId"):Connect(function()
                if creamSound.SoundId ~= MUSIC_ID then
                    creamSound.SoundId = MUSIC_ID
                end
            end)
            print("[tea-time-waltz-old] Replaced successfully")
        end
    end)
    if not ok then
        warn("[tea-time-waltz-old] Failed: " .. tostring(result))
    end
end

applyReplacement()

stateValue.Changed:Connect(function(newState)
    -- print("[tea-time-waltz-old] State: " .. tostring(newState))
    if newState == "RE" and creamSound and creamSound.IsPlaying then
        creamSound.Looped = false
        creamSound.TimePosition = 220.9 -- 3:40
    end
end)

print("[tea-time-waltz-old] Script loaded! Made by lil2kki <3")
print("[tea-time-waltz-old] https://scriptblox.com/u/lil2kki")
print("[tea-time-waltz-old] https://github.com/thaLILNIKKI/my-outcome-memories")