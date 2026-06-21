-- c00lkidd214anzz Hub (Ultimate Stable Monolith 2026)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций (Глобальные флаги)
_G.ESP_Enabled = false
_G.Show_Names = true   
_G.Show_Dist = true    
_G.Chams_Enabled = false
_G.RGB_Chams = false
_G.Skeleton_ESP = false
_G.Hitbox_Enabled = false
_G.Noclip_Enabled = false
_G.Flying = false
_G.SpinBot_Enabled = false
_G.InfJump_Enabled = false
_G.Aimbot_Enabled = false
_G.AutoParry_Enabled = false
_G.MM2_Revealer = false

_G.Tracer_Mode = "Bottom"
_G.Tracer_Color_Mode = "Team"
_G.Cheat_Speed = 50
_G.Cheat_Jump = 120
_G.Hitbox_Size = 5
_G.FlySpeed = 50

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
local ScreenGui = Instance.new("ScreenGui", CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "c00lkidd_Stable_Hub"
ScreenGui.ResetOnSpawn = false

local MainToggle = Instance.new("TextButton", ScreenGui)
MainToggle.Size = UDim2.new(0, 160, 0, 40)
MainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
MainToggle.Text = "c00lkidd Menu"
MainToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainToggle.Font = Enum.Font.GothamBold
MainToggle.TextSize = 14
MainToggle.Draggable = true
MainToggle.Active = true
Instance.new("UICorner", MainToggle)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 420)
MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Draggable = true
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

MainToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local MainLayout = Instance.new("UIListLayout", Scroll)
MainLayout.Padding = UDim.new(0, 6)

-- Конструктор стабильной плашки (Категории)
local function createCategory(name)
    local Folder = Instance.new("Frame", Scroll)
    Folder.Size = UDim2.new(1, 0, 0, 40)
    Folder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", Folder)
    
    local Title = Instance.new("TextButton", Folder)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "+ " .. name
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0, 10, 0, 0)
    
    local Container = Instance.new("Frame", Folder)
    Container.Size = UDim2.new(1, -20, 0, 0)
    Container.Position = UDim2.new(0, 10, 0, 45)
    Container.BackgroundTransparency = 1
    Container.ClipsDescendants = true
    
    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 5)
    
    local isOpen = false
    Title.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Title.Text = (isOpen and "- " or "+ ") .. name
        
        local targetSize = isOpen and UDim2.new(1, -20, 0, Layout.AbsoluteContentSize.Y) or UDim2.new(1, -20, 0, 0)
        Folder:TweenSize(isOpen and UDim2.new(1, 0, 0, 50 + Layout.AbsoluteContentSize.Y) or UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
        Container:TweenSize(targetSize, "Out", "Quad", 0.2, true)
        
        task.wait(0.22)
        Scroll.CanvasSize = UDim2.new(0, 0, 0, MainLayout.AbsoluteContentSize.Y + 20)
    end)
    
    return Container
end

-- Конструктор кнопок-функций
local function addFeature(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 12
    Instance.new("UICorner", Btn)
    
    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Btn.BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(45, 45, 45)
        callback(enabled)
    end)
    return Btn
end

-- === НАПОЛНЕНИЕ ИНТЕРФЕЙСА ===

-- Категория: AIMBOT
local aimCat = createCategory("Aimbot Settings")
addFeature(aimCat, "Аимбот Доводка Камеры", function(v) _G.Aimbot_Enabled = v end)

-- Категория: BLADE BALL
local bbCat = createCategory("Blade Ball")
addFeature(bbCat, "Авто-Блок (Auto Parry)", function(v) _G.AutoParry_Enabled = v end)

-- Категория: MURDER MYSTERY 2
local mm2Cat = createCategory("Murder Mystery 2")
addFeature(mm2Cat, "Подсветка Ролей (Revealer)", function(v) _G.MM2_Revealer = v end)

