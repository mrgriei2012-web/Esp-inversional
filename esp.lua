-- c00lkidd214anzz Hub (FIXED ULTIMATE EDITION)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled, Chams_Enabled, Hitbox_Enabled, Noclip_Enabled = false, false, false, false
local Custom_Speed, Custom_Jump = 16, 50

local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Меню
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 150, 0, 40); mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0); mainToggle.Text = "MENU"; mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Draggable = true; mainToggle.ZIndex = 10
Instance.new("UICorner", mainToggle)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 300); mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0); mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.Visible = false; mainFrame.Draggable = true; mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame)
mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, 0); sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); sidebar.ZIndex = 6
Instance.new("UICorner", sidebar)

-- Страницы
local pages = {}
local function createPage(name, pos)
    local p = Instance.new("Frame", mainFrame); p.Size = UDim2.new(0, 280, 1, 0); p.Position = UDim2.new(0, 120, 0, 0); p.BackgroundTransparency = 1; p.Visible = false; p.ZIndex = 6
    pages[name] = p
    local tab = Instance.new("TextButton", sidebar); tab.Size = UDim2.new(0, 100, 0, 35); tab.Position = pos; tab.Text = name; tab.BackgroundColor3 = Color3.fromRGB(40,40,40); tab.TextColor3 = Color3.new(1,1,1); tab.ZIndex = 7
    Instance.new("UICorner", tab)
    tab.MouseButton1Click:Connect(function() for _, pg in pairs(pages) do pg.Visible = false end; p.Visible = true end)
end
createPage("Visuals", UDim2.new(0, 10, 0, 20)); createPage("Player", UDim2.new(0, 10, 0, 60)); createPage("Teleports", UDim2.new(0, 10, 0, 100))
pages.Visuals.Visible = true

-- Функции кнопок
local function addBtn(parent, text, callback)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0, 250, 0, 40); b.Text = text; b.BackgroundColor3 = Color3.fromRGB(40,40,40); b.TextColor3 = Color3.new(1,1,1); b.ZIndex = 8
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(callback)
    return b
end

-- Вкладка Visuals
addBtn(pages.Visuals, "ESP (Boxes): OFF", function(b) ESP_Enabled = not ESP_Enabled; b.Text = ESP_Enabled and "ESP (Boxes): ON" or "ESP (Boxes): OFF" end).Position = UDim2.new(0, 15, 0, 20)
addBtn(pages.Visuals, "Chams: OFF", function(b) Chams_Enabled = not Chams_Enabled; b.Text = Chams_Enabled and "Chams: ON" or "Chams: OFF" end).Position = UDim2.new(0, 15, 0, 70)

-- Вкладка Player
addBtn(pages.Player, "Speed: 16", function(b) Custom_Speed = (Custom_Speed == 16) and 50 or 16; b.Text = "Speed: " .. Custom_Speed end).Position = UDim2.new(0, 15, 0, 20)
addBtn(pages.Player, "Jump: 50", function(b) Custom_Jump = (Custom_Jump == 50) and 120 or 50; b.Text = "Jump: " .. Custom_Jump end).Position = UDim2.new(0, 15, 0, 70)
addBtn(pages.Player, "Hitbox: OFF", function(b) Hitbox_Enabled = not Hitbox_Enabled; b.Text = Hitbox_Enabled and "Hitbox: ON" or "Hitbox: OFF" end).Position = UDim2.new(0, 15, 0, 120)
addBtn(pages.Player, "Noclip: OFF", function(b) Noclip_Enabled = not Noclip_Enabled; b.Text = Noclip_Enabled and "Noclip: ON" or "Noclip: OFF" end).Position = UDim2.new(0, 15, 0, 170)

-- Вкладка Teleports
local scroll = Instance.new("ScrollingFrame", pages.Teleports); scroll.Size = UDim2.new(0, 250, 0, 250); scroll.Position = UDim2.new(0, 15, 0, 20); scroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
RunService.RenderStepped:Connect(function()
    if #scroll:GetChildren() ~= #Players:GetPlayers() then
        scroll:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local btn = Instance.new("TextButton", scroll); btn.Size = UDim2.new(0, 230, 0, 30); btn.Text = p.Name; btn.Parent = scroll
                btn.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end)
            end
        end
    end
end)

-- Основной цикл (ESP, Chams, Hitbox, Physics)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Chams
                if Chams_Enabled then if not p.Character:FindFirstChild("Highlight") then local h = Instance.new("Highlight", p.Character); h.FillColor = Color3.new(1,0,0) end
                elseif p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
                -- Hitbox
                hrp.Size = Hitbox_Enabled and Vector3.new(5,5,5) or Vector3.new(2,2,1); hrp.Transparency = Hitbox_Enabled and 0.5 or 1
            end
        end
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed
        LocalPlayer.Character.Humanoid.JumpPower = Custom_Jump
        if Noclip_Enabled then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    end
end)
