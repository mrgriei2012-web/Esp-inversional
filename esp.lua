-- c00lkidd214anzz Hub (Brookhaven RP Dynamic Music ID Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled = false
local Show_Names = true   
local Show_Dist = true    
local Chams_Enabled = false
local RGB_Chams = false
local Hitbox_Enabled = false
local Noclip_Enabled = false
local Flying = false
local SpinBot_Enabled = false

-- Новые ультимативные функции
local InfJump_Enabled = false
local Aimbot_Enabled = false
local AutoParry_Enabled = false
local MM2_Revealer = false

local Tracer_Mode = "Bottom"
local Tracer_Color_Mode = "Team"
local Cheat_Speed = 50
local Cheat_Jump = 120
local Hitbox_Size = 5
local FlySpeed = 50

-- Переменная для ID музыки по умолчанию
local Brookhaven_SoundID = "1837874690" 

-- Оригинальные параметры игрока
local Original_Speed = 16
local Original_Jump = 50
local Original_UseJumpPower = true

local function SaveOriginalStats(character)
    local hum = character:WaitForChild("Humanoid", 5)
    if hum then
        Original_Speed = hum.WalkSpeed
        Original_UseJumpPower = hum.UseJumpPower
        Original_Jump = hum.UseJumpPower and hum.JumpPower or hum.JumpHeight
    end
end
if LocalPlayer.Character then SaveOriginalStats(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(SaveOriginalStats)

local Speed_Enabled = false
local Jump_Enabled = false
local espObjects = {}
local currentRgbColor = Color3.new(1,1,1)

-- Ватермарк
local watermark = Drawing.new("Text")
watermark.Text = "c00lkidd214anzz Hub v3"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Outline = true
watermark.Position = Vector2.new(10, 30)
watermark.Visible = true
watermark.Font = 2

-- Создание основы интерфейса
local screenGui = Instance.new("ScreenGui", CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 160, 0, 45); mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0); mainToggle.Text = "c00lkidd214anzz Menu"; mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255); mainToggle.Font = Enum.Font.GothamBold; mainToggle.TextSize = 14; mainToggle.Draggable = true; mainToggle.Active = true; Instance.new("UICorner", mainToggle)

-- БОЛЬШОЕ ОКНО (Широкое для двух панелей)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 550, 0, 320); mainFrame.Position = UDim2.new(0.5, -275, 0.5, -160); mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.Visible = false; mainFrame.Draggable = true; mainFrame.Active = true; Instance.new("UICorner", mainFrame)

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- ЛЕВАЯ ПАНЕЛЬ (Для плашек-вкладок)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 150, 1, -20); sidebar.Position = UDim2.new(0, 10, 0, 10); sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", sidebar)

local sideScroll = Instance.new("ScrollingFrame", sidebar)
sideScroll.Size = UDim2.new(1, -10, 1, -10); sideScroll.Position = UDim2.new(0, 5, 0, 5); sideScroll.BackgroundTransparency = 1; sideScroll.ScrollBarThickness = 2; sideScroll.CanvasSize = UDim2.new(0,0,0,350)
local sideLayout = Instance.new("UIListLayout", sideScroll)
sideLayout.Padding = UDim.new(0, 5)

-- ПРАВАЯ ЧАСТЬ (Контейнер для страниц с функциями)
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -180, 1, -20); contentContainer.Position = UDim2.new(0, 170, 0, 10); contentContainer.BackgroundTransparency = 1

local pages = {}

-- Функция создания страницы (справа) и кнопки для неё (слева)
local function createTab(name)
    local pageScroll = Instance.new("ScrollingFrame", contentContainer)
    pageScroll.Size = UDim2.new(1, 0, 1, 0); pageScroll.BackgroundTransparency = 1; pageScroll.ScrollBarThickness = 6; pageScroll.Visible = false; pageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    local pageLayout = Instance.new("UIListLayout", pageScroll)
    pageLayout.Padding = UDim.new(0, 6)
    
    pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pageScroll.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 10)
    end)
    
    local tabBtn = Instance.new("TextButton", sideScroll)
    tabBtn.Size = UDim2.new(1, 0, 0, 35); tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); tabBtn.Text = name; tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180); tabBtn.Font = Enum.Font.GothamBold; tabBtn.TextSize = 12; Instance.new("UICorner", tabBtn)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(sideScroll:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.fromRGB(180, 180, 180) end end
        
        pageScroll.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55); tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    table.insert(pages, pageScroll)
    return pageScroll
end

