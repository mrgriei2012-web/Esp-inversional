-- c00lkidd214anzz Hub (Full Independent Edition)
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

-- 1. Кнопка открытия
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

-- 2. Большое меню
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
Instance.new("UICorner", mainFrame)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Text = " c00lkidd214anzz Settings"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local menuGradient = Instance.new("UIGradient", mainFrame)
menuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
})

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Вкладки
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, -30); sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", sidebar)

local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 310, 1, -30); visualsPage.Position = UDim2.new(0, 135, 0, 35); visualsPage.BackgroundTransparency = 1

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 310, 1, -30); playerPage.Position = UDim2.new(0, 135, 0, 35); playerPage.BackgroundTransparency = 1; playerPage.Visible = false

local function showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
end

-- Кнопки вкладок
local tabV = Instance.new("TextButton", sidebar)
tabV.Size = UDim2.new(0, 110, 0, 35); tabV.Position = UDim2.new(0, 10, 0, 10); tabV.Text = "Visuals"; tabV.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", tabV)
tabV.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tabP = Instance.new("TextButton", sidebar)
tabP.Size = UDim2.new(0, 110, 0, 35); tabP.Position = UDim2.new(0, 10, 0, 50); tabP.Text = "Player"; tabP.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", tabP)
tabP.MouseButton1Click:Connect(function() showPage(playerPage) end)

-- [CONTENT]
local espBtn = Instance.new("TextButton", visualsPage)
espBtn.Size = UDim2.new(0, 250, 0, 40); espBtn.Text = "ESP: ON"; espBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50); Instance.new("UICorner", espBtn)
espBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

local trBtn = Instance.new("TextButton", visualsPage)
trBtn.Size = UDim2.new(0, 250, 0, 40); trBtn.Position = UDim2.new(0, 0, 0, 50); trBtn.Text = "Линии: НИЗ"; trBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", trBtn)
trBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then Tracer_Mode = "Center"; trBtn.Text = "Линии: ЦЕНТР"
    elseif Tracer_Mode == "Center" then Tracer_Mode = "Top"; trBtn.Text = "Линии: ВВЕРХ"
    else Tracer_Mode = "Bottom"; trBtn.Text = "Линии: НИЗ" end
end)

local spdBtn = Instance.new("TextButton", playerPage)
spdBtn.Size = UDim2.new(0, 250, 0, 40); spdBtn.Text = "Скорость: 16"; spdBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", spdBtn)
spdBtn.MouseButton1Click:Connect(function()
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    spdBtn.Text = "Скорость: " .. Custom_Speed
end)

-- LOGIC
task.spawn(function()
    while true do
        for i = 0, 360, 5 do
            menuGradient.Rotation = i
            task.wait(0.05)
        end
    end
end)

local function createESP()
    local box = Drawing.new("Square"); box.Visible = false; box.Filled = false; box.Thickness = 2
    local line = Drawing.new("Line"); line.Visible = false; line.Thickness = 1.5
    return {Box = box, Tracer = line}
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then espObjects[p] = createESP() end end
Players.PlayerAdded:Connect(function(p) espObjects[p] = createESP() end)
Players.PlayerRemoving:Connect(function(p) if espObjects[p] then espObjects[p].Box:Remove(); espObjects[p].Tracer:Remove(); espObjects[p] = nil end end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed
    end
    if not ESP_Enabled then return end
    local start = (Tracer_Mode == "Bottom" and Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)) or (Tracer_Mode == "Center" and Camera.ViewportSize/2) or Vector2.new(Camera.ViewportSize.X/2, 0)
    for p, o in pairs(espObjects) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
            local pos, on = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            if on then
                local s = 1000 / (Camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude
                o.Box.Size = Vector2.new(s*1.5, s*2.5); o.Box.Position = Vector2.new(pos.X - s*0.75, pos.Y - s*1.25)
                o.Box.Color = p.TeamColor.Color; o.Box.Visible = true
                o.Tracer.From = start; o.Tracer.To = Vector2.new(pos.X, pos.Y + s*1.25); o.Tracer.Color = p.TeamColor.Color; o.Tracer.Visible = true
            else o.Box.Visible = false; o.Tracer.Visible = false end
        else o.Box.Visible = false; o.Tracer.Visible = false end
    end
end)
