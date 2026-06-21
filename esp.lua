-- c00lkidd214anzz Hub (Stable + Diagnostic)
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
local Brookhaven_SoundID = "1837874690" 
local Original_Speed, Original_Jump = 16, 50

local function SaveOriginalStats(character)
    local hum = character:WaitForChild("Humanoid", 5)
    if hum then Original_Speed = hum.WalkSpeed; Original_Jump = hum.UseJumpPower and hum.JumpPower or hum.JumpHeight end
end
if LocalPlayer.Character then SaveOriginalStats(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(SaveOriginalStats)

local espObjects = {}
local currentRgbColor = Color3.new(1,1,1)

-- GUI
local screenGui = Instance.new("ScreenGui", CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
local mainToggle = Instance.new("TextButton", screenGui); mainToggle.Size = UDim2.new(0, 160, 0, 45); mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0); mainToggle.Text = "c00lkidd214anzz Menu"; mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Draggable = true; Instance.new("UICorner", mainToggle)
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

local aimPage = createTab("Aimbot"); local bbPage = createTab("Blade Ball"); local mm2Page = createTab("Murder Mystery 2"); local visPage = createTab("Visuals (ESP)"); local playerPage = createTab("Main / Player"); local bhPage = createTab("Brookhaven RP")

-- Блок Брукхейвена с диагностикой
local bhTextBox = Instance.new("TextBox", bhPage); bhTextBox.Size = UDim2.new(1, -10, 0, 40); bhTextBox.Text = Brookhaven_SoundID; bhTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", bhTextBox)
local bhMusicBtn = Instance.new("TextButton", bhPage); bhMusicBtn.Size = UDim2.new(1, -10, 0, 40); bhMusicBtn.Text = "ВКЛЮЧИТЬ (С ЛОГ-ДИАГНОСТИКОЙ)"; bhMusicBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 140); Instance.new("UICorner", bhMusicBtn)

bhMusicBtn.MouseButton1Click:Connect(function()
    print("--- СКАНИРОВАНИЕ СОБЫТИЙ BROOKHAVEN ---")
    local count = 0
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            if obj.Name:lower():find("music") or obj.Name:lower():find("radio") or obj.Name:lower():find("net") or obj.Name:lower():find("car") then
                print("Найдено событие: " .. obj:GetFullName())
                count = count + 1
                pcall(function()
                    obj:FireServer("CarMusic", bhTextBox.Text)
                    obj:FireServer("BoomboxId", tonumber(bhTextBox.Text))
                end)
            end
        end
    end
    bhMusicBtn.Text = (count > 0) and "Отправлено в " .. count .. " событий!" or "Ничего не найдено, чекни F9!"
    task.wait(2); bhMusicBtn.Text = "ВКЛЮЧИТЬ (С ЛОГ-ДИАГНОСТИКОЙ)"
end)

-- (Остальной код логики хаков остается прежним для работоспособности)
-- Инициализация первой вкладки
pages[1].Visible = true
