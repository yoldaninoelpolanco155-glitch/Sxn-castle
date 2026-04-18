-- SXN CASTLE 👑 ELITE V51 (SPEED CLICKER REINFORCED)
local UI_NAME, SUB_NAME = "Sxn Castle 👑", "South Bronx Special"
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if game:GetService("CoreGui"):FindFirstChild("SxnV51") then game:GetService("CoreGui").SxnV51:Destroy() end

local Aim, Hit, Esp, SpeedClicker = false, false, false, false
local Holding, HSize, MaxDist = false, 4, 800

local sg = Instance.new("ScreenGui", game:GetService("CoreGui")); sg.Name = "SxnV51"

-- MENU NEÓN (Legible y Notable)
local Main = Instance.new("Frame", sg); Main.Size = UDim2.new(0, 215, 0, 380); Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 8); Main.Active = true; Main.Draggable = true; Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.new(1, 0, 0); MainStroke.Thickness = 2.2; MainStroke.Transparency = 0.4

local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 55); Top.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Top.BorderSizePixel = 0; Instance.new("UICorner", Top)
local Title = Instance.new("TextLabel", Top); Title.Size = UDim2.new(1, 0, 0, 25); Title.Position = UDim2.new(0, 12, 0, 8); Title.Text = UI_NAME; Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = "GothamBold"; Title.TextSize = 17; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1
local Sub = Instance.new("TextLabel", Top); Sub.Size = UDim2.new(1, 0, 0, 15); Sub.Position = UDim2.new(0, 12, 0, 28); Sub.Text = SUB_NAME; Sub.TextColor3 = Color3.fromRGB(200, 200, 200); Sub.Font = "GothamBold"; Sub.TextSize = 11; Sub.TextXAlignment = "Left"; Sub.BackgroundTransparency = 1

local Close = Instance.new("TextButton", Top); Close.Size = UDim2.new(0, 30, 0, 30); Close.Position = UDim2.new(1, -35, 0, 12); Close.Text = "×"; Close.TextColor3 = Color3.new(1,0,0); Close.BackgroundTransparency = 1; Close.TextSize = 25; Close.MouseButton1Click:Connect(function() sg:Destroy() end)
local Min = Instance.new("TextButton", Top); Min.Size = UDim2.new(0, 30, 0, 30); Min.Position = UDim2.new(1, -65, 0, 12); Min.Text = "-"; Min.TextColor3 = Color3.new(1,1,1); Min.BackgroundTransparency = 1; Min.TextSize = 25

local Container = Instance.new("ScrollingFrame", Main); Container.Size = UDim2.new(1, -16, 1, -70); Container.Position = UDim2.new(0, 8, 0, 60); Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 0
local List = Instance.new("UIListLayout", Container); List.Padding = UDim.new(0, 8)

Min.MouseButton1Click:Connect(function()
    Container.Visible = not Container.Visible
    Main:TweenSize(Container.Visible and UDim2.new(0, 215, 0, 380) or UDim2.new(0, 215, 0, 55), "Out", "Quad", 0.25)
end)

local function AddButton(txt, callback)
    local btn = Instance.new("TextButton", Container); btn.Size = UDim2.new(1, 0, 0, 42); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.fromRGB(180, 180, 180); btn.Font = "GothamBold"; btn.TextSize = 12; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(50, 50, 50); s.Thickness = 1.5
    btn.MouseButton1Click:Connect(function()
        local active = callback()
        btn.TextColor3 = active and Color3.new(1, 1, 1) or Color3.fromRGB(180, 180, 180)
        s.Color = active and Color3.new(1, 0, 0) or Color3.fromRGB(50, 50, 50)
        s.Transparency = active and 0 or 0.5
    end)
    return btn
end

-- ACTIVADORES (TODO SIGUE AQUÍ)
AddButton("Aimbot Head Snap", function() Aim = not Aim; return Aim end)
AddButton("Hitbox Cabezota (4)", function() Hit = not Hit; return Hit end)
AddButton("ESP Notable (Armas)", function() Esp = not Esp; return Esp end)
AddButton("Speed Clicker (X3)", function() SpeedClicker = not SpeedClicker; return SpeedClicker end)

-- MOTOR PRINCIPAL (ARREGLADO Y CONFIGURADO)
RS.Heartbeat:Connect(function()
    -- Speed Clicker: Dispara súper rápido solo al dejar presionado
    if SpeedClicker and Holding then
        local tool = LP.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate() -- Simulación de click ráfaga
            -- Balas Infinitas (Silent Fix)
            for _, v in pairs(tool:GetDescendants()) do
                if (v:IsA("IntValue") or v:IsA("NumberValue")) and v.Name:find("Ammo") then v.Value = 999 end
            end
        end
    end
end)

RS.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
            local char = p.Character
            local head = char.Head
            local dist = (head.Position - LP.Character.Head.Position).Magnitude
            
            -- ESP TACTICAL (Visible notable tras paredes)
            if Esp then
                local bGui = head:FindFirstChild("SxnLabels") or Instance.new("BillboardGui", head)
                bGui.Name = "SxnLabels"; bGui.AlwaysOnTop = true; bGui.Size = UDim2.new(0, 120, 0, 60); bGui.Adornee = head
                
                local txt = bGui:FindFirstChild("Info") or Instance.new("TextLabel", bGui)
                txt.Name = "Info"; txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Font = "GothamBold"
                txt.TextSize = 12; txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                
                local currentTool = char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool").Name or "Nada"
                txt.Text = "[" .. math.floor(dist) .. "m]\n" .. currentTool
                txt.TextColor3 = (dist < 25) and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)
            elseif head:FindFirstChild("SxnLabels") then head.SxnLabels:Destroy() end
            
            -- HITBOX REAL
            if Hit then
                head.Size = Vector3.new(HSize, HSize, HSize); head.Transparency = 0.5; head.CanCollide = false
            else
                head.Size = Vector3.new(1, 1, 1); head.Transparency = 0; head.CanCollide = true
            end
            
            -- AIMBOT INDEPENDIENTE
            if Aim and Holding and dist < MaxDist then
                local _, vis = Camera:WorldToViewportPoint(head.Position)
                if vis then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position) end
            end
        end
    end
end)

-- ENTRADA MÓVIL
UIS.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Holding = true end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Holding = false end end)
