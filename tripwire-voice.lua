print("[tripwire-voice] Script now loading... Made by lil2kki <3")

local SoundService = game:GetService("SoundService")

local BASE_URL = "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/tripwire-voice/"

local function loadAsset(filename)
    local filepath = "tripwire-voice/" .. filename
    if not isfile(filepath) then
        makefolder("tripwire-voice")
        print("[tripwire-voice] Downloading: " .. filename)
        writefile(filepath, game:HttpGet(BASE_URL .. filename))
        print("[tripwire-voice] Saved: " .. filepath)
    else
        print("[tripwire-voice] Already cached: " .. filename)
    end
    local asset = getcustomasset(filepath)
    print("[tripwire-voice] Loaded: " .. filename .. " -> " .. tostring(asset))
    return asset
end

print("[tripwire-voice] Loading cry assets...")
local cryAssets = {}
for i = 1, 10 do
    table.insert(cryAssets, loadAsset("cry" .. i .. ".mp3"))
end
print("[tripwire-voice] Cry assets ready: " .. #cryAssets)

print("[tripwire-voice] Loading downing assets...")
local downingAssets = {}
for i = 1, 22 do
    table.insert(downingAssets, loadAsset("downing" .. i .. ".mp3"))
end
print("[tripwire-voice] Downing assets ready: " .. #downingAssets)

local sfxGroup = SoundService:FindFirstChild("TripwireSFX")
if not sfxGroup then
    sfxGroup = Instance.new("SoundGroup")
    sfxGroup.Name = "TripwireSFX"
    sfxGroup.Volume = 1
    sfxGroup.Parent = SoundService
    print("[tripwire-voice] Created SoundGroup: TripwireSFX")
else
    print("[tripwire-voice] SoundGroup already exists: TripwireSFX")
end

local function isTripwire(model)
    return model:GetAttribute("Character") == "TailsDoll"
end

local function getTripwireModel()
    local playersFolder = workspace:FindFirstChild("Players")
    if not playersFolder then return nil end
    for _, m in ipairs(playersFolder:GetChildren()) do
        if isTripwire(m) then return m end
    end
    return nil
end

local function playRandom(assets, label)
    local model = getTripwireModel()
    local parent = workspace
    if model then
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if hrp then parent = hrp end
    end

    local idx = math.random(1, #assets)
    print("[tripwire-voice] Playing " .. label .. " #" .. idx .. " on " .. parent.Name)

    local sound = Instance.new("Sound")
    sound.Volume = 1
    sound.SoundId = assets[idx]
    sound.RollOffMaxDistance = 255
    sound.RollOffMinDistance = 10
    sound.SoundGroup = sfxGroup
    sound.Parent = parent
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 10)
end

local playersFolder = workspace:WaitForChild("Players")

local function watchModel(model)
    if isTripwire(model) then
        print("[tripwire-voice] Watching EXE: " .. model.Name)
        local stunActive = false
        model.AttributeChanged:Connect(function(attr)
            if attr ~= "StunDur" then return end
            local val = model:GetAttribute("StunDur")
            if val and val > 0 and not stunActive then
                stunActive = true
                print("[tripwire-voice] Stunned! StunDur = " .. tostring(val))
                playRandom(cryAssets, "cry")
            elseif not val or val <= 0 then
                if stunActive then print("[tripwire-voice] Stun ended") end
                stunActive = false
            end
        end)
    end

    model.AttributeChanged:Connect(function(attr)
        if attr ~= "State" then return end
        local state = model:GetAttribute("State")
        if state ~= "downed" then return end
        for _, m in ipairs(playersFolder:GetChildren()) do
            if isTripwire(m) then
                print("[tripwire-voice] " .. model.Name .. " downed by Tripwire!")
                playRandom(downingAssets, "downing")
                return
            end
        end
    end)
end

for _, child in ipairs(playersFolder:GetChildren()) do
    watchModel(child)
end

playersFolder.ChildAdded:Connect(function(child)
    print("[tripwire-voice] New model joined: " .. child.Name .. " | Character: " .. tostring(child:GetAttribute("Character")))
    watchModel(child)
end)

print("[tripwire-voice] Script ready!")
