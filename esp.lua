-- c00lkidd214anzz Hub (Big UI Menu Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled = true
local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
local Custom_Speed = 16
local Custom_Jump = 50
local espObjects = {}

-- 1. Ватермарк
local watermark = Drawing.new("Text")
watermark.Text = "c00lkidd214anzz Hub"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Outline = true
watermark.Position = Vector2.new(10, 30)
watermark.Visible = true
watermark.Font = 2

-- 2. Создание UI
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))

-- Главная перетаскиваемая кнопка-открывашка
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 160, 0, 45)
mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
mainToggle.Text = "c00lkidd214anzz Menu"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.TextSize = 15
mainToggle.Draggable = true
mainToggle.Active = true
Instance.new("UICorner", mainToggle)

-- === БОЛЬШОЕ ОСНОВНОЕ МЕНЮ ===
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 280) -- Большой размер
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 55)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
Instance.new("UICorner", mainFrame)

-- Левая панель для вкладок (Сайдбар)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local uiCornerSidebar = Instance.new("UICorner", sidebar)

-- Контейнеры для содержимого вкладок (Правая часть)
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 300, 1, 0)
visualsPage.Position = UDim2.new(0, 140, 0, 0)
visualsPage.BackgroundTransparency = 1
visualsPage.Visible = true

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 300, 1, 0)
playerPage.Position = UDim2.new(0, 140, 0, 0)
playerPage.BackgroundTransparency = 1
playerPage.Visible = false

-- Функция переключения страниц
local function showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
end

-- === КНОПКИ ВКЛАДОК В СИДБАРЕ ===
local tabVisuals = Instance.new("TextButton", sidebar)
tabVisuals.Size = UDim2.new(0, 110, 0, 35)
tabVisuals.Position = UDim2.new(0, 10, 0, 20)
tabVisuals.Text = "Visuals (ESP)"
tabVisuals.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabVisuals.TextColor3 = Color3.fromRGB(255, 255, 255)
tabVisuals.Font = Enum.Font.SourceSansBold
tabVisuals.TextSize = 14
Instance.new("UICorner", tabVisuals)
tabVisuals.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tabPlayer = Instance.new("TextButton", sidebar)
tabPlayer.Size = UDim2.new(0, 110, 0, 35)
tabPlayer.Position = UDim2.new(0, 10, 0, 65)
tabPlayer.Text = "Player (Кастом)"
tabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
tabPlayer.Font = Enum.Font.SourceSansBold
tabPlayer.TextSize = 14
Instance.new("UICorner", tabPlayer)
tabPlayer.MouseButton1Click:Connect(function() showPage(playerPage) end)


-- === КОНТЕНТ ВКЛАДКИ VISUALS ===
local espToggleBtn = Instance.new("TextButton", visualsPage)
espToggleBtn.Size = UDim2.new(0, 200, 0, 40)
espToggleBtn.Position = UDim2.new(0, 10, 0, 20)
espToggleBtn.Text = "ESP: ON"
espToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
espToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggleBtn.Font = Enum.Font.SourceSansBold
espToggleBtn.TextSize = 14
Instance.new("UICorner", espToggleBtn)

espToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espToggleBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espToggleBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    if not ESP_Enabled then
        for _, obj in pairs(espObjects) do 
            obj.Box.Visible = false 
            obj.Tracer.Visible = false 
        end
    end
end)

local tracerLabel = Instance.new("TextLabel", visualsPage)
tracerLabel.Size = UDim2.new(0, 200, 0, 20)
tracerLabel.Position = UDim2.new(0, 10, 0, 80)
tracerLabel.Text = "Положение линий трейсеров:"
tracerLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
tracerLabel.BackgroundTransparency = 1
tracerLabel.Font = Enum.Font.SourceSans
tracerLabel.TextSize = 14
tracerLabel.TextXAlignment = Enum.TextXAlignment.Left

local tracerModeBtn = Instance.new("TextButton", visualsPage)
tracerModeBtn.Size = UDim2.new(0, 200, 0, 40)
tracerModeBtn.Position = UDim2.new(0, 10, 0, 105)
tracerModeBtn.Text = "НИЗ ЭКРАНА"
tracerModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tracerModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerModeBtn.Font = Enum.Font.SourceSansBold
tracerModeBtn.TextSize = 14
Instance.new("UICorner", tracerModeBtn)

tracerModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then
        Tracer_Mode = "Center"
        tracerModeBtn.Text = "ЦЕНТР ЭКРАНА"
    elseif Tracer_Mode == "Center" then
        Tracer_Mode = "Top"
        tracerModeBtn.Text = "ВВЕРХ ЭКРАНА"
    else
        Tracer_Mode = "Bottom"
        tracerModeBtn.Text = "НИЗ ЭКРАНА"
    end
end)