-- Категория: VISUALS (ESP)
local visCat = createCategory("Visuals (ESP)")
addFeature(visCat, "Включить ESP", function(v) 
    _G.ESP_Enabled = v 
    if not v then for _, obj in pairs(espObjects) do obj.Box.Visible = false; obj.Tracer.Visible = false; obj.Text.Visible = false end end
end)
addFeature(visCat, "Chams (Цветной силуэт)", function(v) _G.Chams_Enabled = v end)
addFeature(visCat, "Радужный Chams (RGB)", function(v) _G.RGB_Chams = v end)
local tracerCycle = addFeature(visCat, "Линии: НИЗ ЭКРАНА", function() end)
tracerCycle.MouseButton1Click:Connect(function()
    if _G.Tracer_Mode == "Bottom" then _G.Tracer_Mode = "Center"; tracerCycle.Text = "Линии: ЦЕНТР ЭКРАНА"
    elseif _G.Tracer_Mode == "Center" then _G.Tracer_Mode = "Top"; tracerCycle.Text = "Линии: ВВЕРХ ЭКРАНА"
    else _G.Tracer_Mode == "Bottom"; tracerCycle.Text = "Линии: НИЗ ЭКРАНА" end
end)

-- Категория: PLAYER
local playerCat = createCategory("Main / Player")
addFeature(playerCat, "Бесконечный Прыжок", function(v) _G.InfJump_Enabled = v end)
addFeature(playerCat, "Быстрый бег (50)", function(v) Speed_Enabled = v end)
addFeature(playerCat, "Высокий прыжок (120)", function(v) Jump_Enabled = v end)
addFeature(playerCat, "Проход сквозь стены (Ноклип)", function(v) _G.Noclip_Enabled = v end)
addFeature(playerCat, "Полет (Fly)", function(v) _G.Flying = v end)
addFeature(playerCat, "Крутилка (SpinBot)", function(v) _G.SpinBot_Enabled = v end)
addFeature(playerCat, "Увеличить Хитбоксы", function(v) _G.Hitbox_Enabled = v end)

local tpToolBtn = Instance.new("TextButton", playerCat)
tpToolBtn.Size = UDim2.new(1, 0, 0, 32); tpToolBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 90); tpToolBtn.Text = "Получить ТП Мышку"; tpToolBtn.TextColor3 = Color3.new(1,1,1); tpToolBtn.Font = Enum.Font.Gotham; tpToolBtn.TextSize = 12; Instance.new("UICorner", tpToolBtn)
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

-- Авто-обновление размера скролла при загрузке элементов
Scroll.CanvasSize = UDim2.new(0, 0, 0, MainLayout.AbsoluteContentSize.Y + 20)

-- === ЛОГИЧЕСКИЕ ДВИЖКИ ===

-- Логика бесконечного прыжка
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Поиск цели для аимбота
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

