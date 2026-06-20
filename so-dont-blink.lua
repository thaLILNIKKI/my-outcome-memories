print("[so-dont-blink] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then writefile(filename, game:HttpGet(url)) end
    return getcustomasset(filename)
end

delfile("so-dont-blink.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/so-dont-blink.mp3",
    "cache/so-dont-blink.mp3"
)

local SonicSolo = game:GetService("ReplicatedStorage"):FindFirstChild("SonicSolo", true)
if SonicSolo and SonicSolo:IsA("Sound") then
    SonicSolo.SoundId = MUSIC_ID
    SonicSolo.Looped = true
end

_G.SonicSoloGameStateConn = _G.SonicSoloGameStateConn or nil
if _G.SonicSoloGameStateConn then
	_G.SonicSoloGameStateConn:Disconnect()
	_G.SonicSoloGameStateConn = nil
	print("[so-dont-blink] Previous game state connection destroyed")
end
_G.SonicSoloGameStateConn = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState == "RE" and SonicSolo and SonicSolo:IsA("Sound") and SonicSolo.IsPlaying then
        SonicSolo.Looped = false
        SonicSolo.TimePosition = 289 -- 4:49
    end
end)

print("[so-dont-blink] Ready!")
print("[so-dont-blink] https://github.com/thaLILNIKKI/my-outcome-memories")
