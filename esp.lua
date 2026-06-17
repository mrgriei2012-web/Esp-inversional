-- c00lkidd214anzz Hub (Ultimate Master Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled = false
local Show_Names = true   
local Show_Dist = true    
local Chams_Enabled = false
local RGB_Chams = false
local Skeleton_ESP = false
local Hitbox_Enabled = false
local Noclip_Enabled = false
local Flying = false
local SpinBot_Enabled = false

local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
local Tracer_Color_Mode = "Team" -- "Team", "Red", "Green", "Blue", "Rainbow"
local Custom_Speed = 16
local Custom_Jump = 50
local Hitbox_Size = 5
local FlySpeed = 50

local espObjects = {}
local skeletons = {}
local currentRgbColor = Color3.new(1,1,1)

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
screenGui.ResetOnSpawn = false

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
mainToggle.ZIndex = 10
Instance.new("UICorner", mainToggle)

-- === БОЛЬШОЕ ОСНОВНОЕ МЕНЮ (Высота увеличена до 420) ===
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 420)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame)

mainToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Левая панель для вкладок (Сайдбар расширен на всю высоту)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.ZIndex = 6
Instance.new("UICorner", sidebar)

-- Контейнеры для содержимого вкладок
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 300, 1, 0); visualsPage.Position = UDim2.new(0, 140, 0, 0); visualsPage.BackgroundTransparency = 1; visualsPage.Visible = true; visualsPage.ZIndex = 6

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 300, 1, 0); playerPage.Position = UDim2.new(0, 140, 0, 0); playerPage.BackgroundTransparency = 1; playerPage.Visible = false; playerPage.ZIndex = 6

local teleportsPage = Instance.new("Frame", mainFrame)
teleportsPage.Size = UDim2.new(0, 300, 1, 0); teleportsPage.Position = UDim2.new(0, 140, 0, 0); teleportsPage.BackgroundTransparency = 1; teleportsPage.Visible = false; teleportsPage.ZIndex = 6

local function showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
    teleportsPage.Visible = (page == teleportsPage)
end

-- Кнопки вкладок в сайдбаре
local tabVisuals = Instance.new("TextButton", sidebar)
tabVisuals.Size = UDim2.new(0, 110, 0, 35); tabVisuals.Position = UDim2.new(0, 10, 0, 20); tabVisuals.Text = "Visuals (ESP)"; tabVisuals.BackgroundColor3 = Color3.fromRGB(35, 35, 35); tabVisuals.TextColor3 = Color3.new(1,1,1); tabVisuals.Font = Enum.Font.SourceSansBold; tabVisuals.ZIndex = 7; Instance.new("UICorner", tabVisuals)
tabVisuals.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tabPlayer = Instance.new("TextButton", sidebar)
tabPlayer.Size = UDim2.new(0, 110, 0, 35); tabPlayer.Position = UDim2.new(0, 10, 0, 65); tabPlayer.Text = "Player (Кастом)"; tabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 35); tabPlayer.TextColor3 = Color3.new(1,1,1); tabPlayer.Font = Enum.Font.SourceSansBold; tabPlayer.ZIndex = 7; Instance.new("UICorner", tabPlayer)
tabPlayer.MouseButton1Click:Connect(function() showPage(playerPage) end)

local tabTeleports = Instance.new("TextButton", sidebar)
tabTeleports.Size = UDim2.new(0, 110, 0, 35); tabTeleports.Position = UDim2.new(0, 10, 0, 110); tabTeleports.Text = "Teleports"; tabTeleports.BackgroundColor3 = Color3.fromRGB(35, 35, 35); tabTeleports.TextColor3 = Color3.new(1,1,1); tabTeleports.Font = Enum.Font.SourceSansBold; tabTeleports.ZIndex = 7; Instance.new("UICorner", tabTeleports)
tabTeleports.MouseButton1Click:Connect(function() showPage(teleportsPage) end)


-- === КОНТЕНТ ВКЛАДКИ VISUALS ===
local espToggleBtn = Instance.new("TextButton", visualsPage)
espToggleBtn.Size = UDim2.new(0, 200, 0, 35); espToggleBtn.Position = UDim2.new(0, 10, 0, 15); espToggleBtn.Text = "ESP: OFF"; espToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); espToggleBtn.TextColor3 = Color3.new(1,1,1); espToggleBtn.Font = Enum.Font.SourceSansBold; espToggleBtn.ZIndex = 8; Instance.new("UICorner", espToggleBtn)

