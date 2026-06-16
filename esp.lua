-- C00lkidd214anzz Hub (ESP Boxes + Tracers + Team Color Custom)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled = true
local espObjects = {}

-- 1. Ватермарк
local watermark = Drawing.new("Text")
watermark.Text = "C00lkidd214anzz Hub"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Outline = true
watermark.Position = Vector2.new(10, 30)
watermark.Visible = true
watermark.Font = 2

-- 2. GUI Кнопка управления
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 120, 0, 50)
button.Position = UDim2.new(0.1, 0, 0.1, 0)
button.Text = "ESP: ON"
button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
button.Draggable = true
button.Active = true

button.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    button.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    button.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    
    if not ESP_Enabled then
        for _, obj in pairs(espObjects) do 
            obj.Box.Visible = false 
            obj.Tracer.Visible = false 
        end
    end
end)

-- Функция генерации объектов рисования
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

-- Очистка объектов при выходе игрока
local function removeESPItems(player)
    if espObjects[player] then
        espObjects[player].Box:Remove()
        espObjects[player].Tracer:Remove()
        espObjects[player] = nil
    end
end

-- Старт для текущих игроков в комнате
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then espObjects[player] = createESPItems() end
end

-- Отслеживание новых подключений
Players.PlayerAdded:Connect(function(player)
    espObjects[player] = createESPItems()
end)

Players.PlayerRemoving:Connect(function(player)
    removeESPItems(player)
end)

-- Основной рабочий цикл рендеринга кадра
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
    if not ESP_Enabled then return end

    -- Расчет нижней центральной точки дисплея
    local screenCenterBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)

    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            -- Логика распределения цветов: Зеленый — свои, Красный — чужие
            local displayColor
            if player.Team and LocalPlayer.Team then
                if player.Team == LocalPlayer.Team then
                    displayColor = Color3.fromRGB(50, 255, 50)  -- Союзник
                else
                    displayColor = Color3.fromRGB(255, 50, 50)  -- Враг
                end
            else
                displayColor = Color3.fromRGB(255, 50, 50)      -- Одиночный режим / Все враги
            end

            obj.Box.Color = displayColor
            obj.Tracer.Color = displayColor

            if onScreen then
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                -- Позиционирование 2D Рамки
                obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5)
                obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2)
                obj.Box.Visible = true

                -- Позиционирование направляющей линии к ногам
                obj.Tracer.From = screenCenterBottom
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

print("C00lkidd214anzz Hub Successfully Updated!")
