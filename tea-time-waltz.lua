print("[tea-time-waltz] Script now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end

local MUSIC_ID = loadCustomAsset(
    "https://fine.sunproxy.net/file/MDFlaFZ6bXBWTjJ3T3EvTmh6Yk1uVnhEbGJKbmxXSEJobXUvdTBBS1g1bEhIZml0YnR2YnhuQllKNVpJTDc5UytNOWN3bEt3UE94ZlB6QmJTM3ZjazE3RFp1bkhHNWdxOUwxVVF6VnBkMWM9/Neizvesten_-_57.TEA-TIME_WALTZ_Cream_s_old_LMS_theme_(SkySound.cc).mp3",
    "tea-time-waltz.mp3"
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
            creamSound:GetPropertyChangedSignal("SoundId"):Connect(function()
                if creamSound.SoundId ~= MUSIC_ID then
                    creamSound.SoundId = MUSIC_ID
                end
            end)
            creamSound.Looped = false
            creamSound:GetPropertyChangedSignal("Looped"):Connect(function()
                if creamSound.Looped then
                    creamSound.Looped = false
                end
            end)
            print("[tea-time-waltz] Replaced successfully")
        end
    end)
    if not ok then
        warn("[tea-time-waltz] Failed: " .. tostring(result))
    end
end

applyReplacement()

stateValue.Changed:Connect(function(newState)
    print("[tea-time-waltz] State: " .. tostring(newState))
    if newState == "RE" and creamSound and creamSound.IsPlaying then
        creamSound.TimePosition = 184.5 -- 3:04:500
        print("[tea-time-waltz] Seeked to 3:04.5 (end)")
    end
end)

print("[tea-time-waltz] Script loaded! Made by lil2kki <3")
