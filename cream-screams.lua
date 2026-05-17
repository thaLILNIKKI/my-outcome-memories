print("[cream-screams] Now loading... Made by lil2kki <3")

local SoundService = game:GetService("SoundService")

local function loadAsset(filename)
    local filepath = "cache/cream-screams/" .. filename
    if not isfile(filepath) then
        makefolder("cache/cream-screams")
        writefile(filepath, game:HttpGet("https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/" .. filename))
    end
    return getcustomasset(filepath)
end

local screamAssets = {}
for i = 1, 12 do
    table.insert(screamAssets, loadAsset("cream_uneasy_rest_screams" .. i .. ".mp3"))
end

local sfxGroup = game.ReplicatedStorage.ClientAssets.Sounds.sfx

local function playRandom(assets, model)
    local parent = workspace
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if hrp then parent = hrp end
    
    local sound = Instance.new("Sound")
    sound.Volume = 1
    sound.SoundId = assets[math.random(1, #assets)]
    sound.RollOffMaxDistance = 255
    sound.RollOffMinDistance = 10
    sound.SoundGroup = sfxGroup
    sound.Parent = parent
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 10)
end

local playersFolder = workspace:WaitForChild("Players")

local BLOOD_WINDOW = 3.0
local lastBlood = 0

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
Remotes:WaitForChild("CharacterFX").OnClientEvent:Connect(function(action, target)
    local name = tostring(target)
    
    if action == "blood" then
        lastBlood = tick()
        return
    end
    
    if action == "alertsurvivors" then
        local t = lastBlood
        if (tick() - t) > BLOOD_WINDOW then return end
        
        local model = playersFolder:FindFirstChild(name)
        if not model or not string.find(model:GetAttribute("Character") or "", "Cream") then return end
        
        playRandom(screamAssets, model)
    end
end)

print("[cream-screams] Ready! Made by lil2kki <3")
print("[cream-screams] Sounds from uneasy rest (94445064593939)")
print("[cream-screams] https://github.com/thaLILNIKKI/my-outcome-memories")


--[[ uneasy rest place 94445064593939
(private sounds)
75659377487293 - hiVanilla
129971841836693 - iCandBr
138707412116973 - cry
104223745935202 - cry2
135995444350553 - cry3
92288087173100 - beg
94437367966057 - pls mr doll its me
134067222741865 - amyidk
118890171318671 - scream
90185552715790 - help
106711437588155 - iCantGo
133717368628512 - scream2
70737404729267 - myEarHurt
]]--