-- Конструктор функций (кнопок) внутри страниц
local function addFeature(parentPage, text, defaultState, callback)
    local Btn = Instance.new("TextButton", parentPage)
    Btn.Size = UDim2.new(1, -10, 0, 36); Btn.BackgroundColor3 = defaultState and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40); Btn.Text = text; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.Font = Enum.Font.Gotham; Btn.TextSize = 12; Instance.new("UICorner", Btn)
    
    local enabled = defaultState
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Btn.BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
        callback(enabled)
    end)
    return Btn
end

-- === ИНИЦИАЛИЗАЦИЯ СТРАНИЦ СЛЕВА И ФУНКЦИЙ СПРАВА ===

-- 1. Страница: AIMBOT
local aimPage = createTab("Aimbot")
addFeature(aimPage, "Aimbot (Доводка Камеры)", Aimbot_Enabled, function(v) Aimbot_Enabled = v end)

-- 2. Страница: BLADE BALL
local bbPage = createTab("Blade Ball")
addFeature(bbPage, "Авто-Блок (Auto Parry)", AutoParry_Enabled, function(v) AutoParry_Enabled = v end)

-- 3. Страница: MURDER MYSTERY 2
local mm2Page = createTab("Murder Mystery 2")
addFeature(mm2Page, "MM2 Роли (Revealer)", MM2_Revealer, function(v) MM2_Revealer = v end)

-- 4. Страница: VISUALS (ESP)
local visPage = createTab("Visuals (ESP)")
addFeature(visPage, "Включить ESP Boxes", ESP_Enabled, function(v) 
    ESP_Enabled = v 
    if not v then for _, obj in pairs(espObjects) do obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false end end
end)
addFeature(visPage, "Показывать Никнеймы", Show_Names, function(v) Show_Names = v end)
addFeature(visPage, "Показывать Дистанцию", Show_Dist, function(v) Show_Dist = v end)
addFeature(visPage, "Chams (Силуэты)", Chams_Enabled, function(v) Chams_Enabled = v end)
addFeature(visPage, "RGB Chams (Радуга)", RGB_Chams, function(v) RGB_Chams = v end)

local tracerModeBtn = addFeature(visPage, "Линии: НИЗ ЭКРАНА", false, function() end)
tracerModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then Tracer_Mode = "Center"; tracerModeBtn.Text = "Линии: ЦЕНТР ЭКРАНА"
    elseif Tracer_Mode == "Center" then Tracer_Mode = "Top"; tracerModeBtn.Text = "Линии: ВВЕРХ ЭКРАНА"
    else Tracer_Mode = "Bottom"; tracerModeBtn.Text = "Линии: НИЗ ЭКРАНА" end
end)

local colorModeBtn = addFeature(visPage, "Цвет ESP: Командный", false, function() end)
colorModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Color_Mode == "Team" then Tracer_Color_Mode = "Red"; colorModeBtn.Text = "Цвет ESP: Красный"
    elseif Tracer_Color_Mode == "Red" then Tracer_Color_Mode = "Green"; colorModeBtn.Text = "Цвет ESP: Зеленый"
    elseif Tracer_Color_Mode == "Green" then Tracer_Color_Mode = "Blue"; colorModeBtn.Text = "Цвет ESP: Синий"
    elseif Tracer_Color_Mode == "Blue" then Tracer_Color_Mode = "Rainbow"; colorModeBtn.Text = "Цвет ESP: Радуга"
    else Tracer_Color_Mode = "Team"; colorModeBtn.Text = "Цвет ESP: Командный" end
end)

-- 5. Страница: PLAYER
local playerPage = createTab("Main / Player")
addFeature(playerPage, "Бесконечный Прыжок", InfJump_Enabled, function(v) InfJump_Enabled = v end)
addFeature(playerPage, "Быстрый бег (50)", Speed_Enabled, function(v) Speed_Enabled = v end)
addFeature(playerPage, "Высокий прыжок (120)", Jump_Enabled, function(v) Jump_Enabled = v end)
addFeature(playerPage, "Ноклип (Сквозь стены)", Noclip_Enabled, function(v) Noclip_Enabled = v end)
addFeature(playerPage, "Полет (Fly)", Flying, function(v) Flying = v end)
addFeature(playerPage, "Крутилка (SpinBot)", SpinBot_Enabled, function(v) SpinBot_Enabled = v end)
addFeature(playerPage, "Увеличить Хитбоксы", Hitbox_Enabled, function(v) Hitbox_Enabled = v end)

local tpToolBtn = Instance.new("TextButton", playerPage)
tpToolBtn.Size = UDim2.new(1, -10, 0, 36); tpToolBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 90); tpToolBtn.Text = "Получить ТП Мышку"; tpToolBtn.TextColor3 = Color3.new(1,1,1); tpToolBtn.Font = Enum.Font.Gotham; tpToolBtn.TextSize = 12; Instance.new("UICorner", tpToolBtn)
tpToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool"); tool.Name = "Click Teleport"; tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and mouse.Hit then 
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)) 
        end
    end)
    tool.Parent = LocalPlayer.Backpack
