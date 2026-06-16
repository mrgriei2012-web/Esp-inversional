-- c00lkidd214anzz Hub (Final Stable Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled, Chams_Enabled, Hitbox_Enabled, Noclip_Enabled = false, false, false, false
local Custom_Speed, Custom_Jump = 16, 50

-- UI
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Ватермарк
local wm = Instance.new("TextLabel", screenGui); wm.Size = UDim2.new(0, 200, 0, 30); wm.Position = UDim2.new(0, 10, 0, 50); wm.Text = "c00lkidd214anzz Hub"; wm.TextColor3 = Color3.new(1,1,1); wm.BackgroundTransparency = 1; wm.Font = Enum.Font.SourceSansBold

-- Меню
local mainToggle = Instance.new("TextButton", screenGui); mainToggle.Size = UDim2.new(0, 150, 0, 40); mainToggle.Position = UDim2.new(0.02, 0, 0.1, 0); mainToggle.Text = "MENU"; mainToggle.BackgroundColor3 = Color3.fromRGB(30,30,30); mainToggle.Draggable = true; Instance.new("UICorner", mainToggle)
local mainFrame = Instance.new("Frame", screenGui); mainFrame.Size = UDim2.new(0, 400, 0, 300); mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0); mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20); mainFrame.Visible = false; mainFrame.Draggable = true; Instance.new("UICorner", mainFrame)
mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

local sidebar = Instance.new("Frame", mainFrame); sidebar.Size = UDim2.new(0, 120, 1, 0); sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15); Instance.new("UICorner", sidebar)
local pages = {Visuals = Instance.new("Frame", mainFrame), Player = Instance.new("Frame", mainFrame), Teleports = Instance.new("Frame", mainFrame)}
for n, p in pairs(pages) do p.Size = UDim2.new(0, 280, 1, 0); p.Position = UDim2.new(0, 120, 0, 0); p.BackgroundTransparency = 1; p.Visible = (n == "Visuals") end

local function addBtn(parent, text, callback)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0, 240, 0, 40); b.Text = text; b.BackgroundColor3 = Color3.fromRGB(40,40,40); b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(function() callback(b) end); return b
end

-- Вкладки
for n, p in pairs(pages) do
    local t = Instance.new("TextButton", sidebar); t.Size = UDim2.new(0, 100, 0, 35); t.Position = UDim2.new(0, 10, 0, (n=="Visuals" and 20 or n=="Player" and 65 or 110)); t.Text = n; t.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", t); t.MouseButton1Click:Connect(function() for _, pg in pairs(pages) do pg.Visible = false end; p.Visible = true end)
end

-- Кнопки функций
addBtn(pages.Visuals, "ESP (Boxes)", function(b) ESP_Enabled = not ESP_Enabled; b.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50,200,50) or Color3.fromRGB(40,40,40) end).Position = UDim2.new(0, 20, 0, 20)
addBtn(pages.Visuals, "Chams", function(b) Chams_Enabled = not Chams_Enabled; b.BackgroundColor3 = Chams_Enabled and Color3.fromRGB(50,200,50) or Color3.fromRGB(40,40,40) end).Position = UDim2.new(0, 20, 0, 70)
addBtn(pages.Player, "Speed: 16", function(b) Custom_Speed = (Custom_Speed == 16) and 50 or 16; b.Text = "Speed: " .. Custom_Speed end).Position = UDim2.new(0, 20, 0, 20)
addBtn(pages.Player, "Hitbox: OFF", function(b) Hitbox_Enabled = not Hitbox_Enabled; b.BackgroundColor3 = Hitbox_Enabled and Color3.fromRGB(50,200,50) or Color3.fromRGB(40,40,40) end).Position = UDim2.new(0, 20, 0, 70)

-- Телепорты
local scroll = Instance.new("ScrollingFrame", pages.Teleports); scroll.Size = UDim2.new(0, 250, 0, 250); scroll.Position = UDim2.new(0, 15, 0, 20)
RunService.RenderStepped:Connect(function()
    if #scroll:GetChildren() < #Players:GetPlayers() then
        scroll:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local b = Instance.new("TextButton", scroll); b.Size = UDim2.new(0, 230, 0, 30); b.Text = p.Name; b.Position = UDim2.new(0, 0, 0, #scroll:GetChildren()*35)
                b.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end)
            end
        end
    end
end)

-- Логика (ESP и остальное)
local espBox = Drawing.new("Square"); espBox.Visible = false; espBox.Thickness = 2
RunService.RenderStepped:Connect(function()
    -- ESP
    local target = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, on = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if ESP_Enabled and on then espBox.Visible = true; espBox.Position = Vector2.new(pos.X-25, pos.Y-40); espBox.Size = Vector2.new(50,80) else espBox.Visible = false end
            if Chams_Enabled and not p.Character:FindFirstChild("Highlight") then local h = Instance.new("Highlight", p.Character); h.FillColor = Color3.new(1,0,0) elseif not Chams_Enabled and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
            if Hitbox_Enabled then p.Character.HumanoidRootPart.Size = Vector3.new(5,5,5); p.Character.HumanoidRootPart.Transparency = 0.5 end
        end
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed end
end)