local espSubMenu = Instance.new("Frame", visualsPage)
espSubMenu.Size = UDim2.new(0, 200, 0, 30); espSubMenu.Position = UDim2.new(0, 10, 0, 55); espSubMenu.BackgroundTransparency = 1; espSubMenu.Visible = false; espSubMenu.ZIndex = 8

local nameToggleBtn = Instance.new("TextButton", espSubMenu)
nameToggleBtn.Size = UDim2.new(0, 95, 0, 25); nameToggleBtn.Position = UDim2.new(0, 0, 0, 0); nameToggleBtn.Text = "Никнеймы: Вкл"; nameToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); nameToggleBtn.TextColor3 = Color3.new(1,1,1); nameToggleBtn.Font = Enum.Font.SourceSansBold; nameToggleBtn.TextSize = 11; nameToggleBtn.ZIndex = 9; Instance.new("UICorner", nameToggleBtn)

local distToggleBtn = Instance.new("TextButton", espSubMenu)
distToggleBtn.Size = UDim2.new(0, 95, 0, 25); distToggleBtn.Position = UDim2.new(0, 105, 0, 0); distToggleBtn.Text = "Дистанция: Вкл"; distToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); distToggleBtn.TextColor3 = Color3.new(1,1,1); distToggleBtn.Font = Enum.Font.SourceSansBold; distToggleBtn.TextSize = 11; distToggleBtn.ZIndex = 9; Instance.new("UICorner", distToggleBtn)

local chamsBtn = Instance.new("TextButton", visualsPage)
chamsBtn.Size = UDim2.new(0, 200, 0, 35); chamsBtn.Position = UDim2.new(0, 10, 0, 95); chamsBtn.Text = "Chams: OFF"; chamsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); chamsBtn.TextColor3 = Color3.new(1,1,1); chamsBtn.Font = Enum.Font.SourceSansBold; chamsBtn.ZIndex = 8; Instance.new("UICorner", chamsBtn)

local rgbChamsBtn = Instance.new("TextButton", visualsPage)
rgbChamsBtn.Size = UDim2.new(0, 200, 0, 35); rgbChamsBtn.Position = UDim2.new(0, 10, 0, 135); rgbChamsBtn.Text = "RGB Chams: OFF"; rgbChamsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); rgbChamsBtn.TextColor3 = Color3.new(1,1,1); rgbChamsBtn.Font = Enum.Font.SourceSansBold; rgbChamsBtn.ZIndex = 8; Instance.new("UICorner", rgbChamsBtn)

local skelBtn = Instance.new("TextButton", visualsPage)
skelBtn.Size = UDim2.new(0, 200, 0, 35); skelBtn.Position = UDim2.new(0, 10, 0, 175); skelBtn.Text = "Скелетоны: Выкл"; skelBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); skelBtn.TextColor3 = Color3.new(1,1,1); skelBtn.Font = Enum.Font.SourceSansBold; skelBtn.ZIndex = 8; Instance.new("UICorner", skelBtn)

local colorModeBtn = Instance.new("TextButton", visualsPage)
colorModeBtn.Size = UDim2.new(0, 200, 0, 35); colorModeBtn.Position = UDim2.new(0, 10, 0, 215); colorModeBtn.Text = "Цвет ESP: Командный"; colorModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); colorModeBtn.TextColor3 = Color3.new(1,1,1); colorModeBtn.Font = Enum.Font.SourceSansBold; colorModeBtn.ZIndex = 8; Instance.new("UICorner", colorModeBtn)

local tracerLabel = Instance.new("TextLabel", visualsPage)
tracerLabel.Size = UDim2.new(0, 200, 0, 20); tracerLabel.Position = UDim2.new(0, 10, 0, 255); tracerLabel.Text = "Положение линий трейсеров:"; tracerLabel.TextColor3 = Color3.fromRGB(180, 180, 180); tracerLabel.BackgroundTransparency = 1; tracerLabel.Font = Enum.Font.SourceSans; tracerLabel.TextSize = 14; tracerLabel.TextXAlignment = Enum.TextXAlignment.Left; tracerLabel.ZIndex = 8

