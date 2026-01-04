--[[ 
    UI Made By @SilentExecute 
    Updated: Path Auto Train Fixed to workspace.Treadmills.Regular.RunPosition
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Mencegah multiple UI
if game.CoreGui:FindFirstChild("SilentExecuteUI") then
    game.CoreGui.SilentExecuteUI:Destroy()
end

-- // ASSETS // --
local CarAssetID = "rbxassetid://6724805727"
local CrownAssetID = "rbxassetid://2001926774" 
local TrainAssetID = "rbxassetid://1331776735" 

-- // GUI CREATION // --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SilentExecuteUI"
pcall(function() ScreenGui.Parent = game.CoreGui end)
if ScreenGui.Parent ~= game.CoreGui then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -135)
MainFrame.Size = UDim2.new(0, 280, 0, 270)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- // TITLE BAR // --
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local CarIcon = Instance.new("ImageLabel")
CarIcon.Parent = TitleBar
CarIcon.BackgroundTransparency = 1
CarIcon.Position = UDim2.new(0, 8, 0.5, -12)
CarIcon.Size = UDim2.new(0, 24, 0, 24)
CarIcon.Image = CarAssetID

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 40, 0, 0)
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "+1 Car Speed 🏎️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Buttons (Minimize & Close)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -10)
CloseBtn.Size = UDim2.new(0, 25, 0, 20)
CloseBtn.Font = Enum.Font.Code
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.Position = UDim2.new(1, -70, 0.5, -10)
MinBtn.Size = UDim2.new(0, 25, 0, 20)
MinBtn.Font = Enum.Font.Code
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- // CONTENT // --
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 45)
Content.Size = UDim2.new(1, 0, 1, -65)

-- 1. Speed Input
local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = Content
SpeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedBox.Position = UDim2.new(0.5, -100, 0, 10)
SpeedBox.Size = UDim2.new(0, 200, 0, 35)
SpeedBox.Font = Enum.Font.Code
SpeedBox.PlaceholderText = "Input Speed..."
SpeedBox.Text = ""
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 8)

-- 2. Auto Wins
local WinBtn = Instance.new("TextButton")
WinBtn.Parent = Content
WinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
WinBtn.Position = UDim2.new(0.5, -100, 0, 55)
WinBtn.Size = UDim2.new(0, 200, 0, 35)
WinBtn.Font = Enum.Font.Code
WinBtn.Text = "  Auto Wins"
WinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", WinBtn).CornerRadius = UDim.new(0, 8)

local WinIcon = Instance.new("ImageLabel")
WinIcon.Parent = WinBtn
WinIcon.BackgroundTransparency = 1
WinIcon.Position = UDim2.new(0, 10, 0.5, -10)
WinIcon.Size = UDim2.new(0, 20, 0, 20)
WinIcon.Image = CrownAssetID
WinIcon.ImageColor3 = Color3.fromRGB(255, 223, 0)

-- 3. Auto Train
local TrainBtn = Instance.new("TextButton")
TrainBtn.Parent = Content
TrainBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrainBtn.Position = UDim2.new(0.5, -100, 0, 100)
TrainBtn.Size = UDim2.new(0, 200, 0, 35)
TrainBtn.Font = Enum.Font.Code
TrainBtn.Text = "  Auto Train"
TrainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TrainBtn).CornerRadius = UDim.new(0, 8)

local TrainIcon = Instance.new("ImageLabel")
TrainIcon.Parent = TrainBtn
TrainIcon.BackgroundTransparency = 1
TrainIcon.Position = UDim2.new(0, 10, 0.5, -10)
TrainIcon.Size = UDim2.new(0, 20, 0, 20)
TrainIcon.Image = TrainAssetID
TrainIcon.ImageColor3 = Color3.fromRGB(0, 255, 255)

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Size = UDim2.new(1, 0, 0, 15)
Footer.Font = Enum.Font.Code
Footer.Text = "Made By @SilentExecute"
Footer.TextColor3 = Color3.fromRGB(150, 150, 150)
Footer.TextSize = 12

-- // LOGIC // --

-- RGB Title
task.spawn(function()
    while task.wait() do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Title.TextColor3 = color
        CarIcon.ImageColor3 = color
    end
end)

-- Draggable (PC & Android)
local dragStart, startPos, dragging
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- Minimize & Close
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 280, 0, 40) or UDim2.new(0, 280, 0, 270)
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
    Content.Visible = not isMinimized
    Footer.Visible = not isMinimized
    MinBtn.Text = isMinimized and "+" or "-"
end)

-- WalkSpeed
SpeedBox.FocusLost:Connect(function()
    local s = tonumber(SpeedBox.Text)
    if s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = s end
end)

-- AUTO WINS LOGIC
local winLoop = false
WinBtn.MouseButton1Click:Connect(function()
    winLoop = not winLoop
    WinBtn.BackgroundColor3 = winLoop and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(45, 45, 45)
    task.spawn(function()
        while winLoop do
            pcall(function()
                local zone = workspace.Game:GetChildren()[21].WinButton.Zone
                LocalPlayer.Character.HumanoidRootPart.CFrame = zone.CFrame
            end)
            task.wait(0.2)
        end
    end)
end)

-- AUTO TRAIN LOGIC (Path Updated)
local trainLoop = false
TrainBtn.MouseButton1Click:Connect(function()
    trainLoop = not trainLoop
    TrainBtn.BackgroundColor3 = trainLoop and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(45, 45, 45)
    
    task.spawn(function()
        while trainLoop do
            pcall(function()
                -- Target path yang kamu berikan
                local target = workspace.Treadmills.Regular.RunPosition
                if target and LocalPlayer.Character then
                    -- Teleport posisi karakter ke RunPosition treadmill
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame
                end
            end)
            task.wait(0.1) -- Loop cepat agar tidak terpental keluar
        end
    end)
end)
