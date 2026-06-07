print("[tripwire-voice] TRIPWIRE VOICELINES FIXED :D")
print("[tripwire-voice] im out.")
return

_G.TailsDollVoicelinesLoading = true

delfolder("tripwire-voice/") -- old cache dir

local function loadAsset(filename)
    local filepath = "cache/tripwire-voice/" .. filename
    if not isfile(filepath) then
        makefolder("cache/tripwire-voice")
        writefile(filepath, game:HttpGet("https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/" .. filename))
    end
    local asset = getcustomasset(filepath)
    return asset
end

_G.TailsDollVoicelinesCryAssets = {}
for i = 1, 10 do table.insert(_G.TailsDollVoicelinesCryAssets, loadAsset("tw-cry" .. i .. ".mp3")) end

_G.TailsDollVoicelinesDowningAssets = {}
for i = 1, 22 do table.insert(_G.TailsDollVoicelinesDowningAssets, loadAsset("tw-downing" .. i .. ".mp3")) end

-- _G.TailsDollVoicelinesPlayerModel

local function playRandom(assets, label)
    if not _G.TailsDollVoicelinesPlayerModel then return end
    local sound = Instance.new("Sound")
    sound.Name = "TailsDoll " .. label
    sound.Volume = 1
    sound.SoundId = assets[math.random(1, #assets)]
    sound.RollOffMaxDistance = 255
    sound.RollOffMinDistance = 10
    sound.SoundGroup = game.ReplicatedStorage.ClientAssets.Sounds.sfx
    sound.Parent = _G.TailsDollVoicelinesPlayerModel
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 10)
end

local function watchEXE(model)
    _G.TailsDollVoicelinesPlayerModel = model
    _G.TailsDollVoicelinesStunActive = false
    local conn = _G.TailsDollVoicelinesPlayerModel.AttributeChanged:Connect(function(attr)
        if not _G.TailsDollVoicelinesPlayerModel then 
            conn:Disconnect()
	        conn = nil
            return
        end
        if attr ~= "StunDur" then return end
        local val = model:GetAttribute("StunDur")
        if val and val > 0 and not _G.TailsDollVoicelinesStunActive then
            _G.TailsDollVoicelinesStunActive = true
            playRandom(_G.TailsDollVoicelinesCryAssets, "cry")
        elseif not val or val <= 0 then
            _G.TailsDollVoicelinesStunActive = false
        end
    end)
end

local function watchSrv(model)
    local conn = model.AttributeChanged:Connect(function(attr)
        if attr ~= "State" then return end
        local state = model:GetAttribute("State")
        if _G.TailsDollVoicelinesPlayerModel then
            if state == "downed" then playRandom(_G.TailsDollVoicelinesDowningAssets, "downing") end
        else
            conn:Disconnect()
	        conn = nil
        end
    end)
end

local function walkPlayers()
    _G.TailsDollVoicelinesPlayerModel = nil
    task.wait(1)
    for _, model in ipairs(workspace:WaitForChild("Players"):GetChildren()) do
    	if not model:IsA("Model") then continue end
    	if model:GetAttribute("Character") ~= "TailsDoll" then 
            watchSrv(model)
        else
            watchEXE(model)
        end
    end
end
walkPlayers()

_G.TailsDollVoicelinesGameStateConnection = _G.TailsDollVoicelinesGameStateConnection or nil
if _G.TailsDollVoicelinesGameStateConnection then
	_G.TailsDollVoicelinesGameStateConnection:Disconnect()
	_G.TailsDollVoicelinesGameStateConnection = nil
	print("[tripwire-voice] Previous game state connection destroyed")
end
_G.TailsDollVoicelinesGameStateConnection = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState ~= "ING" then return end
	walkPlayers()
end)

print("[tripwire-voice] Ready! Made by lil2kki <3")
print("[tripwire-voice] https://github.com/thaLILNIKKI/my-outcome-memories")