local tracerModeBtn = Instance.new("TextButton", visualsPage)
tracerModeBtn.Size = UDim2.new(0, 200, 0, 35); tracerModeBtn.Position = UDim2.new(0, 10, 0, 280); tracerModeBtn.Text = "НИЗ ЭКРАНА"; tracerModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); tracerModeBtn.TextColor3 = Color3.new(1,1,1); tracerModeBtn.Font = Enum.Font.SourceSansBold; tracerModeBtn.ZIndex = 8; Instance.new("UICorner", tracerModeBtn)

-- Логика кнопок визуалов
espToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espToggleBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espToggleBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    espSubMenu.Visible = ESP_Enabled 
    
    if not ESP_Enabled then
        for _, obj in pairs(espObjects) do 
            obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
        end
    end
end)

nameToggleBtn.MouseButton1Click:Connect(function()
    Show_Names = not Show_Names
    nameToggleBtn.Text = Show_Names and "Никнеймы: Вкл" or "Никнеймы: Выкл"
    nameToggleBtn.BackgroundColor3 = Show_Names and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

distToggleBtn.MouseButton1Click:Connect(function()
    Show_Dist = not Show_Dist
    distToggleBtn.Text = Show_Dist and "Дистанция: Вкл" or "Дистанция: Выкл"
    distToggleBtn.BackgroundColor3 = Show_Dist and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

chamsBtn.MouseButton1Click:Connect(function()
    Chams_Enabled = not Chams_Enabled
    chamsBtn.Text = Chams_Enabled and "Chams: ON" or "Chams: OFF"
    chamsBtn.BackgroundColor3 = Chams_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

rgbChamsBtn.MouseButton1Click:Connect(function()
    RGB_Chams = not RGB_Chams
    rgbChamsBtn.Text = RGB_Chams and "RGB Chams: ON" or "RGB Chams: OFF"
    rgbChamsBtn.BackgroundColor3 = RGB_Chams and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

skelBtn.MouseButton1Click:Connect(function()
    Skeleton_ESP = not Skeleton_ESP
    skelBtn.Text = Skeleton_ESP and "Скелетоны: Вкл" or "Скелетоны: Выкл"
    skelBtn.BackgroundColor3 = Skeleton_ESP and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
    if not Skeleton_ESP then
        for _, pLines in pairs(skeletons) do for _, line in pairs(pLines) do line.Visible = false end end
    end
end)

colorModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Color_Mode == "Team" then Tracer_Color_Mode = "Red"; colorModeBtn.Text = "Цвет ESP: Красный"
    elseif Tracer_Color_Mode == "Red" then Tracer_Color_Mode = "Green"; colorModeBtn.Text = "Цвет ESP: Зеленый"
    elseif Tracer_Color_Mode == "Green" then Tracer_Color_Mode = "Blue"; colorModeBtn.Text = "Цвет ESP: Синий"
    elseif Tracer_Color_Mode == "Blue" then Tracer_Color_Mode = "Rainbow"; colorModeBtn.Text = "Цвет ESP: Радуга"
    else Tracer_Color_Mode = "Team"; colorModeBtn.Text = "Цвет ESP: Командный" end
end)

tracerModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then Tracer_Mode = "Center"; tracerModeBtn.Text = "ЦЕНТР ЭКРАНА"
    elseif Tracer_Mode == "Center" then Tracer_Mode = "Top"; tracerModeBtn.Text = "ВВЕРХ ЭКРАНА"
    else Tracer_Mode = "Bottom"; tracerModeBtn.Text = "НИЗ ЭКРАНА" end
end)


-- === КОНТЕНТ ВКЛАДКИ PLAYER ===
local speedBtn = Instance.new("TextButton", playerPage)
speedBtn.Size = UDim2.new(0, 200, 0, 40); speedBtn.Position = UDim2.new(0, 10, 0, 15); speedBtn.Text = "Быстрый бег: Выкл (16)"; speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); speedBtn.TextColor3 = Color3.new(1,1,1); speedBtn.Font = Enum.Font.SourceSansBold; speedBtn.ZIndex = 8; Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    speedBtn.Text = Custom_Speed == 50 and "Быстрый бег: Вкл (50)" or "Быстрый бег: Выкл (16)"
    speedBtn.BackgroundColor3 = Custom_Speed == 50 and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local jumpBtn = Instance.new("TextButton", playerPage)
jumpBtn.Size = UDim2.new(0, 200, 0, 40); jumpBtn.Position = UDim2.new(0, 10, 0, 65); jumpBtn.Text = "Высокий прыжок: Выкл"; jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); jumpBtn.TextColor3 = Color3.new(1,1,1); jumpBtn.Font = Enum.Font.SourceSansBold; jumpBtn.ZIndex = 8; Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    Custom_Jump = (Custom_Jump == 50) and 120 or 50
    jumpBtn.Text = Custom_Jump == 120 and "Высокий прыжок: Вкл (120)" or "Высокий прыжок: Выкл"
    jumpBtn.BackgroundColor3 = Custom_Jump == 120 and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local hitboxBtn = Instance.new("TextButton", playerPage)
