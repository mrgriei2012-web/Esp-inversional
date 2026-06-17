-- c00lkidd214anzz Hub (Big UI Menu Edition)
local Players = game:GetService("Players")
локальный RunService = игра:GetService("RunService")
локальная камера = рабочая область.Текущая камера
localLocalPlayer = Players.LocalPlayer

-- Снимок с сайта
local ESP_Enabled = true
local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
local Custom_Speed ​​= 16
local Custom_Jump = 50
local espObjects = {}

-- 1. Р'Р°С‚РµСЂРјР°СЂРє
локальный водяной знак = Drawing.new("Текст")
watermark.Text = "c00lkidd214anzz Hub"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Outline = true
watermark.Position = Vector2.new(10, 30)
watermark.Visible = true
watermark.Font = 2

-- 2. Скрытый интерфейс пользователя
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))

-- Р“Р°РІРЅР°СЏ РїРµСЂРµС‚Р°СЃРєРёРІР°Р°СЏ РєРЅРѕРїР°-РѕС‚РєСЂС‹РІР°С€РєР°
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

-- === Р'РћР¬РЁРћР• РћСРќРћР'РќР• РњР•АќР® ===
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 280) -- Размер файла
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 55)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
Instance.new("UICorner", mainFrame)

-- РЎРμРІР°СЏ РїР°РЅРμР»СЊ НГР»СЏ РІРєР°РѕРє (СЎР°Р№Р°СЂ)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local uiCornerSidebar = Instance.new("UICorner", sidebar)

-- РљРѕРЅС‚РµР№РЅРµСЂС‹ РґР»СЏ СЃРѕРґРμСЂР¶РјРѕРіРѕ РІРєР»Р°РѕРє (РџСЂР°РІР°СЏ С‡Р°СЃС‚СЊ)
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

-- Удаленный доступ
локальная функция showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
конец

-- === РљРќРћРџРљР˜ Р'АРђР”РћРљ Р'НР˜Р”Н Р• ===
local tabVisuals = Instance.new("TextButton", sidebar)
tabVisuals.Size = UDim2.new(0, 110, 0, 35)
tabVisuals.Position = UDim2.new(0, 10, 0, 20)
tabVisuals.Text = "Визуальные материалы (ESP)"
tabVisuals.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabVisuals.TextColor3 = Color3.fromRGB(255, 255, 255)
tabVisuals.Font = Enum.Font.SourceSansBold
tabVisuals.TextSize = 14
Instance.new("UICorner", tabVisuals)
tabVisuals.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tabPlayer = Instance.new("TextButton", sidebar)
tabPlayer.Size = UDim2.new(0, 110, 0, 35)
tabPlayer.Position = UDim2.new(0, 10, 0, 65)
tabPlayer.Text = "Игрок (Игрок)"
tabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
tabPlayer.Font = Enum.Font.SourceSansBold
tabPlayer.TextSize = 14
Instance.new("UICorner", tabPlayer)
tabPlayer.MouseButton1Click:Connect(function() showPage(playerPage) end)


-- === РљРћРќРўР•АРў Р'АљРђР”А ВИЗУАЛЫ ===
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
    если ESP_Enabled не включен, то
        for _, obj in pairs(espObjects) do
            obj.Box.Visible = false
            obj.Tracer.Visible = false
        конец
    конец
конец)

local tracerLabel = Instance.new("TextLabel", visualsPage)
tracerLabel.Size = UDim2.new(0, 200, 0, 20)
tracerLabel.Position = UDim2.new(0, 10, 0, 80)
tracerLabel.Text = "Добавлено значение:"
TracerLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
tracerLabel.BackgroundTransparency = 1
tracerLabel.Font = Enum.Font.SourceSans
tracerLabel.TextSize = 14
tracerLabel.TextXAlignment = Enum.TextXAlignment.Left

local tracerModeBtn = Instance.new("TextButton", visualsPage)
tracerModeBtn.Size = UDim2.new(0, 200, 0, 40)
tracerModeBtn.Position = UDim2.new(0, 10, 0, 105)
tracerModeBtn.Text = "РќР˜Р— РРљР АА"
tracerModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TracerModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerModeBtn.Font = Enum.Font.SourceSansBold
tracerModeBtn.TextSize = 14
Instance.new("UICorner", tracerModeBtn)

