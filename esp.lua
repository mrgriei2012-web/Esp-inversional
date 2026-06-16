-- c00lkidd214anzz Hub (Fixed UI Layers & Jump Feature)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled = true
local Custom_Speed = 16
local Custom_Jump = 50
local espObjects = {}

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- 1. Кнопка MENU (Двигается отдельно)
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 150, 0, 40)
mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
mainToggle.Text = "MENU"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.Draggable = true
mainToggle.Active = true
mainToggle.ZIndex = 10
Instance.new("UICorner", mainToggle)

-- 2. Большое меню (Двигается отдельно)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame)

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Сайдбар (Вкладки)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.ZIndex = 6
Instance.new("UICorner", sidebar)

-- Контейнеры страниц (ZIndex повышен, чтобы текст не пропадал)
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 280, 1, 0); visualsPage.Position = UDim2.new(0, 120, 0, 0); visualsPage.BackgroundTransparency = 1; visualsPage.ZIndex = 6

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 280, 1, 0); playerPage.Position = UDim2.new(0, 120, 0, 0); playerPage.BackgroundTransparency = 1; playerPage.Visible = false; playerPage.ZIndex = 6

local function showPage(page) 
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage) 
end

-- Кнопки вкладок
local tab1 = Instance.new("TextButton", sidebar)
tab1.Size = UDim2.new(0, 100, 0, 35); tab1.Position = UDim2.new(0, 10, 0, 20); tab1.Text = "Visuals"; tab1.BackgroundColor3 = Color3.fromRGB(40,40,40); tab1.TextColor3 = Color3.new(1,1,1); tab1.Font = Enum.Font.SourceSansBold; tab1.ZIndex = 7
Instance.new("UICorner", tab1)
tab1.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tab2 = Instance.new("TextButton", sidebar)
tab2.Size = UDim2.new(0, 100, 0, 35); tab2.Position = UDim2.new(0, 10, 0, 65); tab2.Text = "Player"; tab2.BackgroundColor3 = Color3.fromRGB(40,40,40); tab2.TextColor3 = Color3.new(1,1,1); tab2.Font = Enum.Font.SourceSansBold; tab2.ZIndex = 7
Instance.new("UICorner", tab2)
tab2.MouseButton1Click:Connect(function() showPage(playerPage) end)

-- === Контент вкладки VISUALS ===
local espBtn = Instance.new("TextButton", visualsPage)
espBtn.Size = UDim2.new(0, 250, 0, 45); espBtn.Position = UDim2.new(0, 15, 0, 20); espBtn.Text = "ESP: ON"; espBtn.TextColor3 = Color3.new(1,1,1); espBtn.Font = Enum.Font.SourceSansBold; espBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); espBtn.ZIndex = 7
Instance.new("UICorner", espBtn)
espBtn.MouseButton1Click:Connect(function() 
    ESP_Enabled = not ESP_Enabled
    espBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- === Контент вкладки PLAYER (Скорость и Прыжок вернулись) ===
local spdBtn = Instance.new("TextButton", playerPage)
spdBtn.Size = UDim2.new(0, 250, 0, 45); spdBtn.Position = UDim2.new(0, 15, 0, 20); spdBtn.Text = "SPEED: 16"; spdBtn.TextColor3 = Color3.new(1,1,1); spdBtn.Font = Enum.Font.SourceSansBold; spdBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); spdBtn.ZIndex = 7
Instance.new("UICorner", spdBtn)
spdBtn.MouseButton1Click:Connect(function() 
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    spdBtn.Text = "SPEED: " .. Custom_Speed 
    spdBtn.BackgroundColor3 = (Custom_Speed == 50) and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40,40,40)
end)

local jmpBtn = Instance.new("TextButton", playerPage)
jmpBtn.Size = UDim2.new(0, 250, 0, 45); jmpBtn.Position = UDim2.new(0, 15, 0, 75); jmpBtn.Text = "JUMP: 50"; jmpBtn.TextColor3 = Color3.new(1,1,1); jmpBtn.Font = Enum.Font.SourceSansBold; jmpBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); jmpBtn.ZIndex = 7
Instance.new("UICorner", jmpBtn)
jmpBtn.MouseButton1Click:Connect(function() 
    Custom_Jump = (Custom_Jump == 50) and 120 or 50
    jmpBtn.Text = "JUMP: " .. Custom_Jump
    jmpBtn.BackgroundColor3 = (Custom_Jump == 120) and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40,40,40)
end)

-- ESP Логика
local function createESP() 
    local s = Drawing.new("Square")
    s.Visible = false
    s.Filled = false
    s.Thickness = 2
    s.Color = Color3.fromRGB(255, 255, 255)
    return s 
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espObjects[p] = createESP() end end
Players.PlayerAdded:Connect(function(p) espObjects[p] = createESP() end)
Players.PlayerRemoving:Connect(function(p) if espObjects[p] then espObjects[p]:Remove(); espObjects[p] = nil end end)

-- Основной рабочий цикл
RunService.RenderStepped:Connect(function()
    -- Применение скорости и прыжка
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Custom_Speed 
        if hum.UseJumpPower then
            hum.JumpPower = Custom_Jump
        else
            hum.JumpHeight = Custom_Jump / 3
        end
    end
    
    -- Отрисовка ESP
    if not ESP_Enabled then for _, o in pairs(espObjects) do o.Visible = false end return end
    
    for p, o in pairs(espObjects) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            local pos, on = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            
            -- Исправление: Не рисуем ESP там, где сейчас находится открытое меню
            local menuLeft = mainFrame.AbsolutePosition.X
            local menuRight = menuLeft + mainFrame.AbsoluteSize.X
            local menuTop = mainFrame.AbsolutePosition.Y
            local menuBottom = menuTop + mainFrame.AbsoluteSize.Y
            
            local inMenuArea = mainFrame.Visible and (pos.X >= menuLeft and pos.X <= menuRight and pos.Y >= menuTop and pos.Y <= menuBottom)

            if on and not inMenuArea then 
                o.Size = Vector2.new(50, 80)
                o.Position = Vector2.new(pos.X - 25, pos.Y - 40)
                o.Visible = true 
            else 
                o.Visible = false 
            end
        else
            if espObjects[p] then o.Visible = false end
        end
    end
end)
