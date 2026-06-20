print("[tea-time-waltz-old] Now loading... Made by lil2kki <3")

local function loadCustomAsset(url, filename)
    if not isfile(filename) then writefile(filename, game:HttpGet(url)) end
    return getcustomasset(filename)
end

delfile("tea-time-waltz-old.mp3") -- old cache dir

local MUSIC_ID = loadCustomAsset(
    "https://github.com/thaLILNIKKI/my-outcome-memories/releases/download/resources/tea-time-waltz-old.mp3",
    "cache/tea-time-waltz-old.mp3"
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
	print("[tea-time-waltz-old] Previous game state connection destroyed")
end
_G.CreamSoloGameStateConn = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState == "RE" and CreamSolo and CreamSolo:IsA("Sound") and CreamSolo.IsPlaying then
        CreamSolo.Looped = false
        CreamSolo.TimePosition = 220.9 -- 3:40
    end
end)

print("[tea-time-waltz-old] Ready!")
print("[tea-time-waltz-old] https://github.com/thaLILNIKKI/my-outcome-memories")
