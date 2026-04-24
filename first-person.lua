print("[first-person] Now loading... Made by lil2kki <3")

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local plr = Players.LocalPlayer
if not plr then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    plr = Players.LocalPlayer
end

local char = nil
local head = nil
local hum = nil

local active = false
local yaw = 0
local pitch = 0

local function updateReferences(newChar)
    char = newChar
    if char then
        head = char:FindFirstChild("Head")
        hum = char:FindFirstChild("Humanoid")
        if not head then
            head = char:WaitForChild("Head")
        end
        if not hum then
            hum = char:WaitForChild("Humanoid")
        end
    end
end

local function setVisibility(visible)
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = visible and 0 or 1
        end
    end
    for _, acc in pairs(char:GetChildren()) do
        if acc:IsA("Accessory") and acc.Handle then
            acc.Handle.LocalTransparencyModifier = visible and 0 or 1
        end
    end
end

local function toggle()
    active = not active
    
    if active then
        if not head or not head.Parent then
            if plr.Character then
                updateReferences(plr.Character)
            end
            if not head or not head.Parent then
                print("[first-person] No character found, can't enable FPS")
                active = false
                return
            end
        end
        
        local _, y, p = Camera.CFrame:ToOrientation()
        yaw = y
        pitch = math.clamp(p, -math.rad(89), math.rad(89))
        
        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CameraSubject = nil
        setVisibility(false)
        pcall(function()
            plr.CameraMinZoomDistance = 0
            plr.CameraMaxZoomDistance = 0
        end)
        print("[first-person] FPS mode ON")
    else
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        setVisibility(true)
        pcall(function()
            plr.CameraMinZoomDistance = 0.5
            plr.CameraMaxZoomDistance = 20
        end)
        print("[first-person] FPS mode OFF")
    end
end

Input.InputChanged:Connect(function(inp, processed)
    if processed or not active then return end
    if inp.UserInputType == Enum.UserInputType.MouseMovement then
        local d = inp.Delta
        yaw = yaw - d.X * 0.0025
        pitch = math.clamp(pitch - d.Y * 0.0025, -math.rad(89), math.rad(89))
    end
end)

Run.RenderStepped:Connect(function()
    if not active then return end
    
    if not head or not head.Parent then
        if plr.Character then
            updateReferences(plr.Character)
        end
        if not head or not head.Parent then
            active = false
            Camera.CameraType = Enum.CameraType.Custom
            print("[first-person] Lost character, disabling FPS")
            return
        end
    end
    
    local eye = head.Position + Vector3.new(0, 0.1, 0)
    Camera.CFrame = CFrame.new(eye) * CFrame.fromOrientation(pitch, yaw, 0)
end)

Input.InputBegan:Connect(function(inp, processed)
    if processed then return end
    if inp.KeyCode == Enum.KeyCode.V then toggle() end
end)

plr.CharacterAdded:Connect(function(newChar)
    print("[first-person] Character spawned, updating references")
    updateReferences(newChar)
    if active then
        task.wait(0.1)
        setVisibility(false)
        Camera.CameraType = Enum.CameraType.Scriptable
        local _, y, p = Camera.CFrame:ToOrientation()
        yaw = y
        pitch = math.clamp(p, -math.rad(89), math.rad(89))
    end
end)

updateReferences(plr.Character or plr.CharacterAdded:Wait())

print("[first-person] Loaded! Press V to toggle.")
