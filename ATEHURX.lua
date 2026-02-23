-- AETHER X v2.0 - No Key Version
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Settings
local Settings = {
    Speed = 16,
    Jump = 50,
    Fly = false,
    Noclip = false,
    ESP = false,
    GodMode = false
}

-- GUI
local SG = Instance.new("ScreenGui")
SG.Name = "AetherX"
SG.Parent = game.CoreGui

-- Main Menu
local MF = Instance.new("Frame")
MF.Size = UDim2.new(0, 280, 0, 400)
MF.Position = UDim2.new(0.5, -140, 0.5, -200)
MF.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MF.Parent = SG

Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 10)

local TB = Instance.new("Frame")
TB.Size = UDim2.new(1, 0, 0, 40)
TB.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TB.Parent = MF

Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 10)

local TT = Instance.new("TextLabel")
TT.Size = UDim2.new(0.5, 0, 1, 0)
TT.Position = UDim2.new(0.05, 0, 0, 0)
TT.BackgroundTransparency = 1
TT.Text = "AETHER X"
TT.TextColor3 = Color3.fromRGB(0, 200, 255)
TT.TextScaled = true
TT.Font = Enum.Font.GothamBold
TT.Parent = TB

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -75, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextScaled = true
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TB

Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TB

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Reopen Button
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Size = UDim2.new(0, 50, 0, 50)
ReopenBtn.Position = UDim2.new(0, 10, 0.5, -25)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ReopenBtn.Text = "A"
ReopenBtn.TextColor3 = Color3.new(1, 1, 1)
ReopenBtn.TextScaled = true
ReopenBtn.Font = Enum.Font.GothamBlack
ReopenBtn.Visible = false
ReopenBtn.Parent = SG

Instance.new("UICorner", ReopenBtn).CornerRadius = UDim.new(0, 12)

local ReopenStroke = Instance.new("UIStroke")
ReopenStroke.Color = Color3.fromRGB(255, 255, 255)
ReopenStroke.Thickness = 2
ReopenStroke.Parent = ReopenBtn

-- Content
local SF = Instance.new("ScrollingFrame")
SF.Size = UDim2.new(1, -20, 1, -50)
SF.Position = UDim2.new(0, 10, 0, 45)
SF.BackgroundTransparency = 1
SF.ScrollBarThickness = 4
SF.Parent = MF

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.Parent = SF

-- Functions
local function CreateToggle(name, callback)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 50)
    F.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(0.6, 0, 1, 0)
    L.Position = UDim2.new(0.05, 0, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = name
    L.TextColor3 = Color3.new(1, 1, 1)
    L.TextScaled = true
    L.Font = Enum.Font.Gotham
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = F
    
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(0, 60, 0, 30)
    B.Position = UDim2.new(1, -70, 0.5, -15)
    B.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    B.Text = "OFF"
    B.TextColor3 = Color3.new(1, 1, 1)
    B.Font = Enum.Font.GothamBold
    B.Parent = F
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 15)
    
    local on = false
    B.MouseButton1Click:Connect(function()
        on = not on
        B.BackgroundColor3 = on and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(70, 70, 90)
        B.Text = on and "ON" or "OFF"
        callback(on)
    end)
    F.Parent = SF
end

