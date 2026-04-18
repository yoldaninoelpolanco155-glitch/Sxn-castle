-- Sxn Castle 🏴‍☠️ ELITE GLASS EDITION
local UI_NAME = "Sxn Castle 🏴‍☠️"
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SxnCastle_Glass_V22") then CoreGui.SxnCastle_Glass_V22:Destroy() end

local Players, RS, Camera = game:GetService("Players"), game:GetService("RunService"), workspace.CurrentCamera
local LP = Players.LocalPlayer
local Aim, Hit, Esp = false, false, false
local Holding = false
local FSize, HSize = 150, 5 

-- 1. INTRO GLASSMORPHISM (EDITADO: MEDIO VISIBLE Y ESTÉTICO)
local sg = Instance.new("ScreenGui", CoreGui); sg.Name = "SxnCastle_Glass_V22"

local GlassFrame = Instance.new("Frame", sg)
GlassFrame.Size = UDim2.new(0, 400, 0, 180)
GlassFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
GlassFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GlassFrame.BackgroundTransparency = 0.5 -- Efecto medio invisible / cristal
GlassFrame.BorderSizePixel = 0
Instance.new("UICorner", GlassFrame).CornerRadius = UDim.new(0, 20)

local GlassStroke = Instance.new("UIStroke", GlassFrame)
GlassStroke.Color = Color3.new(1, 0, 0)
GlassStroke.Thickness = 2.5
GlassStroke.Transparency = 0.3

-- TEXTOS DE LA INTRO
local WelcomeT = Instance.new("TextLabel", GlassFrame)
WelcomeT.Size = UDim2.new(1, 0, 0, 50); WelcomeT.Position = UDim2.new(0, 0, 0, 20)
WelcomeT.Text = "Welcome To Sxn Castle"; WelcomeT.TextColor3 = Color3.new(1, 1, 1); WelcomeT.Font = "GothamBold"; WelcomeT.TextSize = 30; WelcomeT.BackgroundTransparency = 1

local CreatorT = Instance.new("TextLabel", GlassFrame)
CreatorT.Size = UDim2.new(1, 0, 0, 30); CreatorT.Position = UDim2.new(0, 0, 0, 75)
CreatorT.Text = "👑 Creator by Sxn"; CreatorT.TextColor3 = Color3.new(1, 0, 0); CreatorT.Font = "GothamSemibold"; CreatorT.TextSize = 22; CreatorT.BackgroundTransparency = 1

local DiscordT = Instance.new("TextLabel", GlassFrame)
DiscordT.Size = UDim2.new(1, 0, 0, 30); DiscordT.Position = UDim2.new(0, 0, 0, 110)
DiscordT.Text = "🎮 fake sxn"; DiscordT.TextColor3 = Color3.fromRGB(114, 137, 218); DiscordT.Font = "GothamBold"; DiscordT.TextSize = 20; DiscordT.BackgroundTransparency = 1

-- Animación de la Intro (Sin borrar nada)
task.spawn(function()
    GlassFrame.BackgroundTransparency = 1; GlassStroke.Transparency = 1
    WelcomeT.TextTransparency = 1; CreatorT.TextTransparency = 1; DiscordT.TextTransparency = 1
    for i = 1, 0, -0.05 do
        GlassFrame.BackgroundTransparency = 0.5 + (i * 0.5)
        GlassStroke.Transparency = i; WelcomeT.TextTransparency = i; CreatorT.TextTransparency = i; DiscordT.TextTransparency = i
        task.wait(0.02)
    end
    task.wait(2.5)
    GlassFrame:TweenPosition(UDim2.new(0.5, -200, 0.2, -90), "Out", "Quad", 0.6)
    for i = 0, 1, 0.05 do
        GlassFrame.BackgroundTransparency = i; GlassStroke.Transparency = i; WelcomeT.TextTransparency = i; CreatorT.TextTransparency = i; DiscordT.TextTransparency = i
        task.wait(0.02)
    end
    GlassFrame:Destroy()
end)

