-- c00lkidd214anzz Hub (Full Edition: White Scanline Animation)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled = true
local Custom_Speed = 16
local espObjects = {}

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.IgnoreGuiInset = false
screenGui.DisplayOrder = 999 

-- 1. Кнопка MENU (Слева сверху, не мешает прыжку)
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 100, 0, 40)
mainToggle.Position = UDim2.new(0, 10, 0, 10)
mainToggle.Text = "MENU"
mainToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.Draggable = true
mainToggle.Active = true
Instance.new("UICorner", mainToggle)
Instance.new("UIStroke", mainToggle).Color = Color3.fromRGB(255, 255, 255)

-- 2. Главное окно
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
Instance.new("UICorner", mainFrame)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(255, 255, 255)

-- Анимация "Белая линия"
local menuGradient = Instance.new("UIGradient", mainFrame)
menuGradient.Rotation = 0
menuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Создание кнопок
local function createBtn(text, parent, pos)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, 280, 0, 45)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    Instance.new("UIStroke", b).Color = Color3.fromRGB(255, 255, 255)
    return b
end

local b1 = createBtn("ESP: ON", mainFrame, UDim2.new(0, 20, 0, 40))
b1.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    b1.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
end)

local b2 = createBtn("SPEED: 16", mainFrame, UDim2.new(0, 20, 0, 110))
b2.MouseButton1Click:Connect(function()
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    b2.Text = "SPEED: " .. Custom_Speed
end)

-- Анимация вращения градиента
task.spawn(function()
    while true do
        for i = 0, 360, 2 do
            menuGradient.Rotation = i
            task.wait(0.02)
        end
    end
end)

-- ESP Логика
local function createESP()
    local sq = Drawing.new("Square"); sq.Visible = false; sq.Filled = false; sq.Thickness = 2; sq.Color = Color3.new(1,1,1)
    return sq
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espObjects[p] = createESP() end end
Players.PlayerAdded:Connect(function(p) espObjects[p] = createESP() end)
Players.PlayerRemoving:Connect(function(p) if espObjects[p] then espObjects[p]:Remove(); espObjects[p] = nil end end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed
    end
    if not ESP_Enabled then for _, v in pairs(espObjects) do v.Visible = false end return end
    for p, sq in pairs(espObjects) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos, on = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            if on then
                sq.Size = Vector2.new(50, 80); sq.Position = Vector2.new(pos.X - 25, pos.Y - 40); sq.Visible = true
            else sq.Visible = false end
        else sq.Visible = false end
    end
end)
