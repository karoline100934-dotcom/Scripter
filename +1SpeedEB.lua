--[[ 
    UI Made By @SilentExecute 
    Game: Backrooms Escape ☢️
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Clean up existing UI
if game.CoreGui:FindFirstChild("SilentExecuteUI") then
    game.CoreGui.SilentExecuteUI:Destroy()
end

-- // ASSETS // --
local Icons = {
    Car = "rbxassetid://6724805727",
    Crown = "rbxassetid://2001926774",
    Train = "rbxassetid://1331776735",
    Jump = "rbxassetid://1331776735" -- Menggunakan petir sebagai simbol tenaga lompat
}

-- // GUI CREATION // --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SilentExecuteUI"
pcall(function() ScreenGui.Parent = game.CoreGui end)
if ScreenGui.Parent ~= game.CoreGui then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -130)
MainFrame.Size = UDim2.new(0, 280, 0, 260) -- Ukuran disesuaikan kembali
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- // TITLE BAR // --
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local CarIcon = Instance.new("ImageLabel")
CarIcon.Parent = TitleBar
CarIcon.BackgroundTransparency = 1
CarIcon.Position = UDim2.new(0, 10, 0.5, -10)
CarIcon.Size = UDim2.new(0, 20, 0, 20)
CarIcon.Image = Icons.Car

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 38, 0, 0)
Title.Size = UDim2.new(0, 180, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "+1 Speed Backrooms Escape ☢️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Control Buttons
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -10)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseBtn)

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.Position = UDim2.new(1, -55, 0.5, -10)
MinBtn.Size = UDim2.new(0, 20, 0, 20)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", MinBtn)

-- // CONTENT AREA // --
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.Position = UDim2.new(0, 0, 0, 45)
Content.Size = UDim2.new(1, 0, 1, -65)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout")
UIList.Parent = Content
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- 1. Manual WalkSpeed
local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = Content
SpeedInput.Size = UDim2.new(0, 240, 0, 35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.Font = Enum.Font.Code
SpeedInput.PlaceholderText = "Input WalkSpeed..."
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedInput)

-- 2. Auto Wins Button
local WinBtn = Instance.new("TextButton")
WinBtn.Parent = Content
WinBtn.Size = UDim2.new(0, 240, 0, 35)
WinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
WinBtn.Font = Enum.Font.Code
WinBtn.Text = "    Auto Wins"
WinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", WinBtn)

local WinIcon = Instance.new("ImageLabel")
WinIcon.Parent = WinBtn
WinIcon.Position = UDim2.new(0, 10, 0.5, -10)
WinIcon.Size = UDim2.new(0, 20, 0, 20)
WinIcon.BackgroundTransparency = 1
WinIcon.Image = Icons.Crown

-- 3. Auto Train Button
local TrainBtn = Instance.new("TextButton")
TrainBtn.Parent = Content
TrainBtn.Size = UDim2.new(0, 240, 0, 35)
TrainBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TrainBtn.Font = Enum.Font.Code
TrainBtn.Text = "    Auto Train"
TrainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TrainBtn)

local TrainIcon = Instance.new("ImageLabel")
TrainIcon.Parent = TrainBtn
TrainIcon.Position = UDim2.new(0, 10, 0.5, -10)
TrainIcon.Size = UDim2.new(0, 20, 0, 20)
TrainIcon.BackgroundTransparency = 1
TrainIcon.Image = Icons.Train

-- 4. Inf Jump Button
local JumpBtn = Instance.new("TextButton")
JumpBtn.Parent = Content
JumpBtn.Size = UDim2.new(0, 240, 0, 35)
JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpBtn.Font = Enum.Font.Code
JumpBtn.Text = "    Infinite Jump"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JumpBtn)

local JumpIcon = Instance.new("ImageLabel")
JumpIcon.Parent = JumpBtn
JumpIcon.Position = UDim2.new(0, 10, 0.5, -10)
JumpIcon.Size = UDim2.new(0, 20, 0, 20)
JumpIcon.BackgroundTransparency = 1
JumpIcon.Image = Icons.Jump
JumpIcon.ImageColor3 = Color3.fromRGB(255, 255, 0)

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Code
Footer.Text = "Made By @SilentExecute"
Footer.TextColor3 = Color3.fromRGB(150, 150, 150)
Footer.TextSize = 12

-- // LOGICS // --

-- RGB Animation
task.spawn(function()
    while task.wait() do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Title.TextColor3 = color
        CarIcon.ImageColor3 = color
    end
end)

-- Dragging (Smooth PC & Android)
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
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

-- Minimize & Close
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
local isMin = false
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = isMin and UDim2.new(0, 280, 0, 40) or UDim2.new(0, 280, 0, 260)}):Play()
    Content.Visible = not isMin
    Footer.Visible = not isMin
    MinBtn.Text = isMin and "+" or "-"
end)

-- WalkSpeed
SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = val end
end)

-- Auto Win (Path Fixed)
local winOn = false
WinBtn.MouseButton1Click:Connect(function()
    winOn = not winOn
    WinBtn.BackgroundColor3 = winOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 40)
    task.spawn(function()
        while winOn do
            pcall(function()
                local part = workspace.WinPads:GetChildren()[8].TouchPart
                LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
            end)
            task.wait(0.5)
        end
    end)
end)

-- Auto Train (Path Fixed)
local trainOn = false
TrainBtn.MouseButton1Click:Connect(function()
    trainOn = not trainOn
    TrainBtn.BackgroundColor3 = trainOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 40)
    task.spawn(function()
        while trainOn do
            pcall(function()
                local part = workspace.Treadmills["1"].TouchPart
                LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
            end)
            task.wait(0.2)
        end
    end)
end)

-- Infinite Jump
local infJumpOn = false
JumpBtn.MouseButton1Click:Connect(function()
    infJumpOn = not infJumpOn
    JumpBtn.BackgroundColor3 = infJumpOn and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(40, 40, 40)
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
