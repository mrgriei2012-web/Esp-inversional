-- c00lkidd214anzz Hub (Big UI Menu Edition - Ultimate Fixed)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled = true
local Chams_Enabled = false
local Hitbox_Enabled = false
local Noclip_Enabled = false
local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
local Custom_Speed = 16
local Custom_Jump = 50
local Hitbox_Size = 5
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
screenGui.ResetOnSpawn = false

-- Главная перетаскиваемая кнопка-открывашка (Двигается отдельно)
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

-- === БОЛЬШОЕ ОСНОВНОЕ МЕНЮ (Двигается отдельно) ===
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0) -- Независимая начальная позиция
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame)

-- Открытие/Закрытие меню по клику на кнопку
mainToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Левая панель для вкладок (Сайдбар)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.ZIndex = 6
Instance.new("UICorner", sidebar)

-- Контейнеры для содержимого вкладок (Правая часть)
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 300, 1, 0); visualsPage.Position = UDim2.new(0, 140, 0, 0); visualsPage.BackgroundTransparency = 1; visualsPage.Visible = true; visualsPage.ZIndex = 6

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 300, 1, 0); playerPage.Position = UDim2.new(0, 140, 0, 0); playerPage.BackgroundTransparency = 1; playerPage.Visible = false; playerPage.ZIndex = 6

local teleportsPage = Instance.new("Frame", mainFrame)
teleportsPage.Size = UDim2.new(0, 300, 1, 0); teleportsPage.Position = UDim2.new(0, 140, 0, 0); teleportsPage.BackgroundTransparency = 1; teleportsPage.Visible = false; teleportsPage.ZIndex = 6

-- Функция переключения страниц
local function showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
    teleportsPage.Visible = (page == teleportsPage)
end

-- === КНОПКИ ВКЛАДОК В СИДБАРЕ ===
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
espToggleBtn.Size = UDim2.new(0, 200, 0, 40); espToggleBtn.Position = UDim2.new(0, 10, 0, 20); espToggleBtn.Text = "ESP: ON"; espToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); espToggleBtn.TextColor3 = Color3.new(1,1,1); espToggleBtn.Font = Enum.Font.SourceSansBold; espToggleBtn.ZIndex = 8; Instance.new("UICorner", espToggleBtn)

espToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espToggleBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espToggleBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    if not ESP_Enabled then
        for _, obj in pairs(espObjects) do 
            obj.Box.Visible = false 
            obj.Tracer.Visible = false 
            obj.Text.Visible = false
        end
    end
end)

local chamsBtn = Instance.new("TextButton", visualsPage)
chamsBtn.Size = UDim2.new(0, 200, 0, 40); chamsBtn.Position = UDim2.new(0, 10, 0, 70); chamsBtn.Text = "Chams: OFF"; chamsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); chamsBtn.TextColor3 = Color3.new(1,1,1); chamsBtn.Font = Enum.Font.SourceSansBold; chamsBtn.ZIndex = 8; Instance.new("UICorner", chamsBtn)

chamsBtn.MouseButton1Click:Connect(function()
    Chams_Enabled = not Chams_Enabled
    chamsBtn.Text = Chams_Enabled and "Chams: ON" or "Chams: OFF"
    chamsBtn.BackgroundColor3 = Chams_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local tracerLabel = Instance.new("TextLabel", visualsPage)
tracerLabel.Size = UDim2.new(0, 200, 0, 20); tracerLabel.Position = UDim2.new(0, 10, 0, 125); tracerLabel.Text = "Положение линий трейсеров:"; tracerLabel.TextColor3 = Color3.fromRGB(180, 180, 180); tracerLabel.BackgroundTransparency = 1; tracerLabel.Font = Enum.Font.SourceSans; tracerLabel.TextSize = 14; tracerLabel.TextXAlignment = Enum.TextXAlignment.Left; tracerLabel.ZIndex = 8

local tracerModeBtn = Instance.new("TextButton", visualsPage)
tracerModeBtn.Size = UDim2.new(0, 200, 0, 40); tracerModeBtn.Position = UDim2.new(0, 10, 0, 150); tracerModeBtn.Text = "НИЗ ЭКРАНА"; tracerModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); tracerModeBtn.TextColor3 = Color3.new(1,1,1); tracerModeBtn.Font = Enum.Font.SourceSansBold; tracerModeBtn.ZIndex = 8; Instance.new("UICorner", tracerModeBtn)

tracerModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then Tracer_Mode = "Center"; tracerModeBtn.Text = "ЦЕНТР ЭКРАНА"
    elseif Tracer_Mode == "Center" then Tracer_Mode = "Top"; tracerModeBtn.Text = "ВВЕРХ ЭКРАНА"
    else Tracer_Mode = "Bottom"; tracerModeBtn.Text = "НИЗ ЭКРАНА" end
end)


-- === КОНТЕНТ ВКЛАДКИ PLAYER ===
local speedBtn = Instance.new("TextButton", playerPage)
speedBtn.Size = UDim2.new(0, 200, 0, 40); speedBtn.Position = UDim2.new(0, 10, 0, 20); speedBtn.Text = "Быстрый бег: Выкл (16)"; speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); speedBtn.TextColor3 = Color3.new(1,1,1); speedBtn.Font = Enum.Font.SourceSansBold; speedBtn.ZIndex = 8; Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    speedBtn.Text = Custom_Speed == 50 and "Быстрый бег: Вкл (50)" or "Быстрый бег: Выкл (16)"
    speedBtn.BackgroundColor3 = Custom_Speed == 50 and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local jumpBtn = Instance.new("TextButton", playerPage)
