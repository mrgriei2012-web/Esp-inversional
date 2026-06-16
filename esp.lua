-- c00lkidd214anzz Hub (Independent Drag Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled = true
local Tracer_Mode = "Bottom"
local Custom_Speed = 16
local Custom_Jump = 50
local espObjects = {}

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- 1. Кнопка MENU (Независимое движение)
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 150, 0, 40)
mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
mainToggle.Text = "MENU"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.Draggable = true -- Включено независимое движение
mainToggle.Active = true
Instance.new("UICorner", mainToggle)

-- 2. Большое меню (Независимое движение)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true -- Включено независимое движение
mainFrame.Active = true
Instance.new("UICorner", mainFrame)

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Сайдбар
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", sidebar)

-- Страницы
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 280, 1, 0); visualsPage.Position = UDim2.new(0, 120, 0, 0); visualsPage.BackgroundTransparency = 1

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 280, 1, 0); playerPage.Position = UDim2.new(0, 120, 0, 0); playerPage.BackgroundTransparency = 1; playerPage.Visible = false

local function showPage(page) visualsPage.Visible = (page == visualsPage); playerPage.Visible = (page == playerPage) end

-- Кнопки вкладок
local tab1 = Instance.new("TextButton", sidebar)
tab1.Size = UDim2.new(0, 100, 0, 30); tab1.Position = UDim2.new(0, 10, 0, 20); tab1.Text = "Visuals"; tab1.BackgroundColor3 = Color3.fromRGB(40,40,40); tab1.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tab1)
tab1.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tab2 = Instance.new("TextButton", sidebar)
tab2.Size = UDim2.new(0, 100, 0, 30); tab2.Position = UDim2.new(0, 10, 0, 60); tab2.Text = "Player"; tab2.BackgroundColor3 = Color3.fromRGB(40,40,40); tab2.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tab2)
tab2.MouseButton1Click:Connect(function() showPage(playerPage) end)

-- Контент
local espBtn = Instance.new("TextButton", visualsPage)
espBtn.Size = UDim2.new(0, 250, 0, 40); espBtn.Position = UDim2.new(0, 15, 0, 20); espBtn.Text = "ESP: ON"; espBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); Instance.new("UICorner", espBtn)
espBtn.MouseButton1Click:Connect(function() ESP_Enabled = not ESP_Enabled; espBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"; espBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50) end)

local spdBtn = Instance.new("TextButton", playerPage)
spdBtn.Size = UDim2.new(0, 250, 0, 40); spdBtn.Position = UDim2.new(0, 15, 0, 20); spdBtn.Text = "SPEED: 16"; spdBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); Instance.new("UICorner", spdBtn)
spdBtn.MouseButton1Click:Connect(function() Custom_Speed = (Custom_Speed == 16) and 50 or 16; spdBtn.Text = "SPEED: " .. Custom_Speed end)

-- ESP Логика (как и была)
local function createESP() local s = Drawing.new("Square"); s.Visible=false; s.Thickness=2; return s end
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espObjects[p] = createESP() end end
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed end
    if not ESP_Enabled then for _, o in pairs(espObjects) do o.Visible = false end return end
    for p, o in pairs(espObjects) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos, on = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            if on then o.Size=Vector2.new(50,80); o.Position=Vector2.new(pos.X-25, pos.Y-40); o.Visible=true else o.Visible=false end
        end
    end
end)