-- 2. MENÚ PRINCIPAL (MANTIENE TODO LO ANTERIOR)
local Main = Instance.new("Frame", sg); Main.Size = UDim2.new(0, 300, 0, 480); Main.Position = UDim2.new(0.5, -150, 1.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local MainS = Instance.new("UIStroke", Main); MainS.Color = Color3.new(1,0,0); MainS.Thickness = 2

local T = Instance.new("TextLabel", Main); T.Size = UDim2.new(1, 0, 0, 70); T.Text = UI_NAME; T.TextColor3 = Color3.new(1,0,0); T.Font = "GothamBold"; T.TextSize = 28; T.BackgroundTransparency = 1
local List = Instance.new("ScrollingFrame", Main); List.Size = UDim2.new(1, -20, 1, -100); List.Position = UDim2.new(0, 10, 0, 80); List.BackgroundTransparency = 1; List.ScrollBarThickness = 0
Instance.new("UIListLayout", List).Padding = UDim.new(0, 12); Instance.new("UIListLayout", List).HorizontalAlignment = "Center"

local function makeBtn(txt, cb)
    local b = Instance.new("TextButton", List); b.Size = UDim2.new(0.95, 0, 0, 55); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(20, 20, 20); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"; b.TextSize = 15; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", b); s.Color = Color3.fromRGB(40, 40, 40); s.Thickness = 1.5
    b.MouseButton1Click:Connect(function()
        local active = cb()
        b.BackgroundColor3 = active and Color3.fromRGB(35, 5, 5) or Color3.fromRGB(20, 20, 20)
        b.TextColor3 = active and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)
        s.Color = active and Color3.new(1, 0, 0) or Color3.fromRGB(40, 40, 40)
    end)
end

-- FOV CIRCLE
local FOVCircle = Instance.new("Frame", sg); FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5); FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0); FOVCircle.Size = UDim2.new(0, FSize * 2, 0, FSize * 2); FOVCircle.BackgroundTransparency = 1; FOVCircle.Visible = false; Instance.new("UIStroke", FOVCircle).Color = Color3.new(1,0,0); Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)

makeBtn("Aimbot Instantáneo (Snap)", function() Aim = not Aim; FOVCircle.Visible = Aim; return Aim end)

local SBtn = Instance.new("TextButton", List); SBtn.Size = UDim2.new(0.95, 0, 0, 50); SBtn.Text = "Rango Aimbot: " .. FSize; SBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); SBtn.TextColor3 = Color3.new(1,1,1); SBtn.Font = "GothamBold"; Instance.new("UICorner", SBtn)
SBtn.MouseButton1Click:Connect(function() FSize = FSize + 50; if FSize > 500 then FSize = 50 end; SBtn.Text = "Rango Aimbot: " .. FSize; FOVCircle.Size = UDim2.new(0, FSize * 2, 0, FSize * 2) end)

makeBtn("Cabezotas Reales", function() Hit = not Hit; return Hit end)
makeBtn("Palitos Wallhack", function() Esp = not Esp; return Esp end)

makeBtn("Minimizar", function()
    Main.Visible = false
    local Bar = Instance.new("TextButton", sg); Bar.Size = UDim2.new(0, 280, 0, 50); Bar.Position = UDim2.new(0.5, -140, 0, 25); Bar.BackgroundColor3 = Color3.new(0,0,0); Bar.Text = UI_NAME; Bar.TextColor3 = Color3.new(1,0,0); Bar.Font = "GothamBold"; Bar.Active = true; Bar.Draggable = true; Instance.new("UICorner", Bar); Instance.new("UIStroke", Bar).Color = Color3.new(1,0,0)
    Bar.MouseButton1Click:Connect(function() Main.Visible = true; Bar:Destroy() end); return false
end)

task.delay(2.5, function() Main:TweenPosition(UDim2.new(0.1, 0, 0.4, 0), "Out", "Back", 0.7) end)

-- 4. MOTOR (INSTANTÁNEO + LÓGICA DE SIEMPRE)
RS.RenderStepped:Connect(function()
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2); local target = nil; local closestWorldDist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
            local head = p.Character.Head
            if Esp then
                local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                if t then
                    local a = t:FindFirstChild("SxnESP") or Instance.new("BoxHandleAdornment", t); a.Name = "SxnESP"; a.Adornee = t; a.AlwaysOnTop = true; a.Visible = true; a.Color3 = Color3.new(1,1,1); a.Size = Vector3.new(0.2, 5.5, 0.2)
                end
            end
            if Hit then head.Size = Vector3.new(HSize, HSize, HSize); head.CanCollide = false end
            if Aim and Holding then
                local sPos, vis = Camera:WorldToViewportPoint(head.Position)
                if vis then
                    local mouseDist = (Vector2.new(sPos.X, sPos.Y) - center).Magnitude
                    if mouseDist < FSize then
                        local worldDist = (head.Position - Camera.CFrame.Position).Magnitude
                        if worldDist < closestWorldDist then closestWorldDist = worldDist; target = head end
                    end
                end
            end
        end
    end
    if target and Aim and Holding then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position) end
end)

local Trig = Instance.new("TextButton", sg); Trig.Size = UDim2.new(0.5, 0, 1, 0); Trig.Position = UDim2.new(0.5, 0, 0, 0); Trig.BackgroundTransparency = 1; Trig.Text = ""; Trig.MouseButton1Down:Connect(function() Holding = true end); Trig.MouseButton1Up:Connect(function() Holding = false end)
