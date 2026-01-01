local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Hapus UI lama jika ada
if CoreGui:FindFirstChild("ShotTheBossUI") then
    CoreGui.ShotTheBossUI:Destroy()
end

-- Main UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShotTheBossUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title Bar & RGB Animation
local TitleBar = Instance.new("TextLabel")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Text = "Shot The Boss"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.Code
TitleBar.TextSize = 20
TitleBar.Parent = MainFrame

-- RGB Effect Script
spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        TitleBar.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

--- Buttons (X & Minimize)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.Code
CloseBtn.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.Font = Enum.Font.Code
MinBtn.Parent = MainFrame

--- Containers
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentFrame
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Functions & Input Setup
local function CreateAction(text, placeholder, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 45)
    Frame.BackgroundTransparency = 1
    Frame.Parent = ContentFrame

    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0.4, 0, 1, 0)
    Input.PlaceholderText = placeholder
    Input.Text = ""
    Input.Font = Enum.Font.Code
    Input.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.55, 0, 1, 0)
    Btn.Position = UDim2.new(0.45, 0, 0, 0)
    Btn.Text = text
    Btn.Font = Enum.Font.Code
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Parent = Frame

    Btn.MouseButton1Click:Connect(function()
        local val = tonumber(Input.Text) or 1
        callback(val)
    end)
end

-- Script Actions
-- 1. Hatch OP Pet
local HatchBtn = Instance.new("TextButton")
HatchBtn.Size = UDim2.new(0.9, 0, 0, 40)
HatchBtn.Text = "Get OP Pet (Abyss)"
HatchBtn.Font = Enum.Font.Code
HatchBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
HatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HatchBtn.Parent = ContentFrame

HatchBtn.MouseButton1Click:Connect(function()
    local args = {"Abyss", "Soul Warden", 14000}
    game:GetService("ReplicatedStorage"):WaitForChild("PEV"):WaitForChild("Hatch"):FireServer(unpack(args))
end)

-- 2. Win Gain
CreateAction("Gain Win", "Amount", function(val)
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("WinGain"):FireServer(unpack({val}))
end)

-- 3. Train
CreateAction("Train", "Amount", function(val)
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("Train"):FireServer(unpack({val}))
end)

-- Full Drag System
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    TweenService:Create(MainFrame, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        update(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Minimize Logic
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 350, 0, 40) or UDim2.new(0, 350, 0, 250)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
    ContentFrame.Visible = not isMinimized
end)

-- Destroy Logic
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Notification
local function Notify(txt)
    local Notification = Instance.new("TextLabel")
    Notification.Size = UDim2.new(0, 250, 0, 50)
    Notification.Position = UDim2.new(1, 0, 0.8, 0)
    Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.Text = txt
    Notification.Font = Enum.Font.Code
    Notification.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.Parent = Notification
    
    Notification:TweenPosition(UDim2.new(1, -260, 0.8, 0), "Out", "Quart", 0.5)
    task.wait(3)
    Notification:TweenPosition(UDim2.new(1, 0, 0.8, 0), "In", "Quart", 0.5)
    task.delay(0.5, function() Notification:Destroy() end)
end

Notify("Made By @SilentExecute")