jumpBtn.Size = UDim2.new(0, 200, 0, 40); jumpBtn.Position = UDim2.new(0, 10, 0, 70); jumpBtn.Text = "Высокий прыжок: Выкл"; jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); jumpBtn.TextColor3 = Color3.new(1,1,1); jumpBtn.Font = Enum.Font.SourceSansBold; jumpBtn.ZIndex = 8; Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    Custom_Jump = (Custom_Jump == 50) and 120 or 50
    jumpBtn.Text = Custom_Jump == 120 and "Высокий прыжок: Вкл (120)" or "Высокий прыжок: Выкл"
    jumpBtn.BackgroundColor3 = Custom_Jump == 120 and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local hitboxBtn = Instance.new("TextButton", playerPage)
hitboxBtn.Size = UDim2.new(0, 200, 0, 40); hitboxBtn.Position = UDim2.new(0, 10, 0, 120); hitboxBtn.Text = "Hitbox: OFF"; hitboxBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); hitboxBtn.TextColor3 = Color3.new(1,1,1); hitboxBtn.Font = Enum.Font.SourceSansBold; hitboxBtn.ZIndex = 8; Instance.new("UICorner", hitboxBtn)

hitboxBtn.MouseButton1Click:Connect(function()
    Hitbox_Enabled = not Hitbox_Enabled
    hitboxBtn.Text = Hitbox_Enabled and "Hitbox: ON" or "Hitbox: OFF"
    hitboxBtn.BackgroundColor3 = Hitbox_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)

local noclipBtn = Instance.new("TextButton", playerPage)
noclipBtn.Size = UDim2.new(0, 200, 0, 40); noclipBtn.Position = UDim2.new(0, 10, 0, 170); noclipBtn.Text = "Ноклип: Выкл"; noclipBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); noclipBtn.TextColor3 = Color3.new(1,1,1); noclipBtn.Font = Enum.Font.SourceSansBold; noclipBtn.ZIndex = 8; Instance.new("UICorner", noclipBtn)

noclipBtn.MouseButton1Click:Connect(function()
    Noclip_Enabled = not Noclip_Enabled
    noclipBtn.Text = Noclip_Enabled and "Ноклип: Вкл" or "Ноклип: Выкл"
    noclipBtn.BackgroundColor3 = Noclip_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(45, 45, 45)
end)


-- === КОНТЕНТ ВКЛАДКИ TELEPORTS (Scrolling List) ===
local scrollList = Instance.new("ScrollingFrame", teleportsPage)
scrollList.Size = UDim2.new(0, 270, 0, 240); scrollList.Position = UDim2.new(0, 10, 0, 20); scrollList.BackgroundColor3 = Color3.fromRGB(25, 25, 25); scrollList.CanvasSize = UDim2.new(0, 0, 0, 0); scrollList.ScrollBarThickness = 6; scrollList.ZIndex = 8; Instance.new("UICorner", scrollList)

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
end

for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer then espObjects[player] = createESPItems() end end
Players.PlayerAdded:Connect(function(player) espObjects[player] = createESPItems() end)
Players.PlayerRemoving:Connect(function(player) removeESPItems(player) end)


-- === ЦИКЛ ОБНОВЛЕНИЯ КАДРОВ (RenderStepped) ===
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
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

    -- Положение трейсеров
    local startPoint
    if Tracer_Mode == "Bottom" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    elseif Tracer_Mode == "Center" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0) end

    -- Цикл по остальным игрокам (ESP, Chams, Hitbox)
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

            -- Чамсы (Highlight)
            if Chams_Enabled then
                if not character:FindFirstChild("HubHighlight") then
                    local hl = Instance.new("Highlight", character)
                    hl.Name = "HubHighlight"; hl.FillColor = Color3.fromRGB(255, 0, 0); hl.FillTransparency = 0.4
                end
            else
                if character:FindFirstChild("HubHighlight") then character.HubHighlight:Destroy() end
            end

            -- Отрисовка ESP (Boxes + Lines + Text)
            if ESP_Enabled and onScreen then
                local displayColor = player.Team and player.TeamColor.Color or Color3.fromRGB(255, 255, 255)
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                -- Скрываем ESP под открытым меню, чтобы не было "каши"
                local inMenu = mainFrame.Visible and (vector.X >= mainFrame.AbsolutePosition.X and vector.X <= mainFrame.AbsolutePosition.X + mainFrame.AbsoluteSize.X and vector.Y >= mainFrame.AbsolutePosition.Y and vector.Y <= mainFrame.AbsolutePosition.Y + mainFrame.AbsoluteSize.Y)

                if not inMenu then
                    obj.Box.Color = displayColor; obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5); obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2); obj.Box.Visible = true
                    obj.Tracer.Color = displayColor; obj.Tracer.From = startPoint; obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2)); obj.Tracer.Visible = true
                    obj.Text.Text = player.Name .. " [" .. math.floor(dist) .. "m]"; obj.Text.Position = Vector2.new(vector.X, vector.Y - (obj.Box.Size.Y / 2) - 20); obj.Text.Visible = true
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

print("c00lkidd214anzz Hub Ultimate Fixed Loaded!")
