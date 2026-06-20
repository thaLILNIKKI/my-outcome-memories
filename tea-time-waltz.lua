print("[tea-time-waltz] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then writefile(filename, game:HttpGet(url)) end
    return getcustomasset(filename)
end

delfile("tea-time-waltz.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/tea-time-waltz.mp3",
    "cache/tea-time-waltz.mp3"
)

local CreamSolo = game:GetService("ReplicatedStorage"):FindFirstChild("CreamSolo", true)

if CreamSolo and CreamSolo:IsA("Sound") then
    CreamSolo.SoundId = MUSIC_ID
    CreamSolo.Looped = true
end

_G.CreamSoloGameStateConn = _G.CreamSoloGameStateConn or nil
if _G.CreamSoloGameStateConn then
	_G.CreamSoloGameStateConn:Disconnect()
	_G.CreamSoloGameStateConn = nil
	print("[tea-time-waltz] Previous game state connection destroyed")
end
_G.CreamSoloGameStateConn = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState == "RE" and CreamSolo and CreamSolo:IsA("Sound") and CreamSolo.IsPlaying then
        CreamSolo.Looped = false
        CreamSolo.TimePosition = 184.5 -- 3:04:500
    end
end)

print("[tea-time-waltz] Ready!")
print("[tea-time-waltz] https://github.com/thaLILNIKKI/my-outcome-memories")
