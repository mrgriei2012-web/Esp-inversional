-- c00lkidd214anzz Hub (ULTIMATE EDITION)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки
local ESP_Enabled, Noclip_Enabled, Hitbox_Enabled = false, false, false
local Custom_Speed, Custom_Jump, Hitbox_Size = 16, 50, 5
local espObjects = {}

local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- 1. Кнопка MENU
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 150, 0, 40); mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0); mainToggle.Text = "MENU"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Draggable = true; mainToggle.ZIndex = 10
Instance.new("UICorner", mainToggle)

-- 2. Главное окно
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 300); mainFrame.Position = UDim2.new(0.5, -210, 0.5, -150); mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.Visible = false; mainFrame.Draggable = true; mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame)
mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Сайдбар
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0); sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); sidebar.ZIndex = 6
Instance.new("UICorner", sidebar)

local pages = {
    Visuals = Instance.new("Frame", mainFrame),
    Player = Instance.new("Frame", mainFrame),
    Teleports = Instance.new("Frame", mainFrame)
}
for _, p in pairs(pages) do p.Size = UDim2.new(0, 280, 1, 0); p.Position = UDim2.new(0, 120, 0, 0); p.BackgroundTransparency = 1; p.Visible = false; p.ZIndex = 6 end
pages.Visuals.Visible = true

-- Кнопки вкладок
local function createTab(name, pos)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0, 100, 0, 30); btn.Position = pos; btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40,40,40); btn.TextColor3 = Color3.new(1,1,1); btn.ZIndex = 7
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() for _, p in pairs(pages) do p.Visible = false end; pages[name].Visible = true end)
end
createTab("Visuals", UDim2.new(0, 10, 0, 20)); createTab("Player", UDim2.new(0, 10, 0, 60)); createTab("Teleports", UDim2.new(0, 10, 0, 100))

-- Контент
local espBtn = Instance.new("TextButton", pages.Visuals); espBtn.Size = UDim2.new(0, 250, 0, 40); espBtn.Position = UDim2.new(0, 15, 0, 20); espBtn.Text = "ESP & CHAMS: OFF"; espBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); espBtn.ZIndex = 7
Instance.new("UICorner", espBtn)
espBtn.MouseButton1Click:Connect(function() ESP_Enabled = not ESP_Enabled; espBtn.Text = ESP_Enabled and "ESP & CHAMS: ON" or "ESP & CHAMS: OFF" end)

local ncBtn = Instance.new("TextButton", pages.Player); ncBtn.Size = UDim2.new(0, 250, 0, 40); ncBtn.Position = UDim2.new(0, 15, 0, 20); ncBtn.Text = "NOCLIP: OFF"; ncBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); ncBtn.ZIndex = 7
Instance.new("UICorner", ncBtn); ncBtn.MouseButton1Click:Connect(function() Noclip_Enabled = not Noclip_Enabled; ncBtn.Text = Noclip_Enabled and "NOCLIP: ON" or "NOCLIP: OFF" end)

local hbBtn = Instance.new("TextButton", pages.Player); hbBtn.Size = UDim2.new(0, 250, 0, 40); hbBtn.Position = UDim2.new(0, 15, 0, 70); hbBtn.Text = "HITBOX: OFF"; hbBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); hbBtn.ZIndex = 7
Instance.new("UICorner", hbBtn); hbBtn.MouseButton1Click:Connect(function() Hitbox_Enabled = not Hitbox_Enabled; hbBtn.Text = Hitbox_Enabled and "HITBOX: ON" or "HITBOX: OFF" end)

-- Список телепортов
local scroll = Instance.new("ScrollingFrame", pages.Teleports); scroll.Size = UDim2.new(0, 250, 0, 250); scroll.Position = UDim2.new(0, 15, 0, 20); scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
RunService.RenderStepped:Connect(function()
    scroll:ClearAllChildren()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", scroll); btn.Size = UDim2.new(0, 230, 0, 30); btn.Text = p.Name; btn.Parent = scroll
            btn.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end)
        end
    end
end)

-- Основной цикл
RunService.RenderStepped:Connect(function()
    -- NoClip
    if Noclip_Enabled and LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    
    -- Hitbox
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            if Hitbox_Enabled then hrp.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size); hrp.Transparency = 0.5; hrp.CanCollide = false
            else hrp.Size = Vector3.new(2,2,1); hrp.Transparency = 1 end
        end
    end

    -- ESP & Chams
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if ESP_Enabled then
                if not p.Character:FindFirstChild("Highlight") then local h = Instance.new("Highlight", p.Character); h.FillColor = Color3.new(1,0,0) end
                local pos, on = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if on then -- Можно добавить сюда отрисовку текста, если нужно
                end
            else
                if p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
            end
        end
    end
end)