hitboxBtn.Size = UDim2.new(0, 200, 0, 40); hitboxBtn.Position = UDim2.new(0, 10, 0, 115); hitboxBtn.Text = "Hitbox: OFF"; hitboxBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); hitboxBtn.TextColor3 = Color3.new(1,1,1); hitboxBtn.Font = Enum.Font.SourceSansBold; hitboxBtn.ZIndex = 8; Instance.new("UICorner", hitboxBtn)

hitboxBtn.MouseButton1Click:Connect(function()
    Hitbox_Enabled = not Hitbox_Enabled
    hitboxBtn.Text = Hitbox_Enabled and "Hitbox: ON" or "Hitbox: OFF"
    hitboxBtn.BackgroundColor3 = Hitbox_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local noclipBtn = Instance.new("TextButton", playerPage)
noclipBtn.Size = UDim2.new(0, 200, 0, 40); noclipBtn.Position = UDim2.new(0, 10, 0, 165); noclipBtn.Text = "Ноклип: Выкл"; noclipBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); noclipBtn.TextColor3 = Color3.new(1,1,1); noclipBtn.Font = Enum.Font.SourceSansBold; noclipBtn.ZIndex = 8; Instance.new("UICorner", noclipBtn)

noclipBtn.MouseButton1Click:Connect(function()
    Noclip_Enabled = not Noclip_Enabled
    noclipBtn.Text = Noclip_Enabled and "Ноклип: Вкл" or "Ноклип: Выкл"
    noclipBtn.BackgroundColor3 = Noclip_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local flyBtn = Instance.new("TextButton", playerPage)
flyBtn.Size = UDim2.new(0, 200, 0, 40); flyBtn.Position = UDim2.new(0, 10, 0, 215); flyBtn.Text = "Полет: Выкл"; flyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); flyBtn.TextColor3 = Color3.new(1,1,1); flyBtn.Font = Enum.Font.SourceSansBold; flyBtn.ZIndex = 8; Instance.new("UICorner", flyBtn)

flyBtn.MouseButton1Click:Connect(function()
    Flying = not Flying
    flyBtn.Text = Flying and "Полет: Вкл" or "Полет: Выкл"
    flyBtn.BackgroundColor3 = Flying and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local spinBtn = Instance.new("TextButton", playerPage)
spinBtn.Size = UDim2.new(0, 200, 0, 40); spinBtn.Position = UDim2.new(0, 10, 0, 265); spinBtn.Text = "Крутилка (Spin): Выкл"; spinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); spinBtn.TextColor3 = Color3.new(1,1,1); spinBtn.Font = Enum.Font.SourceSansBold; spinBtn.ZIndex = 8; Instance.new("UICorner", spinBtn)

spinBtn.MouseButton1Click:Connect(function()
    SpinBot_Enabled = not SpinBot_Enabled
    spinBtn.Text = SpinBot_Enabled and "Крутилка: Вкл" or "Крутилка: Выкл"
    spinBtn.BackgroundColor3 = SpinBot_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local tpToolBtn = Instance.new("TextButton", playerPage)
tpToolBtn.Size = UDim2.new(0, 200, 0, 40); tpToolBtn.Position = UDim2.new(0, 10, 0, 315); tpToolBtn.Text = "Получить ТП Мышку"; tpToolBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 90); tpToolBtn.TextColor3 = Color3.new(1,1,1); tpToolBtn.Font = Enum.Font.SourceSansBold; tpToolBtn.ZIndex = 8; Instance.new("UICorner", tpToolBtn)

tpToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "Click Teleport"
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and mouse.Hit then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = LocalPlayer.Backpack
end)


