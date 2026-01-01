--[[
    Be A Parkour Ninja | SilentExecutor
    Version: V1.0
    Features: Hitbox Custom, Movement Sliders, Inf Jump, Noclip, Fullbright, NoFog, Server Hop/Rejoin
    UI: Rayfield
]]

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

-- =========================
-- Rayfield UI
-- =========================
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libraries/main/Rayfield.lua"))()
local Window = Rayfield:CreateWindow({
    Name = "Be A Parkour Ninja | SilentExecutor",
    LoadingTitle = "Be A Parkour Ninja",
    LoadingSubtitle = "SilentExecutor V1.0",
    ConfigurationSaving = {Enabled = true, FolderName = "ParkourNinja", FileName = "Config"},
    KeySystem = false
})

-- Tabs
local HitboxTab = Window:CreateTab("Hitbox")
local MovementTab = Window:CreateTab("Movement")
local OtherTab = Window:CreateTab("Other")

-- =========================
-- HITBOX TAB
-- =========================
HitboxTab:CreateButton({
    Name = "Load Hitbox Script",
    Callback = function()
        local status, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Luminaproject/main/LuminaHBv1.lua"))()
        end)
        if not status then
            warn("Failed to load hitbox: "..tostring(err))
        end
    end
})

local hitboxSize = 15
local hitboxColor = BrickColor.new("Lime green")

HitboxTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {5,100},
    Increment = 1,
    CurrentValue = 15,
    Callback = function(val)
        hitboxSize = val
        _G.HeadSize = hitboxSize
    end
})

HitboxTab:CreateColorPicker({
    Name = "Hitbox Color",
    Default = Color3.fromRGB(0,255,0),
    Callback = function(color)
        hitboxColor = BrickColor.new(color)
        _G.SelectedColor = hitboxColor
    end
})

-- =========================
-- MOVEMENT TAB
-- =========================
local walkSpeed = 16
local jumpPower = 50
local infJump = false
local noclip = false

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16,500},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(val)
        walkSpeed = val
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    end
})

MovementTab:CreateSlider({
    Name = "JumpPower",
    Range = {50,500},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(val)
        jumpPower = val
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = jumpPower
        end
    end
})

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(val) infJump = val end
})

UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(val) noclip = val end
})

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- =========================
-- OTHER TAB
-- =========================
local fullbrightEnabled = false
local nofogEnabled = false

OtherTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Callback = function(val)
        fullbrightEnabled = val
        if val then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 1000
        end
    end
})

OtherTab:CreateToggle({
    Name = "NoFog",
    CurrentValue = false,
    Callback = function(val)
        nofogEnabled = val
        if val then
            Lighting.FogEnd = 100000
        else
            Lighting.FogEnd = 1000
        end
    end
})

OtherTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local PlaceID = game.PlaceId
        local Servers = {}
        local AllIDs = {}
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and result and result.data then
            for i,v in pairs(result.data) do
                if v.id ~= game.JobId and v.playing < v.maxPlayers then
                    table.insert(Servers,v.id)
                end
            end
        end
        if #Servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceID, Servers[math.random(1,#Servers)], LocalPlayer)
        end
    end
})

OtherTab:CreateButton({
    Name = "Server Rejoin",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

print("Be A Parkour Ninja | SilentExecutor V1.0 loaded successfully")
