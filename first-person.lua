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

local char = plr.Character or plr.CharacterAdded:Wait()
local head = char:WaitForChild("Head")
local hum = char:WaitForChild("Humanoid")

local active = false
local yaw = 0
local pitch = 0

local saved = {}

local function hideObj(obj)
    if saved[obj] then return end
    if obj:IsA("BasePart") then
        saved[obj] = obj.LocalTransparencyModifier
        obj.LocalTransparencyModifier = 1
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        saved[obj] = obj.Transparency
        obj.Transparency = 1
    end
end

local descConn

local function setVisibility(visible)
    if not char then return end
    if not visible then
        saved = {}
        for _, obj in pairs(char:GetDescendants()) do hideObj(obj) end
        if descConn then descConn:Disconnect() end
        descConn = char.DescendantAdded:Connect(function(obj) hideObj(obj) end)
    else
        if descConn then descConn:Disconnect(); descConn = nil end
        for obj, val in pairs(saved) do
            if obj and obj.Parent then
                if obj:IsA("BasePart") then obj.LocalTransparencyModifier = val
                elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = val end
            end
        end
        saved = {}
    end
end

local function toggle()
    active = not active
    
    if active then
        if not head then return end
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
    else
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        setVisibility(true)
        pcall(function()
            plr.CameraMinZoomDistance = 0.5
            plr.CameraMaxZoomDistance = 20
        end)
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
    if not head or not head.Parent then return end
    
    local eye = head.Position + Vector3.new(0, 0.1, 0)
    Camera.CFrame = CFrame.new(eye) * CFrame.fromOrientation(pitch, yaw, 0)
end)

Input.InputBegan:Connect(function(inp, processed)
    if processed then return end
    if inp.KeyCode == Enum.KeyCode.V then toggle() end
end)

plr.CharacterAdded:Connect(function(newChar)
    char = newChar
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

print("[first-person] Loaded! Press V to toggle.")
