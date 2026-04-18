-- SXN CASTLE 👑 ELITE V53 (GOLD EDITION)
local UI_NAME, SUB_NAME = "Sxn Castle 👑", "Mobile Cheat"
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if game:GetService("CoreGui"):FindFirstChild("SxnV53") then game:GetService("CoreGui").SxnV53:Destroy() end

local Aim, Hit, Esp, SpeedClicker = false, false, false, false
local Holding, HSize, MaxDist = false, 4, 800
local Target = nil

local sg = Instance.new("ScreenGui", game:GetService("CoreGui")); sg.Name = "SxnV53"

-- INTRO WOW (ELEGANTE Y LIMPIA)
local IntroFrame = Instance.new("Frame", sg)
IntroFrame.Size = UDim2.new(0, 320, 0, 180)
IntroFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
IntroFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroFrame.BorderSizePixel = 0
local iCorner = Instance.new("UICorner", IntroFrame); iCorner.CornerRadius = UDim.new(0, 20)
local iStroke = Instance.new("UIStroke", IntroFrame); iStroke.Color = Color3.new(1, 0, 0); iStroke.Thickness = 2

local Welcome = Instance.new("TextLabel", IntroFrame)
Welcome.Size = UDim2.new(1, 0, 0, 40); Welcome.Position = UDim2.new(0, 0, 0, 30)
Welcome.Text = "Welcome To Castle Of Cheat 📛"; Welcome.TextColor3 = Color3.new(1, 1, 1)
Welcome.Font = "GothamBold"; Welcome.TextSize = 16; Welcome.BackgroundTransparency = 1

local Creator = Instance.new("TextLabel", IntroFrame)
Creator.Size = UDim2.new(1, 0, 0, 30); Creator.Position = UDim2.new(0, 0, 0, 70)
Creator.Text = "👑 Creator by Sxn"; Creator.TextColor3 = Color3.fromRGB(255, 215, 0)
Creator.Font = "GothamBold"; Creator.TextSize = 14; Creator.BackgroundTransparency = 1

local UserDC = Instance.new("TextLabel", IntroFrame)
UserDC.Size = UDim2.new(1, 0, 0, 30); UserDC.Position = UDim2.new(0, 0, 0, 100)
UserDC.Text = "💳 fakesxn (username DC)"; UserDC.TextColor3 = Color3.fromRGB(200, 200, 200)
UserDC.Font = "GothamBold"; UserDC.TextSize = 12; UserDC.BackgroundTransparency = 1

task.spawn(function()
    IntroFrame.BackgroundTransparency = 1; Welcome.TextTransparency = 1; Creator.TextTransparency = 1; UserDC.TextTransparency = 1; iStroke.Transparency = 1
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(iStroke, TweenInfo.new(1), {Transparency = 0}):Play()
    TweenService:Create(Welcome, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(0.5)
    TweenService:Create(Creator, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(0.5)
    TweenService:Create(UserDC, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(3)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), BackgroundTransparency = 1}):Play()
    TweenService:Create(Welcome, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(Creator, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(UserDC, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(1); IntroFrame:Destroy()
end)

-- MENU NEÓN (SIN CAMBIOS EN BOTONES)
local Main = Instance.new("Frame", sg); Main.Size = UDim2.new(0, 215, 0, 380); Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 8); Main.Active = true; Main.Draggable = true; Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.new(1, 0, 0); MainStroke.Thickness = 2.2

local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 55); Top.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Top.BorderSizePixel = 0; Instance.new("UICorner", Top)
local Title = Instance.new("TextLabel", Top); Title.Size = UDim2.new(1, 0, 0, 25); Title.Position = UDim2.new(0, 12, 0, 8); Title.Text = UI_NAME; Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = "GothamBold"; Title.TextSize = 17; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1
local Sub = Instance.new("TextLabel", Top); Sub.Size = UDim2.new(1, 0, 0, 15); Sub.Position = UDim2.new(0, 12, 0, 28); Sub.Text = SUB_NAME; Sub.TextColor3 = Color3.fromRGB(200, 200, 200); Sub.Font = "GothamBold"; Sub.TextSize = 11; Sub.TextXAlignment = "Left"; Sub.BackgroundTransparency = 1

local Container = Instance.new("ScrollingFrame", Main); Container.Size = UDim2.new(1, -16, 1, -70); Container.Position = UDim2.new(0, 8, 0, 60); Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 0
local List = Instance.new("UIListLayout", Container); List.Padding = UDim.new(0, 8)

local function AddButton(txt, callback)
    local btn = Instance.new("TextButton", Container); btn.Size = UDim2.new(1, 0, 0, 42); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.fromRGB(180, 180, 180); btn.Font = "GothamBold"; btn.TextSize = 12; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(50, 50, 50); s.Thickness = 1.5
    btn.MouseButton1Click:Connect(function()
        local active = callback()
        btn.TextColor3 = active and Color3.new(1, 1, 1) or Color3.fromRGB(180, 180, 180)
        s.Color = active and Color3.new(1, 0, 0) or Color3.fromRGB(50, 50, 50)
    end)
    return btn
end

AddButton("Aimbot Head Snap", function() Aim = not Aim; return Aim end)
AddButton("Hitbox Cabezota (4)", function() Hit = not Hit; return Hit end)
AddButton("ESP Notable (Armas)", function() Esp = not Esp; return Esp end)
AddButton("Speed Clicker (X3)", function() SpeedClicker = not SpeedClicker; return SpeedClicker end)

-- LÓGICA AIMBOT STICKY Y ESP
local function GetClosest()
    local target, dist = nil, MaxDist
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
            local d = (p.Character.Head.Position - LP.Character.Head.Position).Magnitude
            if d < dist then target = p; dist = d end
        end
    end
    return target
end

RS.RenderStepped:Connect(function()
    if Aim and Holding then
        if not Target or not Target.Character or not Target.Character:FindFirstChild("Head") or Target.Character.Humanoid.Health <= 0 then
            Target = GetClosest()
        end
        if Target then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Target.Character.Head.Position)
        end
    else
        Target = nil
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            if Esp and p.Character.Humanoid.Health > 0 then
                local bGui = head:FindFirstChild("SxnLabels") or Instance.new("BillboardGui", head)
                bGui.Name = "SxnLabels"; bGui.AlwaysOnTop = true; bGui.