local function CreateSlider(name, min, max, default, callback)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 60)
    F.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(0.9, 0, 0, 20)
    L.Position = UDim2.new(0.05, 0, 0, 5)
    L.BackgroundTransparency = 1
    L.Text = name .. ": " .. default
    L.TextColor3 = Color3.new(1, 1, 1)
    L.TextScaled = true
    L.Font = Enum.Font.GothamBold
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = F
    
    local BG = Instance.new("Frame")
    BG.Size = UDim2.new(0.9, 0, 0, 10)
    BG.Position = UDim2.new(0.05, 0, 0, 40)
    BG.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    BG.BorderSizePixel = 0
    BG.Parent = F
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0, 5)
    
    local FL = Instance.new("Frame")
    FL.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    FL.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    FL.BorderSizePixel = 0
    FL.Parent = BG
    Instance.new("UICorner", FL).CornerRadius = UDim.new(0, 5)
    
    local BT = Instance.new("TextButton")
    BT.Size = UDim2.new(0, 20, 0, 20)
    BT.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    BT.BackgroundColor3 = Color3.new(1, 1, 1)
    BT.Text = ""
    BT.Parent = BG
    Instance.new("UICorner", BT).CornerRadius = UDim.new(0.5, 0)
    
    local drag = false
    BT.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - BG.AbsolutePosition.X) / BG.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * pos)
            FL.Size = UDim2.new(pos, 0, 1, 0)
            BT.Position = UDim2.new(pos, -10, 0.5, -10)
            L.Text = name .. ": " .. val
            callback(val)
        end
    end)
    F.Parent = SF
end

-- Features
CreateSlider("Speed", 16, 500, 16, function(v)
    Settings.Speed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

CreateSlider("Jump Power", 50, 500, 50, function(v)
    Settings.Jump = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)

CreateToggle("Fly Mode", function(on) Settings.Fly = on end)
CreateToggle("Noclip", function(on) Settings.Noclip = on end)
CreateToggle("Infinite Jump", function(on) Settings.InfiniteJump = on end)
CreateToggle("ESP", function(on) Settings.ESP = on end)
CreateToggle("God Mode", function(on)
    Settings.GodMode = on
    if on and LocalPlayer.Character then
        local H = LocalPlayer.Character:FindFirstChild("Humanoid")
        if H then H.MaxHealth = math.huge H.Health = math.huge end
    end
end)

-- Buttons
MinBtn.MouseButton1Click:Connect(function()
    MF.Visible = false
    ReopenBtn.Visible = true
end)

ReopenBtn.MouseButton1Click:Connect(function()
    MF.Visible = true
    ReopenBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
end)

-- Features Logic
RunService.RenderStepped:Connect(function()
    if Settings.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local bg = hrp:FindFirstChild("AetherGyro") or Instance.new("BodyGyro")
        local bv = hrp:FindFirstChild("AetherVel") or Instance.new("BodyVelocity")
        bg.Name = "AetherGyro" bg.P = 9e4 bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = workspace.CurrentCamera.CFrame bg.Parent = hrp
        bv.Name = "AetherVel" bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
        bv.Velocity = dir * 100 bv.Parent = hrp
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if hrp:FindFirstChild("AetherGyro") then hrp.AetherGyro:Destroy() end
        if hrp:FindFirstChild("AetherVel") then hrp.AetherVel:Destroy() end
    end
end)

RunService.Stepped:Connect(function()
    if Settings.Noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump and LocalPlayer.Character then
        local H = LocalPlayer.Character:FindFirstChild("Humanoid")
        if H then H:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ESP
local ESPObjects = {}
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if Settings.ESP then
                if not ESPObjects[p] then
                    local h = Instance.new("Highlight")
                    h.Name = "AetherESP" h.FillColor = Color3.fromRGB(255, 0, 0)
                    h.OutlineColor = Color3.fromRGB(255, 255, 255) h.FillTransparency = 0.5
                    h.Parent = p.Character ESPObjects[p] = h
                else ESPObjects[p].Parent = p.Character end
            elseif ESPObjects[p] then ESPObjects[p]:Destroy() ESPObjects[p] = nil end
        end
    end
end)

-- Drag & Toggle
local dragging = false
TB.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = MF.Position
    end
end)
TB.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MF.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        MF.Visible = not MF.Visible ReopenBtn.Visible = not MF.Visible
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5) local H = char:WaitForChild("Humanoid")
    H.WalkSpeed = Settings.Speed H.JumpPower = Settings.Jump
    if Settings.GodMode then H.MaxHealth = math.huge H.Health = math.huge end
end)

print("AETHER X v2.0 loaded! Press Insert to toggle")
