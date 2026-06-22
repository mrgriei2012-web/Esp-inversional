-- c00lkidd214anzz Hub (Ultimate Professional Edition 2026)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

-- Настройки функций
local ESP_Enabled, Show_Names, Show_Dist, Show_Icons, Chams_Enabled = false, true, true, false, false
local AutoParry_Enabled, Aimbot_Enabled, InfJump_Enabled, Flying = false, false, false, false
local fovCircle = Drawing.new("Circle"); fovCircle.Radius = 150; fovCircle.Thickness = 2; fovCircle.Visible = false

-- Инициализация GUI
local screenGui = Instance.new("ScreenGui", CoreGui); screenGui.ResetOnSpawn = false
local mainFrame = Instance.new("Frame", screenGui); mainFrame.Size = UDim2.new(0, 550, 0, 350); mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175); mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.Visible = false; mainFrame.Draggable = true; Instance.new("UICorner", mainFrame)
local sidebar = Instance.new("Frame", mainFrame); sidebar.Size = UDim2.new(0, 150, 1, -20); sidebar.Position = UDim2.new(0, 10, 0, 10); sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", sidebar)
local sideScroll = Instance.new("ScrollingFrame", sidebar); sideScroll.Size = UDim2.new(1, -10, 1, -10); sideScroll.Position = UDim2.new(0, 5, 0, 5); sideScroll.BackgroundTransparency = 1; Instance.new("UIListLayout", sideScroll).Padding = UDim.new(0, 5)
local contentContainer = Instance.new("Frame", mainFrame); contentContainer.Size = UDim2.new(1, -180, 1, -20); contentContainer.Position = UDim2.new(0, 170, 0, 10); contentContainer.BackgroundTransparency = 1

local pages = {}
local function createTab(name)
    local page = Instance.new("ScrollingFrame", contentContainer); page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = false; Instance.new("UIListLayout", page).Padding = UDim.new(0, 5)
    local tabBtn = Instance.new("TextButton", sideScroll); tabBtn.Size = UDim2.new(1, 0, 0, 35); tabBtn.Text = name; tabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); Instance.new("UICorner", tabBtn)
    tabBtn.MouseButton1Click:Connect(function() for _,p in pairs(pages) do p.Visible = false end; page.Visible = true end)
    table.insert(pages, page)
    return page
end

local function addFeature(parent, text, callback)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, -10, 0, 35); btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Instance.new("UICorner", btn)
    local state = false
    btn.MouseButton1Click:Connect(function() state = not state; btn.BackgroundColor3 = state and Color3.fromRGB(50,150,50) or Color3.fromRGB(40,40,40); callback(state) end)
end

-- Вкладки
local visPage = createTab("Visuals")
addFeature(visPage, "ESP Boxes", function(v) ESP_Enabled = v end)
addFeature(visPage, "Аватары над игроками", function(v) Show_Icons = v end)
addFeature(visPage, "Fullbright", function(v) game:GetService("Lighting").Brightness = v and 2 or 1; game:GetService("Lighting").Ambient = v and Color3.new(1,1,1) or Color3.new(0,0,0) end)
addFeature(visPage, "Круг FOV", function(v) fovCircle.Visible = v end)

local bbPage = createTab("Blade Ball")
addFeature(bbPage, "Авто-Блок", function(v) AutoParry_Enabled = v end)

local musicPage = createTab("Music")
local txt = Instance.new("TextBox", musicPage); txt.Size = UDim2.new(1, -10, 0, 40); txt.Text = "1837874690"; Instance.new("UICorner", txt)
local btn = Instance.new("TextButton", musicPage); btn.Size = UDim2.new(1, -10, 0, 40); btn.Text = "PLAY MUSIC"; btn.MouseButton1Click:Connect(function() 
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("ClientMusic", true)
    if remote then pcall(function() remote:FireServer("Play", txt.Text) end) end
end); Instance.new("UICorner", btn)

-- Движок
RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
    if AutoParry_Enabled then
        for _, ball in pairs(workspace:GetChildren()) do
            if ball:IsA("BasePart") and string.find(ball.Name, "Ball") and ball:GetAttribute("Target") == LocalPlayer.Name then
                if (LocalPlayer.Character.HumanoidRootPart.Position - ball.Position).Magnitude < 15 then
                    local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if rem and (rem:FindFirstChild("Parry") or rem:FindFirstChild("Swing")) then (rem:FindFirstChild("Parry") or rem:FindFirstChild("Swing")):FireServer() end
                end
            end
        end
    end
end)

-- Anti-AFK
Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Camera.CFrame); task.wait(1); game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Camera.CFrame) end)

print("Hub v3 Loaded Successfully!")