tracerModeBtn.MouseButton1Click:Connect(function()
    если Tracer_Mode == "Bottom", то
        Tracer_Mode = "Center"
        tracerModeBtn.Text = "Р¦Р•АРўР РРљР АА"
    elseif Tracer_Mode == "Center" then
        Tracer_Mode = "Top"
        tracerModeBtn.Text = "В'Р•РҐ РРљР А"
    еще
        Tracer_Mode = "Bottom"
        tracerModeBtn.Text = "РќР˜Р— РРљР АА"
    конец
конец)


-- === КАТАЛОГ ПЛЕЕР ===
-- РЎРѕСЂРѕСЃС‚СЊ Р±РµР°
local speedBtn = Instance.new("TextButton", playerPage)
speedBtn.Size = UDim2.new(0, 200, 0, 40)
speedBtn.Position = UDim2.new(0, 10, 0, 20)
SpeedBtn.Text = "Нет Н±РμРі: Н'С‹РєР" (16)"
speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    если Custom_Speed ​​== 16, то
        Custom_Speed ​​= 50 -- Проверка скорости
        SpeedBtn.Text = "Нет Н±РμРі: Н"(50)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    еще
        Custom_Speed ​​= 16
        SpeedBtn.Text = "Нет Н±РμРі: Н'С‹РєР" (16)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    конец
конец)

-- Важный момент
local jumpBtn = Instance.new("TextButton", playerPage)
jumpBtn.Size = UDim2.new(0, 200, 0, 40)
jumpBtn.Position = UDim2.new(0, 10, 0, 75)
jumpBtn.Text = "Добавка: Н""
jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.TextSize = 14
Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    если Custom_Jump == 50, то
        Custom_Jump = 120 -- Открыть список
        jumpBtn.Text = "Добавка: Н"(120)"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    еще
        Custom_Jump = 50
        jumpBtn.Text = "Добавка: Н""
        jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    конец
конец)

local Hitbox_Enabled = false
local Hitbox_Size = 5 -- Р°Р·РјРµСЂ С…РёС‚Р±РѕРєСЃР° (недоступно)

local hitBtn = Instance.new("TextButton", playerPage)
hitBtn.Size = UDim2.new(0, 250, 0, 45)
hitBtn.Position = UDim2.new(0, 15, 0, 130) -- Р°СЃРїРѕР»РѕР¶РёР» РєРЅРѕРїРєРё РїСЂС‹Р¶РєР°
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
конец)

-- РѕРіРёРєР°СЂР°СЃС€РёСЂРµРЅРёСЏ С…РёС‚Р±РѕРєСЃРѕРІ
RunService.RenderStepped:Connect(функция()
    если Hitbox_Enabled, то
        for _, p in pairs(Players:GetPlayers()) do
            если p ~= LocalPlayer и p.Character и p.Character:FindFirstChild("HumanoidRootPart") тогда
                local hrp = p.Character.HumanoidRootPart
                -- Прозрачность 0.5, Прозрачность 0.5, С‡С‚РѕР±С‹ Уровень, Н С‡С‚Рѕ С‚С‹ С†РμРёС€СЃСЏ)
                hrp.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size)
                hrp.Transparency = 0.5
                hrp.BrickColor = BrickColor.new("Очень красный")
                hrp.CanCollide = false
            конец
        конец
    еще
        -- Р'РѕР·РІСЂР°С‰Р°РµРј СЃС‚Р°РЅХР°СЂС‚РЅС‹Р№ СЂР°Р·РјРµСЂ (2, 2, 1), РμСЃР»Рё РІС‹Р»С‡Р»Рё
        for _, p in pairs(Players:GetPlayers()) do
            если p ~= LocalPlayer и p.Character и p.Character:FindFirstChild("HumanoidRootPart") тогда
                p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                p.Character.HumanoidRootPart.Transparency = 1
            конец
        конец
    конец
конец)

-- Открытие сайта (Доступно на playerPage)
local Noclip_Enabled = false
local noclipBtn = Instance.new("TextButton", playerPage)
noclipBtn.Size = UDim2.new(0, 200, 0, 40)
noclipBtn.Position = UDim2.new(0, 10, 0, 130) -- Пространство (Уровень Y, РµСЃР»Рё РїРµСЂРµРєС‹РІР°РµС РїСЂС‹Р¶РѕРє)
noclipBtn.Text = "Нет: Н""
noclipBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.Font = Enum.Font.SourceSansBold
noclipBtn.TextSize = 14
Instance.new("UICorner", noclipBtn)