-- === КОНТЕНТ ВКЛАДКИ PLAYER ===
-- Скорость бега
local speedBtn = Instance.new("TextButton", playerPage)
speedBtn.Size = UDim2.new(0, 200, 0, 40)
speedBtn.Position = UDim2.new(0, 10, 0, 20)
speedBtn.Text = "Быстрый бег: Выкл (16)"
speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    if Custom_Speed == 16 then
        Custom_Speed = 50 -- Твоя новая скорость
        speedBtn.Text = "Быстрый бег: Вкл (50)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        Custom_Speed = 16
        speedBtn.Text = "Быстрый бег: Выкл (16)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

-- Высота прыжка
local jumpBtn = Instance.new("TextButton", playerPage)
jumpBtn.Size = UDim2.new(0, 200, 0, 40)
jumpBtn.Position = UDim2.new(0, 10, 0, 75)
jumpBtn.Text = "Высокий прыжок: Выкл"
jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.TextSize = 14
Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    if Custom_Jump == 50 then
        Custom_Jump = 120 -- Твоя новая высота прыжка
        jumpBtn.Text = "Высокий прыжок: Вкл (120)"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        Custom_Jump = 50
        jumpBtn.Text = "Высокий прыжок: Выкл"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

local Hitbox_Enabled = false
local Hitbox_Size = 5 -- Размер хитбокса (насколько легко попасть)

local hitBtn = Instance.new("TextButton", playerPage)
hitBtn.Size = UDim2.new(0, 250, 0, 45)
hitBtn.Position = UDim2.new(0, 15, 0, 130) -- Расположил ниже кнопки прыжка
hitBtn.Text = "Hitbox: OFF"
hitBtn.TextColor3 = Color3.new(1,1,1)
hitBtn.Font = Enum.Font.SourceSansBold
hitBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
hitBtn.ZIndex = 7
Instance.new("UICorner", hitBtn)

hitBtn.MouseButton1Click:Connect(function()
    Hitbox_Enabled = not Hitbox_Enabled
    hitBtn.Text = Hitbox_Enabled and "Hitbox: ON" or "Hitbox: OFF"
    hitBtn.BackgroundColor3 = Hitbox_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40,40,40)
end)

-- Логика расширения хитбоксов 
RunService.RenderStepped:Connect(function()
    if Hitbox_Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                -- Увеличиваем размер (Transparency сделан 0.5, чтобы видеть, на что ты целишься)
                hrp.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size)
                hrp.Transparency = 0.5
                hrp.BrickColor = BrickColor.new("Really red")
                hrp.CanCollide = false
            end
        end
    else
        -- Возвращаем стандартный размер (2, 2, 1), если выключили
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                p.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end)

-- === ЛОГИКА ДВИЖЕНИЯ И ОТКРЫТИЯ МЕНЮ ===
mainToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
end)

mainToggle.Changed:Connect(function(prop)
    if prop == "Position" then
        mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
    end
end)


-- === МЕХАНИКА И ЯДРО ESP ===
local function createESPItems()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Filled = false
    box.Thickness = 2

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5

    return {Box = box, Tracer = tracer}
end

local function removeESPItems(player)
    if espObjects[player] then
        espObjects[player].Box:Remove()
        espObjects[player].Tracer:Remove()
        espObjects[player] = nil
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then espObjects[player] = createESPItems() end
end

Players.PlayerAdded:Connect(function(player)
    espObjects[player] = createESPItems()
end)

Players.PlayerRemoving:Connect(function(player)
    removeESPItems(player)
end)


-- === ЦИКЛ ОБНОВЛЕНИЯ КАДРОВ (RenderStepped) ===
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
    -- Постоянно применяем кастомную скорость и прыжок к нашему персонажу
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Custom_Speed
        
        -- Проверка типа прыжка (JumpPower или UseJumpPower)
        if hum.UseJumpPower then
            hum.JumpPower = Custom_Jump
        else
            hum.JumpHeight = Custom_Jump / 3 -- Конвертация для новых систем прыжков
        end
    end

    if not ESP_Enabled then return end

    -- Положение трейсеров
    local startPoint
    if Tracer_Mode == "Bottom" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    elseif Tracer_Mode == "Center" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0)
    end

    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            -- Динамический цвет команд
            local displayColor = Color3.fromRGB(255, 255, 255)
            if player.Team then
                displayColor = player.TeamColor.Color
            end

            obj.Box.Color = displayColor
            obj.Tracer.Color = displayColor

            if onScreen then
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                -- Боксы
                obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5)
                obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2)
                obj.Box.Visible = true

                -- Трейсеры
                obj.Tracer.From = startPoint
                obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2))
                obj.Tracer.Visible = true
            else
                obj.Box.Visible = false
                obj.Tracer.Visible = false
            end
        else
            obj.Box.Visible = false
            obj.Tracer.Visible = false
        end
    end
end)

print("c00lkidd214anzz Large Tab-Menu Loaded Successfully!")
