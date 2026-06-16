-- c00lkidd214anzz Hub (Advanced Menu + Multi-Team ESP)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled = true
local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
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

-- 2. Создание полноценного GUI Меню
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))

-- Главная кнопка открытия/закрытия меню (С полным ником)
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 160, 0, 45) -- Немного увеличил ширину под полный ник
mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
mainToggle.Text = "c00lkidd214anzz Menu"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.TextSize = 15
mainToggle.Draggable = true
mainToggle.Active = true

local uiCornerMain = Instance.new("UICorner", mainToggle)

-- Панель самого меню (появляется рядом с кнопкой)
local menuFrame = Instance.new("Frame", screenGui)
menuFrame.Size = UDim2.new(0, 180, 0, 180)
menuFrame.Position = UDim2.new(0.1, 0, 0.1, 55)
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menuFrame.Visible = false
local uiCornerFrame = Instance.new("UICorner", menuFrame)

-- Привязка меню к кнопке, чтобы его можно было открывать/закрывать кликом
mainToggle.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
    menuFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
end)

-- Перетаскивание меню вслед за кнопкой
mainToggle.Changed:Connect(function(prop)
    if prop == "Position" then
        menuFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
    end
end)

-- Кнопка ВКЛ/ВЫКЛ ESP внутри меню
local espToggleBtn = Instance.new("TextButton", menuFrame)
espToggleBtn.Size = UDim2.new(0, 160, 0, 35)
espToggleBtn.Position = UDim2.new(0, 10, 0, 15)
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

-- Текст-заголовок для режимов линий
local tracerLabel = Instance.new("TextLabel", menuFrame)
tracerLabel.Size = UDim2.new(0, 160, 0, 20)
tracerLabel.Position = UDim2.new(0, 10, 0, 65)
tracerLabel.Text = "Положение линий:"
tracerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
tracerLabel.BackgroundTransparency = 1
tracerLabel.Font = Enum.Font.SourceSans
tracerLabel.TextSize = 14

-- Кнопка изменения положения линий
local tracerModeBtn = Instance.new("TextButton", menuFrame)
tracerModeBtn.Size = UDim2.new(0, 160, 0, 35)
tracerModeBtn.Position = UDim2.new(0, 10, 0, 90)
tracerModeBtn.Text = "НИЗ ЭКРАНА"
tracerModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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

-- Скрипт механики ESP
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

-- Логика обновлений
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
    if not ESP_Enabled then return end

    -- Вычисление начальной точки линий
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

            -- Автоматический цвет под каждую тиму
            local displayColor = Color3.fromRGB(255, 255, 255)
            if player.Team then
                displayColor = player.TeamColor.Color
            end

            obj.Box.Color = displayColor
            obj.Tracer.Color = displayColor

            if onScreen then
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                -- Бокс
                obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5)
                obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2)
                obj.Box.Visible = true

                -- Линия
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

print("c00lkidd214anzz Advanced Hub Successfully Updated!")