end)

-- 7. Страница: TELEPORTS
local tpPage = createTab("Teleports")
local scrollList = Instance.new("Frame", tpPage)
scrollList.Size = UDim2.new(1, -10, 1, 0); scrollList.BackgroundTransparency = 1
local tpLayout = Instance.new("UIListLayout", scrollList)
tpLayout.Padding = UDim.new(0, 4)

task.spawn(function()
    while task.wait(1) do
        if mainFrame.Visible and tpPage.Visible then
            scrollList:ClearAllChildren()
            Instance.new("UIListLayout", scrollList).Padding = UDim.new(0, 4)
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton", scrollList)
                    pBtn.Size = UDim2.new(1, 0, 0, 32); pBtn.Text = p.Name; pBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); pBtn.TextColor3 = Color3.new(1,1,1); pBtn.Font = Enum.Font.Gotham; pBtn.TextSize = 11; Instance.new("UICorner", pBtn)
                    pBtn.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end)
                end
            end
        end
    end
end)

-- 6. ВЫДЕЛЕННАЯ СТРАНИЦА: BROOKHAVEN RP (Безопасная FE версия)
local bhPage = createTab("Brookhaven RP")

-- ПОЛЕ ВВОДА ДЛЯ ID ЗВУКА
local bhTextBox = Instance.new("TextBox", bhPage)
bhTextBox.Size = UDim2.new(1, -10, 0, 36)
bhTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bhTextBox.Text = Brookhaven_SoundID
bhTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
bhTextBox.PlaceholderText = "Введите ID Музыки здесь..."
bhTextBox.Font = Enum.Font.Gotham
bhTextBox.TextSize = 12
Instance.new("UICorner", bhTextBox)

bhTextBox.FocusLost:Connect(function()
    if bhTextBox.Text ~= "" then Brookhaven_SoundID = bhTextBox.Text end
end)

-- КНОПКА ЗАПУСКА (Оптимизированная под прямой вызов)
local bhMusicBtn = Instance.new("TextButton", bhPage)
bhMusicBtn.Size = UDim2.new(1, -10, 0, 40)
bhMusicBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 140)
bhMusicBtn.Text = "Включить введенный ID"
bhMusicBtn.TextColor3 = Color3.new(1,1,1)
bhMusicBtn.Font = Enum.Font.GothamBold
bhMusicBtn.TextSize = 13
Instance.new("UICorner", bhMusicBtn)

bhMusicBtn.MouseButton1Click:Connect(function()
    if bhTextBox.Text ~= "" then Brookhaven_SoundID = bhTextBox.Text end
    
    -- Прямой и безопасный поиск без сканирования всей игры
    local network = game:GetService("ReplicatedStorage"):FindFirstChild("Network") or 
                    game:GetService("ReplicatedStorage"):FindFirstChild("Net")
                    
    if network and network:IsA("RemoteEvent") then
        pcall(function()
            network:FireServer("CarMusic", Brookhaven_SoundID)
            network:FireServer("HouseMusic", Brookhaven_SoundID)
            network:FireServer("BoomboxId", tonumber(Brookhaven_SoundID))
        end)
        bhMusicBtn.Text = "Музыка отправлена!"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        -- Альтернативный вариант для определенных серверов без перебора
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        local carEvent = remotes and (remotes:FindFirstChild("CarEvent") or remotes:FindFirstChild("Network"))
        
        if carEvent then
            pcall(function() carEvent:FireServer("CarMusic", Brookhaven_SoundID) end)
            bhMusicBtn.Text = "Отправлено (Вариант 2)!"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        else
            bhMusicBtn.Text = "Сначала заспавни машину/дом!"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        end
    end
    
    task.wait(2)
    bhMusicBtn.Text = "Включить введенный ID"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 140)
end)

-- Настройки отображения первой страницы по умолчанию
pages[1].Visible = true
sideScroll:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(55, 55, 55)
sideScroll:GetChildren()[2].TextColor3 = Color3.fromRGB(255, 255, 255)
sideScroll.CanvasSize = UDim2.new(0, 0, 0, sideLayout.AbsoluteContentSize.Y + 10)

-- === ДВИЖКИ ЛОГИКИ ХАКОВ ===

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

local function getClosestPlayer()
    local closest, maxDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < maxDist then maxDist = dist; closest = p end
            end
        end
    end
    return closest
end