noclipBtn.MouseButton1Click:Connect(function()
    Noclip_Enabled = not Noclip_Enabled
    noclipBtn.Text = Noclip_Enabled и "Нет: Н" или "Нет: Н""
    noclipBtn.BackgroundColor3 = Noclip_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
конец)

-- Р°РјР° Р»РѕРіРёРєР° РЅРѕРєР»РёРїР° (Р'СЃС‚Р°РІРёС‚СЊ РІРЅСѓС‚СЂСЊ С‚РІРѕРµРіРѕ С†РёРєР° RunService.RenderStepped)
Если Noclip_Enabled и LocalPlayer.Character, то
    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        если part:IsA("BasePart") then
            part.CanCollide = false
        конец
    конец
конец

-- === АААА Р»ААА–АААААААААААААААААААААААААААААААААААААА» ===
mainToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
конец)

mainToggle.Changed:Connect(function(prop)
    если prop == "Position", то
        mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
    конец
конец)


-- === ХР•ХАРќР˜РљАА Р˜ НР»Р Рћ ESP ===
локальная функция createESPItems()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Filled = false
    box.Thickness = 2

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    трассер.Толщина = 1,5

    return {Box = box, Tracer = tracer}
конец

локальная функция removeESPItems(player)
    если espObjects[player] тогда
        espObjects[player].Box:Remove()
        espObjects[player].Tracer:Remove()
        espObjects[player] = nil
    конец
конец

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then espObjects[player] = createESPItems() end
конец

Players.PlayerAdded:Connect(function(player)
    espObjects[player] = createESPItems()
конец)

Players.PlayerRemoving:Connect(function(player)
    removeESPItems(player)
конец)


-- === Р¦Р˜РљРћР'РќР'Р•РќР˜РЇ Р¦РђР”Р'Р' (RenderStepped) ===
RunService.RenderStepped:Connect(функция()
    watermark.Visible = true
    
    -- Удаленный доступ РїСЂС‹Р¶РѕРє РЅР°С€РµРјСѓ РїРµСЂСЃРѕР°Р¶Сѓ
    Если LocalPlayer.Character и LocalPlayer.Character:FindFirstChild("Humanoid"), то
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed ​​= Custom_Speed
        
        -- Доступный режим (JumpPower — UseJumpPower)
        если hum.UseJumpPower тогда
            hum.JumpPower = Custom_Jump
        еще
            hum.JumpHeight = Custom_Jump / 3 -- Удалить информацию
        конец
    конец

    if not ESP_Enabled then return end

    -- В наличии
    локальная начальная точка
    если Tracer_Mode == "Bottom", то
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    elseif Tracer_Mode == "Center" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0)
    конец

    for player, obj in pairs(espObjects) do
        локальный персонаж = игрок.Персонаж
        если character и character:FindFirstChild("HumanoidRootPart") и character:FindFirstChild("Humanoid") и character.Humanoid.Health > 0 тогда
            
            local rootPart = character.HumanoidRootPart
            локальный вектор, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            -- Р”РёРЅР°РёС‡РµСЃРєРёР№ С†РІРµС‚ РєРѕРјР°Рґ
            local displayColor = Color3.fromRGB(255, 255, 255)
            если игрок.команда тогда
                displayColor = player.TeamColor.Color
            конец

            obj.Box.Color = displayColor
            obj.Tracer.Color = displayColor

            если на экране, то
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                локальный масштаб = 1000 / расстояние
                
                -- Р'РѕРєСЃС‹
                obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5)
                obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2)
                obj.Box.Visible = true

                -- РўСЂРµР№СЃРµСЂС‹
                obj.Tracer.From = startPoint
                obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2))
                obj.Tracer.Visible = true
            еще
                obj.Box.Visible = false
                obj.Tracer.Visible = false
            конец
        еще
            obj.Box.Visible = false
            obj.Tracer.Visible = false
        конец
    конец
конец)

print("c00lkidd214anzz Большое меню вкладок успешно загружено!")
