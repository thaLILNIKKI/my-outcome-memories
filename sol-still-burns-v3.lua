print("[sol-still-burns-v3] Script now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

local MUSIC_ID = loadCustomAsset(
    "https://fine.sunproxy.net/file/MDFlaFZ6bXBWTjJ3T3EvTmh6Yk1uVnhEbGJKbmxXSEJobXUvdTBBS1g1bHIyS1RRd2xIYUZXVmtIZHdpTmJtYmhhQU9BZjAwTE1DNm84WG45Mm9JTW54aTVzMGUrcnhQWENRN1hEQllxeVk9/Vasalto_-_The_Sol_Still_Burns_V3_April_Fools_(SkySound.cc).mp3",
    "sol-still-burns-v3.mp3"
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

-- следим за State
stateValue.Changed:Connect(function(newState)
    print("[sol-still-burns-v3] State: " .. tostring(newState))
    if newState == "RE" and blazeSound and blazeSound.IsPlaying then
        blazeSound.TimePosition = 207 -- 3:27
        print("[sol-still-burns-v3] Seeked to 3:27 (end)")
    end
end)

print("[sol-still-burns-v3] Script loaded! Made by lil2kki <3")