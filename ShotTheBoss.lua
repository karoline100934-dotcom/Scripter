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
MainFrame.Position = UDim2.new(0.5, -175, 0.4, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true -- Penting untuk drag
MainFrame.Draggable = false -- Kita pakai script manual agar lebih smooth
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- RBXASSET Icon (Contoh Ikon Game Pass/Pet)
local Icon = Instance.new("ImageLabel")
Icon.Name = "UIIcon"
Icon.Size = UDim2.new(0, 25, 0, 25)
Icon.Position = UDim2.new(0, 10, 0, 7)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://6031763426" -- Ikon Mahkota/Boss
Icon.Parent = MainFrame

-- Title Bar (RGB Animation)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 0, 40)
TitleLabel.Position = UDim2.new(0, 40, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Shot The Boss"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- Loop RGB
spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        TitleLabel.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
    end
end)

-- Buttons (Minimize & Close)
local CloseBtn = Instance.new("ImageButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -30, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Image = "rbxassetid://6031094678" -- X Icon
CloseBtn.ImageColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Parent = MainFrame

local MinBtn = Instance.new("ImageButton")
MinBtn.Size = UDim2.new(0, 20, 0, 20)
MinBtn.Position = UDim2.new(1, -60, 0, 10)
MinBtn.BackgroundTransparency = 1
MinBtn.Image = "rbxassetid://6034818372" -- Minus Icon
MinBtn.Parent = MainFrame

--- CONTENT AREA ---
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Parent = Content
Layout.Padding = UDim.new(0, 8)

-- Function Generator
local function AddModule(title, placeholder, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 40)
    Container.BackgroundTransparency = 1
    Container.Parent = Content

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.3, 0, 1, 0)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.PlaceholderText = placeholder
    Box.Text = "1"
    Box.Font = Enum.Font.Code
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Parent = Container
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Box

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.65, 0, 1, 0)
    Btn.Position = UDim2.new(0.35, 0, 0, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = title
    Btn.Font = Enum.Font.Code
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Parent = Container

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 4)
    BCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        callback(tonumber(Box.Text) or 1)
    end)
end

-- MODULES
-- 1. Get OP Pet
local HatchBtn = Instance.new("TextButton")
HatchBtn.Size = UDim2.new(1, 0, 0, 40)
HatchBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 100)
HatchBtn.Text = "Get Op Pet"
HatchBtn.Font = Enum.Font.Code
HatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HatchBtn.Parent = Content
Instance.new("UICorner", HatchBtn).CornerRadius = UDim.new(0,4)

HatchBtn.MouseButton1Click:Connect(function()
    local args = {"Abyss", "Soul Warden", 14000}
    game:GetService("ReplicatedStorage"):WaitForChild("PEV"):WaitForChild("Hatch"):FireServer(unpack(args))
end)

-- 2. Win Gain
AddModule("Gain Win", "Amt", function(val)
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("WinGain"):FireServer(unpack({val}))
end)

-- 3. Train
AddModule("Train Strength", "Amt", function(val)
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("Train"):FireServer(unpack({val}))
end)

--- FULL DRAG SYSTEM (Smooth) ---
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

--- MINIMIZE & CLOSE LOGIC ---
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 350, 0, 40) or UDim2.new(0, 350, 0, 250)
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = targetSize}):Play()
    Content.Visible = not minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Back", 0.3, true, function()
        ScreenGui:Destroy()
    end)
end)

-- NOTIFICATION
local function CreateNotify(msg)
    local Notif = Instance.new("TextLabel")
    Notif.Size = UDim2.new(0, 250, 0, 40)
    Notif.Position = UDim2.new(1, 10, 0.9, 0)
    Notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notif.TextColor3 = Color3.fromRGB(0, 255, 150)
    Notif.Text = msg
    Notif.Font = Enum.Font.Code
    Notif.Parent = ScreenGui
    Instance.new("UICorner", Notif)
    
    Notif:TweenPosition(UDim2.new(1, -260, 0.9, 0), "Out", "Quart", 0.5)
    task.wait(3)
    Notif:TweenPosition(UDim2.new(1, 10, 0.9, 0), "In", "Quart", 0.5)
end

CreateNotify("Made By @SilentExecute")
