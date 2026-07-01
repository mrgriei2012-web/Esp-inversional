-- c00lkidd214anzz Hub v3 - PART 1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Параметры
local ESP_Enabled, WallCheck, TeamCheck = false, true, true
local Aimbot_Enabled, Noclip_Enabled, Flying = false, false, false
local espObjects = {}

-- Функции проверки
local function isVisible(targetPart)
    if not WallCheck then return true end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(Camera.CFrame.Position, targetPart.Position - Camera.CFrame.Position, params)
    return not result or result.Instance:IsDescendantOf(targetPart.Parent)
end

local function isEnemy(player)
    if not TeamCheck then return true end
    if not player.Team or not LocalPlayer.Team then return true end
    return player.Team ~= LocalPlayer.Team
end

-- GUI (Выводим выше всего, чтобы Infinite Yield не перекрывал)
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.DisplayOrder = 999 -- Приоритет над другими меню
screenGui.IgnoreGuiInset = true

local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 200, 0, 50); mainToggle.Position = UDim2.new(0.5, -100, 0, 20)
mainToggle.Text = "c00lkidd214anzz Menu"; mainToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Draggable = true; mainToggle.Active = true
Instance.new("UICorner", mainToggle)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300); mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainFrame.Visible = false; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame)

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)-- c00lkidd214anzz Hub v3 - PART 2
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -20, 1, -60); contentContainer.Position = UDim2.new(0, 10, 0, 50); contentContainer.BackgroundTransparency = 1

local function createFeature(name, default, callback)
    local btn = Instance.new("TextButton", contentContainer)
    btn.Size = UDim2.new(0, 230, 0, 40); btn.BackgroundColor3 = default and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    btn.Text = name; btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btn)
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
        callback(state)
    end)
    return btn
end

-- Кнопки управления Аимботом
createFeature("Aimbot", Aimbot_Enabled, function(v) Aimbot_Enabled = v end)
createFeature("WallCheck", WallCheck, function(v) WallCheck = v end)
createFeature("TeamCheck", TeamCheck, function(v) TeamCheck = v end)

-- Кнопки остальных функций
createFeature("ESP Boxes", ESP_Enabled, function(v) ESP_Enabled = v end)
createFeature("Noclip", Noclip_Enabled, function(v) Noclip_Enabled = v end)
createFeature("Fly", Flying, function(v) Flying = v end)

-- Упорядочивание кнопок (UIListLayout)
local layout = Instance.new("UIListLayout", contentContainer)
layout.Padding = UDim.new(0, 5)
-- c00lkidd214anzz Hub v3 - PART 3 (FINAL)
RunService.RenderStepped:Connect(function()
    -- Логика Аимбота
    if Aimbot_Enabled then
        local closest, maxDist = nil, math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and isEnemy(p) then
                local part = p.Character:FindFirstChild("Head") or p.Character.HumanoidRootPart
                if isVisible(part) then
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < maxDist then maxDist = dist; closest = part end
                    end
                end
            end
        end
        if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
    end

    -- Логика Noclip
    if Noclip_Enabled and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end

    -- Логика Полета
    if Flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        hrp.Velocity = (hum and hum.MoveDirection * 50) or Vector3.new(0, 0, 0)
    end
end)

print("c00lkidd214anzz Hub v3: Загрузка завершена. Меню активно!")
