-- press V to toggle first/third person

print("[first-person] Now loading... Made by lil2kki <3")

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local head = char:WaitForChild("Head")
local hum = char:WaitForChild("Humanoid")

local active = false
local yaw = 0
local pitch = 0

local function setVisibility(visible)
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
        local _, y, p = Camera.CFrame:ToOrientation()
        yaw = y
        pitch = math.clamp(p, -math.rad(89), math.rad(89))
        
        Camera.CameraType = Enum.CameraType.Scriptable
        Camera.CameraSubject = nil
        setVisibility(false)
        plr.CameraMinZoomDistance = 0
        plr.CameraMaxZoomDistance = 0
    else
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        setVisibility(true)
        plr.CameraMinZoomDistance = 0.5
        plr.CameraMaxZoomDistance = 20
    end
end

Input.InputChanged:Connect(function(inp, processed)
    if processed or not active then return end
    if inp.UserInputType == Enum.UserInputType.MouseMovement then
        local d = inp.Delta
        yaw = yaw - d.X * 0.002
        pitch = math.clamp(pitch - d.Y * 0.002, -math.rad(89), math.rad(89))
    end
end)

Run.RenderStepped:Connect(function()
    if not active then return end
    if not head or not head.Parent then return end
    
    local eye = head.Position + Vector3.new(0, 0.1, 0)
    Camera.CFrame = CFrame.new(eye) * CFrame.fromOrientation(pitch, yaw, 0)
end)

Input.InputBegan:Connect(function(inp, processed)
    if processed then return end
    if inp.KeyCode == Enum.KeyCode.V then toggle() end
end)

plr.CharacterAdded:Connect(function(new)
    char = new
    head = char:WaitForChild("Head")
    hum = char:WaitForChild("Humanoid")
    if active then
        setVisibility(false)
        Camera.CameraType = Enum.CameraType.Scriptable
        local _, y, p = Camera.CFrame:ToOrientation()
        yaw = y
        pitch = math.clamp(p, -math.rad(89), math.rad(89))
    end
end)

print("[first-person] loaded. V to toggle.")