-- === КОНТЕНТ ВКЛАДКИ TELEPORTS ===
local scrollList = Instance.new("ScrollingFrame", teleportsPage)
scrollList.Size = UDim2.new(0, 270, 0, 360); scrollList.Position = UDim2.new(0, 10, 0, 20); scrollList.BackgroundColor3 = Color3.fromRGB(25, 25, 25); scrollList.CanvasSize = UDim2.new(0, 0, 0, 0); scrollList.ScrollBarThickness = 6; scrollList.ZIndex = 8; Instance.new("UICorner", scrollList)

task.spawn(function()
    while task.wait(1) do
        if teleportsPage.Visible and mainFrame.Visible then
            scrollList:ClearAllChildren()
            local count = 0
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton", scrollList)
                    pBtn.Size = UDim2.new(1, -15, 0, 35); pBtn.Position = UDim2.new(0, 5, 0, count * 40); pBtn.Text = p.Name; pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); pBtn.TextColor3 = Color3.new(1,1,1); pBtn.Font = Enum.Font.SourceSansBold; pBtn.ZIndex = 9; Instance.new("UICorner", pBtn)
                    pBtn.MouseButton1Click:Connect(function()
                        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                        end
                    end)
                    count = count + 1
                end
            end
            scrollList.CanvasSize = UDim2.new(0, 0, 0, count * 40)
        end
    end
end)


-- === МЕХАНИКА И ЯДРО ESP ===
local function createESPItems()
    local box = Drawing.new("Square"); box.Visible = false; box.Filled = false; box.Thickness = 2
    local tracer = Drawing.new("Line"); tracer.Visible = false; tracer.Thickness = 1.5
    local text = Drawing.new("Text"); text.Visible = false; text.Size = 15; text.Color = Color3.new(1,1,1); text.Center = true; text.Outline = true

    return {Box = box, Tracer = tracer, Text = text}
end

local function removeESPItems(player)
    if espObjects[player] then
        espObjects[player].Box:Remove(); espObjects[player].Tracer:Remove(); espObjects[player].Text:Remove()
        espObjects[player] = nil
    end
    if skeletons[player] then
        for _, l in pairs(skeletons[player]) do l:Remove() end
        skeletons[player] = nil
    end
end

for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer then espObjects[player] = createESPItems() end end
Players.PlayerAdded:Connect(function(player) espObjects[player] = createESPItems() end)
Players.PlayerRemoving:Connect(function(player) removeESPItems(player) end)