-- Проверка ролей в MM2
local function getMM2Role(player)
    if not _G.MM2_Revealer then return nil end
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then return "Murder" end
    if (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then return "Sheriff" end
    return nil
end

-- Создание Drawing ESP объектов
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

-- === ЦЕНТРАЛЬНЫЙ ЦИКЛ ОБНОВЛЕНИЯ (RENDERSTEPPED) ===
RunService.RenderStepped:Connect(function()
    currentRgbColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)

    -- Скорость бега и прыжки
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Speed_Enabled and _G.Cheat_Speed or Original_Speed
        if hum.UseJumpPower then 
            hum.JumpPower = Jump_Enabled and _G.Cheat_Jump or Original_Jump 
        else 
            hum.JumpHeight = Jump_Enabled and (_G.Cheat_Jump / 3) or Original_Jump 
        end
    end

    -- Настройки физики (Noclip, Полет, Spin)
    if _G.Noclip_Enabled and LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    if _G.SpinBot_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(35), 0) end
    if _G.Flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hrp = LocalPlayer.Character.HumanoidRootPart local hum = LocalPlayer.Character.Humanoid hrp.Velocity = Vector3.new(0, 0.1, 0)
        if hum.MoveDirection.Magnitude > 0 then hrp.Velocity = hum.MoveDirection * _G.FlySpeed end
    end

    -- Доводка Aimbot
    if _G.Aimbot_Enabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end

    -- Blade Ball Auto-Parry Движок
    if _G.AutoParry_Enabled then
        local balls = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("BallFolder")
        if balls then
            for _, ball in pairs(balls:GetChildren()) do
                if ball:IsA("BasePart") and ball:GetAttribute("Target") == LocalPlayer.Name then
                    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (ball.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 999
                    local speed = ball.Velocity.Magnitude
                    if distance < (speed * 0.45) or distance < 14 then
                        local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                        local parryRemote = rem and (rem:FindFirstChild("Parry") or rem:FindFirstChild("ParryAttempt"))
                        if parryRemote then parryRemote:FireServer() end
                    end
                end
            end
        end
    end

    -- Определение начальной точки линий трейсера
    local startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    if _G.Tracer_Mode == "Center" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif _G.Tracer_Mode == "Top" then startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0) end

    -- Отрисовка ESP / Chams / Hitbox
    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            -- Hitbox Expander
            if _G.Hitbox_Enabled then 
                rootPart.Size = Vector3.new(_G.Hitbox_Size, _G.Hitbox_Size, _G.Hitbox_Size)
                rootPart.Transparency = 0.6
                rootPart.BrickColor = BrickColor.new("Really red")
                rootPart.CanCollide = false 
            else 
                rootPart.Size = Vector3.new(2, 2, 1)
                rootPart.Transparency = 1 
            end

            local mm2Role = getMM2Role(player)

            -- Chams модуль
            if _G.Chams_Enabled then
                if not character:FindFirstChild("HubHighlight") then Instance.new("Highlight", character).Name = "HubHighlight" end
                local highlight = character.HubHighlight
                highlight.FillTransparency = 0.4
                if mm2Role == "Murder" then highlight.FillColor = Color3.fromRGB(255, 0, 0)
                elseif mm2Role == "Sheriff" then highlight.FillColor = Color3.fromRGB(0, 0, 255)
                else highlight.FillColor = _G.RGB_Chams and currentRgbColor or Color3.fromRGB(255, 255, 255) end
            else
                if character:FindFirstChild("HubHighlight") then character.HubHighlight:Destroy() end
            end

            -- Отрисовка элементов 2D Drawing
            if _G.ESP_Enabled and onScreen then
                local displayColor = Color3.fromRGB(255, 255, 255)
                if mm2Role == "Murder" then displayColor = Color3.fromRGB(255, 35, 35)
                elseif mm2Role == "Sheriff" then displayColor = Color3.fromRGB(35, 35, 255)
                elseif _G.Tracer_Color_Mode == "Team" and player.Team then displayColor = player.TeamColor.Color end

                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                -- Игнорировать отрисовку за UI
                local inMenu = MainFrame.Visible and (vector.X >= MainFrame.AbsolutePosition.X and vector.X <= MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X and vector.Y >= MainFrame.AbsolutePosition.Y and vector.Y <= MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y)

                if not inMenu then
                    obj.Box.Color = displayColor; obj.Box.Size = Vector2.new(scale * 1.4, scale * 2.4); obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2); obj.Box.Visible = true
                    obj.Tracer.Color = displayColor; obj.Tracer.From = startPoint; obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2)); obj.Tracer.Visible = true
                    
                    local tag = ""
                    if _G.Show_Names then tag = tag .. player.Name end
                    if mm2Role then tag = tag .. " [" .. mm2Role .. "]" end
                    if _G.Show_Dist then tag = tag .. " [" .. math.floor(dist) .. "m]" end
                    
                    obj.Text.Text = tag; obj.Text.Position = Vector2.new(vector.X, vector.Y - (obj.Box.Size.Y / 2) - 18); obj.Text.Color = displayColor; obj.Text.Visible = true
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

print("c00lkidd214anzz Hub Monolith Loaded!")
