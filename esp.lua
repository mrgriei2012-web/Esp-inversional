-- c00lkidd214anzz Hub (Ultimate Two-Panel Edition 2026 - Brookhaven Fixed)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки функций
local ESP_Enabled, Show_Names, Show_Dist, Chams_Enabled, RGB_Chams, Hitbox_Enabled, Noclip_Enabled, Flying, SpinBot_Enabled = false, true, true, false, false, false, false, false, false
local InfJump_Enabled, Aimbot_Enabled, AutoParry_Enabled, MM2_Revealer = false, false, false, false
local Tracer_Mode, Tracer_Color_Mode = "Bottom", "Team"
local Cheat_Speed, Cheat_Jump, Hitbox_Size, FlySpeed = 50, 120, 5, 50
local Original_Speed, Original_Jump = 16, 50

local function SaveOriginalStats(character)
    local hum = character:WaitForChild("Humanoid", 5)
    if hum then Original_Speed = hum.WalkSpeed; Original_Jump = hum.UseJumpPower and hum.JumpPower or hum.JumpHeight end
end
if LocalPlayer.Character then SaveOriginalStats(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(SaveOriginalStats)

local espObjects = {}
local currentRgbColor = Color3.new(1,1,1)

-- GUI и Интерфейс
local screenGui = Instance.new("ScreenGui", CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local mainToggle = Instance.new("TextButton", screenGui); mainToggle.Size = UDim2.new(0, 160, 0, 45); mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0); mainToggle.Text = "c00lkidd214anzz Menu"; mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Draggable = true; mainToggle.Active = true; Instance.new("UICorner", mainToggle)
local mainFrame = Instance.new("Frame", screenGui); mainFrame.Size = UDim2.new(0, 550, 0, 320); mainFrame.Position = UDim2.new(0.5, -275, 0.5, -160); mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.Visible = false; mainFrame.Draggable = true; Instance.new("UICorner", mainFrame)
mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

local sidebar = Instance.new("Frame", mainFrame); sidebar.Size = UDim2.new(0, 150, 1, -20); sidebar.Position = UDim2.new(0, 10, 0, 10); sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", sidebar)
local sideScroll = Instance.new("ScrollingFrame", sidebar); sideScroll.Size = UDim2.new(1, -10, 1, -10); sideScroll.Position = UDim2.new(0, 5, 0, 5); sideScroll.BackgroundTransparency = 1; sideScroll.CanvasSize = UDim2.new(0,0,0,400); Instance.new("UIListLayout", sideScroll).Padding = UDim.new(0, 5)

local contentContainer = Instance.new("Frame", mainFrame); contentContainer.Size = UDim2.new(1, -180, 1, -20); contentContainer.Position = UDim2.new(0, 170, 0, 10); contentContainer.BackgroundTransparency = 1
local pages = {}

local function createTab(name)
    local pageScroll = Instance.new("ScrollingFrame", contentContainer); pageScroll.Size = UDim2.new(1, 0, 1, 0); pageScroll.BackgroundTransparency = 1; pageScroll.Visible = false; pageScroll.CanvasSize = UDim2.new(0, 0, 0, 500); Instance.new("UIListLayout", pageScroll).Padding = UDim.new(0, 6)
    local tabBtn = Instance.new("TextButton", sideScroll); tabBtn.Size = UDim2.new(1, 0, 0, 35); tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); tabBtn.Text = name; tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180); Instance.new("UICorner", tabBtn)
    tabBtn.MouseButton1Click:Connect(function() for _, p in pairs(pages) do p.Visible = false end; pageScroll.Visible = true end)
    table.insert(pages, pageScroll); return pageScroll
end

local function addFeature(parentPage, text, defaultState, callback)
    local Btn = Instance.new("TextButton", parentPage); Btn.Size = UDim2.new(1, -10, 0, 36); Btn.BackgroundColor3 = defaultState and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40); Btn.Text = text; Btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Btn)
    local enabled = defaultState; Btn.MouseButton1Click:Connect(function() enabled = not enabled; Btn.BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40); callback(enabled) end)
end

-- Вкладки
local aimPage = createTab("Aimbot"); addFeature(aimPage, "Aimbot", Aimbot_Enabled, function(v) Aimbot_Enabled = v end)
local bbPage = createTab("Blade Ball"); addFeature(bbPage, "Auto Parry", AutoParry_Enabled, function(v) AutoParry_Enabled = v end)
local mm2Page = createTab("Murder Mystery 2"); addFeature(mm2Page, "MM2 Revealer", MM2_Revealer, function(v) MM2_Revealer = v end)
local visPage = createTab("Visuals (ESP)"); addFeature(visPage, "ESP Boxes", ESP_Enabled, function(v) ESP_Enabled = v end)
local playerPage = createTab("Main / Player"); addFeature(playerPage, "Fly", Flying, function(v) Flying = v end)

-- ИСПРАВЛЕННЫЙ BROOKHAVEN RP
local bhPage = createTab("Brookhaven RP")
local bhTextBox = Instance.new("TextBox", bhPage); bhTextBox.Size = UDim2.new(1, -10, 0, 40); bhTextBox.Text = "1837874690"; bhTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", bhTextBox)
local bhMusicBtn = Instance.new("TextButton", bhPage); bhMusicBtn.Size = UDim2.new(1, -10, 0, 40); bhMusicBtn.Text = "ВКЛЮЧИТЬ МУЗЫКУ"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 140); Instance.new("UICorner", bhMusicBtn)

bhMusicBtn.MouseButton1Click:Connect(function()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("ClientMusic")
    if remote then
        pcall(function() remote:FireServer("Play", bhTextBox.Text) end)
        bhMusicBtn.Text = "Команда отправлена!"
    else
        bhMusicBtn.Text = "Ошибка пути!"
    end
    task.wait(2); bhMusicBtn.Text = "ВКЛЮЧИТЬ МУЗЫКУ"
end)

-- (Тут ниже весь твой цикл RenderStepped и логика ESP остаются как были в исходнике)
pages[1].Visible = true
print("c00lkidd214anzz Hub - Full Version Loaded!")
