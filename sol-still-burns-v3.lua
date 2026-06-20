print("[sol-still-burns-v3] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then writefile(filename, game:HttpGet(url)) end
    return getcustomasset(filename)
end

delfile("sol-still-burns-v3.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/sol-still-burns-v3.mp3",
    "cache/sol-still-burns-v3.mp3"
)

local BlazeSolo = game:GetService("ReplicatedStorage"):FindFirstChild("BlazeSolo", true)
if BlazeSolo and BlazeSolo:IsA("Sound") then
    BlazeSolo.SoundId = MUSIC_ID
    BlazeSolo.Looped = true
end

_G.BlazeSoloGameStateConn = _G.BlazeSoloGameStateConn or nil
if _G.BlazeSoloGameStateConn then
	_G.BlazeSoloGameStateConn:Disconnect()
	_G.BlazeSoloGameStateConn = nil
	print("[sol-still-burns-v3] Previous game state connection destroyed")
end
_G.BlazeSoloGameStateConn = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState == "RE" and BlazeSolo and BlazeSolo:IsA("Sound") and BlazeSolo.IsPlaying then
        BlazeSolo.Looped = false
        BlazeSolo.TimePosition = 207 -- 3:27
    end
end)

print("[sol-still-burns-v3] Ready!")
print("[sol-still-burns-v3] https://github.com/thaLILNIKKI/my-outcome-memories")