-- === ЦИКЛ ОБНОВЛЕНИЯ КАДРОВ (RenderStepped) ===
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
    -- Плавная генерация цвета Радуги
    currentRgbColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)

    -- Скорость и прыжки
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Custom_Speed
        if hum.UseJumpPower then hum.JumpPower = Custom_Jump else hum.JumpHeight = Custom_Jump / 3 end
    end

    -- Ноклип
    if Noclip_Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Крутилка (SpinBot)
    if SpinBot_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(35), 0)
    end

    -- Полёт (Fly)
    if Flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character.Humanoid
        hrp.Velocity = Vector3.new(0, 0.1, 0)
        if hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = hum.MoveDirection * FlySpeed
        end
    end

    -- Положение трейсеров
    local startPoint
    if Tracer_Mode == "Bottom" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    elseif Tracer_Mode == "Center" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0) end

    -- Большой цикл по всем игрокам
    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            -- Хитбоксы
            if Hitbox_Enabled then
                rootPart.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size)
                rootPart.Transparency = 0.5
                rootPart.BrickColor = BrickColor.new("Really red")
                rootPart.CanCollide = false
            else
                rootPart.Size = Vector3.new(2, 2, 1)
                rootPart.Transparency = 1
            end

            -- Чамсы
            if Chams_Enabled then
                if not character:FindFirstChild("HubHighlight") then
                    local hl = Instance.new("Highlight", character)
                    hl.Name = "HubHighlight"; hl.FillTransparency = 0.4
                end
                character.HubHighlight.FillColor = RGB_Chams and currentRgbColor or Color3.fromRGB(255, 0, 0)
            else
                if character:FindFirstChild("HubHighlight") then character.HubHighlight:Destroy() end
            end

            -- Скелетоны
            if Skeleton_ESP and onScreen then
                if not skeletons[player] then
                    skeletons[player] = {
                        Spine = Drawing.new("Line"), LeftArm = Drawing.new("Line"), 
                        RightArm = Drawing.new("Line"), LeftLeg = Drawing.new("Line"), RightLeg = Drawing.new("Line")
                    }
                    for _, l in pairs(skeletons[player]) do l.Thickness = 2 end
                end
                
                local sk = skeletons[player]
                local head = character:FindFirstChild("Head")
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                local lArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
                local rArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
                local lLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftLowerLeg")
                local rLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightLowerLeg")
                
                local skColor = RGB_Chams and currentRgbColor or Color3.fromRGB(255, 255, 255)
                for _, l in pairs(sk) do l.Color = skColor end

                if head and torso then
                    local vHead, _ = Camera:WorldToViewportPoint(head.Position)
                    local vTorso, _ = Camera:WorldToViewportPoint(torso.Position)
                    sk.Spine.From = Vector2.new(vHead.X, vHead.Y); sk.Spine.To = Vector2.new(vTorso.X, vTorso.Y); sk.Spine.Visible = true
                    
                    if lArm then local vA, _ = Camera:WorldToViewportPoint(lArm.Position); sk.LeftArm.From = Vector2.new(vTorso.X, vTorso.Y); sk.LeftArm.To = Vector2.new(vA.X, vA.Y); sk.LeftArm.Visible = true else sk.LeftArm.Visible = false end
                    if rArm then local vA, _ = Camera:WorldToViewportPoint(rArm.Position); sk.RightArm.From = Vector2.new(vTorso.X, vTorso.Y); sk.RightArm.To = Vector2.new(vA.X, vA.Y); sk.RightArm.Visible = true else sk.RightArm.Visible = false end
                    if lLeg then local vL, _ = Camera:WorldToViewportPoint(lLeg.Position); sk.LeftLeg.From = Vector2.new(vTorso.X, vTorso.Y); sk.LeftLeg.To = Vector2.new(vL.X, vL.Y); sk.LeftLeg.Visible = true else sk.LeftLeg.Visible = false end
                    if rLeg then local vL, _ = Camera:WorldToViewportPoint(rLeg.Position); sk.RightLeg.From = Vector2.new(vTorso.X, vTorso.Y); sk.RightLeg.To = Vector2.new(vL.X, vL.Y); sk.RightLeg.Visible = true else sk.RightLeg.Visible = false end
                end
            elseif skeletons[player] then
                for _, l in pairs(skeletons[player]) do l.Visible = false end
            end

            -- Отрисовка ESP (Boxes + Lines + Text)
            if ESP_Enabled and onScreen then
                -- Выбор цвета линий
                local displayColor = Color3.fromRGB(255, 255, 255)
                if Tracer_Color_Mode == "Team" and player.Team then displayColor = player.TeamColor.Color
                elseif Tracer_Color_Mode == "Red" then displayColor = Color3.fromRGB(255, 50, 50)
                elseif Tracer_Color_Mode == "Green" then displayColor = Color3.fromRGB(50, 255, 50)
                elseif Tracer_Color_Mode == "Blue" then displayColor = Color3.fromRGB(50, 50, 255)
                elseif Tracer_Color_Mode == "Rainbow" then displayColor = currentRgbColor end

                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                local inMenu = mainFrame.Visible and (vector.X >= mainFrame.AbsolutePosition.X and vector.X <= mainFrame.AbsolutePosition.X + mainFrame.AbsoluteSize.X and vector.Y >= mainFrame.AbsolutePosition.Y and vector.Y <= mainFrame.AbsolutePosition.Y + mainFrame.AbsoluteSize.Y)

                if not inMenu then
                    obj.Box.Color = displayColor; obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5); obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2); obj.Box.Visible = true
                    obj.Tracer.Color = displayColor; obj.Tracer.From = startPoint; obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2)); obj.Tracer.Visible = true
                    
                    if Show_Names or Show_Dist then
                        local textBuffer = ""
                        if Show_Names then textBuffer = textBuffer .. player.Name end
                        if Show_Dist then textBuffer = textBuffer .. " [" .. math.floor(dist) .. "m]" end
                        obj.Text.Text = textBuffer; obj.Text.Position = Vector2.new(vector.X, vector.Y - (obj.Box.Size.Y / 2) - 20); obj.Text.Visible = true
                    else
                        obj.Text.Visible = false
                    end
                else
                    obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
                end
            else
                obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
            end
        else
            obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
            if skeletons[player] then for _, l in pairs(skeletons[player]) do l.Visible = false end end
        end
    end
end)

print("c00lkidd214anzz Hub Ultimate Edition Successfully Loaded!")