local function getMM2Role(player)
    if not MM2_Revealer then return nil end
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then return "Murder" end
    if (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then return "Sheriff" end
    return nil
end

local function createESPItems()
    local box = Drawing.new("Square"); box.Visible = false; box.Filled = false; box.Thickness = 2
    local tracer = Drawing.new("Line"); tracer.Visible = false; tracer.Thickness = 1.5
    local text = Drawing.new("Text"); text.Visible = false; text.Size = 14; text.Color = Color3.new(1,1,1); text.Center = true; text.Outline = true
    return {Box = box, Tracer = tracer, Text = text}
end

for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer then espObjects[player] = createESPItems() end end
Players.PlayerAdded:Connect(function(player) espObjects[player] = createESPItems() end)
Players.PlayerRemoving:Connect(function(player) 
    if espObjects[player] then espObjects[player].Box:Remove(); espObjects[player].Tracer:Remove(); espObjects[player].Text:Remove(); espObjects[player] = nil end
end)

-- === ЕДИНЫЙ ЦИКЛ ОБНОВЛЕНИЯ ===
RunService.RenderStepped:Connect(function()
    currentRgbColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Speed_Enabled and Cheat_Speed or Original_Speed
        if hum.UseJumpPower then hum.JumpPower = Jump_Enabled and Cheat_Jump or Original_Jump else hum.JumpHeight = Jump_Enabled and (Cheat_Jump / 3) or Original_Jump end
    end

    if Noclip_Enabled and LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    if SpinBot_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(35), 0) end
    if Flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hrp = LocalPlayer.Character.HumanoidRootPart local hum = LocalPlayer.Character.Humanoid hrp.Velocity = Vector3.new(0, 0.1, 0)
        if hum.MoveDirection.Magnitude > 0 then hrp.Velocity = hum.MoveDirection * FlySpeed end
    end

    if Aimbot_Enabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end

    if AutoParry_Enabled then
        local balls = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("BallFolder")
        if balls then
            for _, ball in pairs(balls:GetChildren()) do
                if ball:IsA("BasePart") and ball:GetAttribute("Target") == LocalPlayer.Name then
                    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (ball.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 999
                    local speed = ball.Velocity.Magnitude
                    if distance < (speed * 0.45) or distance < 15 then
                        local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                        local parryRemote = rem and (rem:FindFirstChild("Parry") or rem:FindFirstChild("ParryAttempt"))
                        if parryRemote then parryRemote:FireServer() end
                    end
                end
            end
        end
    end

    local startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    if Tracer_Mode == "Center" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0) end

    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            if Hitbox_Enabled then 
                rootPart.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size); rootPart.Transparency = 0.5; rootPart.BrickColor = BrickColor.new("Really red"); rootPart.CanCollide = false 
            else 
                rootPart.Size = Vector3.new(2, 2, 1); rootPart.Transparency = 1 
            end

            local mm2Role = getMM2Role(player)

            if Chams_Enabled then
                if not character:FindFirstChild("HubHighlight") then Instance.new("Highlight", character).Name = "HubHighlight" end
                local cHighlight = character.HubHighlight
                cHighlight.FillTransparency = 0.4
                if mm2Role == "Murder" then cHighlight.FillColor = Color3.fromRGB(255, 0, 0)
                elseif mm2Role == "Sheriff" then cHighlight.FillColor = Color3.fromRGB(0, 0, 255)
                else cHighlight.FillColor = RGB_Chams and currentRgbColor or Color3.fromRGB(255, 255, 255) end
            else
                if character:FindFirstChild("HubHighlight") then character.HubHighlight:Destroy() end
            end

            if ESP_Enabled and onScreen then
                local displayColor = Color3.fromRGB(255, 255, 255)
                if mm2Role == "Murder" then displayColor = Color3.fromRGB(255, 30, 30)
                elseif mm2Role == "Sheriff" then displayColor = Color3.fromRGB(30, 30, 255)
                elseif Tracer_Color_Mode == "Team" and player.Team then displayColor = player.TeamColor.Color
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
                    
                    local textBuffer = ""
                    if Show_Names then textBuffer = textBuffer .. player.Name end
                    if mm2Role then textBuffer = textBuffer .. " [" .. mm2Role .. "]" end
                    if Show_Dist then textBuffer = textBuffer .. " [" .. math.floor(dist) .. "m]" end
                    
                    obj.Text.Text = textBuffer; obj.Text.Position = Vector2.new(vector.X, vector.Y - (obj.Box.Size.Y / 2) - 20); obj.Text.Color = displayColor; obj.Text.Visible = (Show_Names or Show_Dist or MM2_Revealer)
                else
                    obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
                end
            else
                obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
            end
        else
            obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false
        end
    end
end)

print("c00lkidd214anzz Hub with dynamic TextBox loaded!")
