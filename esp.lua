-- c00lkidd214anzz Hub (Classic Mode)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_Enabled = false
local Custom_Speed = 16
local espObjects = {}

-- UI
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))

local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 100, 0, 40)
mainToggle.Position = UDim2.new(0, 10, 0, 10)
mainToggle.Text = "MENU"
mainToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Draggable = true
mainToggle.Active = true

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true

mainToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- Кнопки
local espBtn = Instance.new("TextButton", mainFrame)
espBtn.Size = UDim2.new(0, 260, 0, 50)
espBtn.Position = UDim2.new(0, 20, 0, 30)
espBtn.Text = "ESP: OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
end)

local spdBtn = Instance.new("TextButton", mainFrame)
spdBtn.Size = UDim2.new(0, 260, 0, 50)
spdBtn.Position = UDim2.new(0, 20, 0, 100)
spdBtn.Text = "SPEED: 16"
spdBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
spdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spdBtn.MouseButton1Click:Connect(function()
    Custom_Speed = (Custom_Speed == 16) and 50 or 16
    spdBtn.Text = "SPEED: " .. Custom_Speed
end)

-- Логика
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Custom_Speed
    end
end)
