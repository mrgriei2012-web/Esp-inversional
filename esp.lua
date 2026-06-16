-- c00lkidd214anzz Hub (Classic Black UI Edition - NO GRADIENTS)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- РќР°СЃС‚СЂРѕР№РєРё С„СѓРЅРєС†РёР№
local ESP_Enabled = true
local Tracer_Mode = "Bottom" -- "Bottom", "Center", "Top"
local Custom_Speed = 16
local Custom_Jump = 50
local espObjects = {}

-- 1. Р’Р°С‚РµСЂРјР°СЂРє
local watermark = Drawing.new("Text")
watermark.Text = "c00lkidd214anzz Hub"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Outline = true
watermark.Position = Vector2.new(10, 30)
watermark.Visible = true
watermark.Font = 2

-- 2. РЎРѕР·РґР°РЅРёРµ UI
local screenGui = Instance.new("ScreenGui", game.CoreGui or LocalPlayer:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Р“Р»Р°РІРЅР°СЏ РїРµСЂРµС‚Р°СЃРєРёРІР°РµРјР°СЏ РєРЅРѕРїРєР°-РѕС‚РєСЂС‹РІР°С€РєР° (РЎС‚СЂРѕРіРёР№ С‚РµРјРЅС‹Р№ СЃС‚РёР»СЊ)
local mainToggle = Instance.new("TextButton", screenGui)
mainToggle.Size = UDim2.new(0, 160, 0, 45)
mainToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
mainToggle.Text = "c00lkidd214anzz Menu"
mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Р§РёСЃС‚С‹Р№ С‚РµРјРЅРѕ-СЃРµСЂС‹Р№
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.TextSize = 15
mainToggle.Draggable = true
mainToggle.Active = true
Instance.new("UICorner", mainToggle)

-- РћР±РІРѕРґРєР° РєРЅРѕРїРєРё РґР»СЏ РєСЂР°СЃРѕС‚С‹
local toggleStroke = Instance.new("UIStroke", mainToggle)
toggleStroke.Color = Color3.fromRGB(60, 60, 60)
toggleStroke.Thickness = 1

-- === Р‘РћР›Р¬РЁРћР• РћРЎРќРћР’РќРћР• РњР•РќР® ===
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 55)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Р“Р»СѓР±РѕРєРёР№ С‡РµСЂРЅС‹Р№ С„РѕРЅ Р±РµР· РіСЂР°РґРёРµРЅС‚РѕРІ
mainFrame.Visible = false
Instance.new("UICorner", mainFrame)

local menuStroke = Instance.new("UIStroke", mainFrame)
menuStroke.Color = Color3.fromRGB(50, 50, 50)
menuStroke.Thickness = 1

-- Р›РµРІР°СЏ РїР°РЅРµР»СЊ РґР»СЏ РІРєР»Р°РґРѕРє (РЎР°Р№РґР±Р°СЂ)
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Р’С‹РґРµР»СЏСЋС‰РёР№СЃСЏ С‚РµРјРЅС‹Р№ СЃР°Р№РґР±Р°СЂ
local uiCornerSidebar = Instance.new("UICorner", sidebar)

-- РљРѕРЅС‚РµР№РЅРµСЂС‹ РґР»СЏ СЃРѕРґРµСЂР¶РёРјРѕРіРѕ РІРєР»Р°РґРѕРє
local visualsPage = Instance.new("Frame", mainFrame)
visualsPage.Size = UDim2.new(0, 300, 1, 0)
visualsPage.Position = UDim2.new(0, 140, 0, 0)
visualsPage.BackgroundTransparency = 1
visualsPage.Visible = true

local playerPage = Instance.new("Frame", mainFrame)
playerPage.Size = UDim2.new(0, 300, 1, 0)
playerPage.Position = UDim2.new(0, 140, 0, 0)
playerPage.BackgroundTransparency = 1
playerPage.Visible = false

-- Р¤СѓРЅРєС†РёСЏ РїРµСЂРµРєР»СЋС‡РµРЅРёСЏ СЃС‚СЂР°РЅРёС†
local function showPage(page)
    visualsPage.Visible = (page == visualsPage)
    playerPage.Visible = (page == playerPage)
end

-- === РљРќРћРџРљР Р’РљР›РђР”РћРљ Р’ РЎРР”Р‘РђР Р• ===
local tabVisuals = Instance.new("TextButton", sidebar)
tabVisuals.Size = UDim2.new(0, 110, 0, 35)
tabVisuals.Position = UDim2.new(0, 10, 0, 20)
tabVisuals.Text = "Visuals (ESP)"
tabVisuals.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabVisuals.TextColor3 = Color3.fromRGB(255, 255, 255)
tabVisuals.Font = Enum.Font.SourceSansBold
tabVisuals.TextSize = 14
Instance.new("UICorner", tabVisuals)
tabVisuals.MouseButton1Click:Connect(function() showPage(visualsPage) end)

local tabPlayer = Instance.new("TextButton", sidebar)
tabPlayer.Size = UDim2.new(0, 110, 0, 35)
tabPlayer.Position = UDim2.new(0, 10, 0, 65)
tabPlayer.Text = "Player (РљР°СЃС‚РѕРј)"
tabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
tabPlayer.Font = Enum.Font.SourceSansBold
tabPlayer.TextSize = 14
Instance.new("UICorner", tabPlayer)
tabPlayer.MouseButton1Click:Connect(function() showPage(playerPage) end)

-- === РљРћРќРўР•РќРў Р’РљР›РђР”РљР VISUALS ===
local espToggleBtn = Instance.new("TextButton", visualsPage)
espToggleBtn.Size = UDim2.new(0, 280, 0, 45) -- РќРµРјРЅРѕРіРѕ СЂР°СЃС€РёСЂРёР» РґР»СЏ РјРѕР±РёР»СЊРЅРѕРіРѕ СЌРєСЂР°РЅР°
espToggleBtn.Position = UDim2.new(0, 10, 0, 20)
espToggleBtn.Text = "ESP: ON"
espToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
espToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggleBtn.Font = Enum.Font.SourceSansBold
espToggleBtn.TextSize = 14
Instance.new("UICorner", espToggleBtn)

espToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    espToggleBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    espToggleBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    if not ESP_Enabled then
        for _, obj in pairs(espObjects) do 
            obj.Box.Visible = false 
            obj.Tracer.Visible = false 
        end
    end
end)

local tracerLabel = Instance.new("TextLabel", visualsPage)
tracerLabel.Size = UDim2.new(0, 280, 0, 20)
tracerLabel.Position = UDim2.new(0, 10, 0, 85)
tracerLabel.Text = "РџРѕР»РѕР¶РµРЅРёРµ Р»РёРЅРёР№ С‚СЂРµР№СЃРµСЂРѕРІ:"
tracerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
tracerLabel.BackgroundTransparency = 1
tracerLabel.Font = Enum.Font.SourceSans
tracerLabel.TextSize = 14
tracerLabel.TextXAlignment = Enum.TextXAlignment.Left

local tracerModeBtn = Instance.new("TextButton", visualsPage)
tracerModeBtn.Size = UDim2.new(0, 280, 0, 45)
tracerModeBtn.Position = UDim2.new(0, 10, 0, 110)
tracerModeBtn.Text = "РќРР— Р­РљР РђРќРђ"
tracerModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tracerModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerModeBtn.Font = Enum.Font.SourceSansBold
tracerModeBtn.TextSize = 14
Instance.new("UICorner", tracerModeBtn)

tracerModeBtn.MouseButton1Click:Connect(function()
    if Tracer_Mode == "Bottom" then
        Tracer_Mode = "Center"
        tracerModeBtn.Text = "Р¦Р•РќРўР  Р­РљР РђРќРђ"
    elseif Tracer_Mode == "Center" then
        Tracer_Mode = "Top"
        tracerModeBtn.Text = "Р’Р’Р•Р РҐ Р­РљР РђРќРђ"
    else
        Tracer_Mode = "Bottom"
        tracerModeBtn.Text = "РќРР— Р­РљР РђРќРђ"
    end
end)

-- === РљРћРќРўР•РќРў Р’РљР›РђР”РљР PLAYER ===
local speedBtn = Instance.new("TextButton", playerPage)
speedBtn.Size = UDim2.new(0, 280, 0, 45)
speedBtn.Position = UDim2.new(0, 10, 0, 20)
speedBtn.Text = "Р‘С‹СЃС‚СЂС‹Р№ Р±РµРі: Р’С‹РєР» (16)"
speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    if Custom_Speed == 16 then
        Custom_Speed = 50
        speedBtn.Text = "Р‘С‹СЃС‚СЂС‹Р№ Р±РµРі: Р’РєР» (50)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        Custom_Speed = 16
        speedBtn.Text = "Р‘С‹СЃС‚СЂС‹Р№ Р±РµРі: Р’С‹РєР» (16)"
        speedBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

local jumpBtn = Instance.new("TextButton", playerPage)
jumpBtn.Size = UDim2.new(0, 280, 0, 45)
jumpBtn.Position = UDim2.new(0, 10, 0, 80)
jumpBtn.Text = "Р’С‹СЃРѕРєРёР№ РїСЂС‹Р¶РѕРє: Р’С‹РєР»"
jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.TextSize = 14
Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    if Custom_Jump == 50 then
        Custom_Jump = 120
        jumpBtn.Text = "Р’С‹СЃРѕРєРёР№ РїСЂС‹Р¶РѕРє: Р’РєР» (120)"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        Custom_Jump = 50
        jumpBtn.Text = "Р’С‹СЃРѕРєРёР№ РїСЂС‹Р¶РѕРє: Р’С‹РєР»"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

local Hitbox_Enabled = false
local Hitbox_Size = 5 -- Р Р°Р·РјРµСЂ С…РёС‚Р±РѕРєСЃР° (РЅР°СЃРєРѕР»СЊРєРѕ Р»РµРіРєРѕ РїРѕРїР°СЃС‚СЊ)

local hitBtn = Instance.new("TextButton", playerPage)
hitBtn.Size = UDim2.new(0, 250, 0, 45)
hitBtn.Position = UDim2.new(0, 15, 0, 130) -- Р Р°СЃРїРѕР»РѕР¶РёР» РЅРёР¶Рµ РєРЅРѕРїРєРё РїСЂС‹Р¶РєР°
hitBtn.Text = "Hitbox: OFF"
hitBtn.TextColor3 = Color3.new(1,1,1)
hitBtn.Font = Enum.Font.SourceSansBold
hitBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
hitBtn.ZIndex = 7
Instance.new("UICorner", hitBtn)

hitBtn.MouseButton1Click:Connect(function()
    Hitbox_Enabled = not Hitbox_Enabled
    hitBtn.Text = Hitbox_Enabled and "Hitbox: ON" or "Hitbox: OFF"
    hitBtn.BackgroundColor3 = Hitbox_Enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40,40,40)
end)

-- Р›РѕРіРёРєР° СЂР°СЃС€РёСЂРµРЅРёСЏ С…РёС‚Р±РѕРєСЃРѕРІ (РґРѕР±Р°РІСЊ РІ СЃРІРѕР№ РіР»Р°РІРЅС‹Р№ С†РёРєР» RenderStepped)
RunService.RenderStepped:Connect(function()
    if Hitbox_Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                -- РЈРІРµР»РёС‡РёРІР°РµРј СЂР°Р·РјРµСЂ (Transparency СЃРґРµР»Р°РЅ 0.5, С‡С‚РѕР±С‹ РІРёРґРµС‚СЊ, РЅР° С‡С‚Рѕ С‚С‹ С†РµР»РёС€СЊСЃСЏ)
                hrp.Size = Vector3.new(Hitbox_Size, Hitbox_Size, Hitbox_Size)
                hrp.Transparency = 0.5
                hrp.BrickColor = BrickColor.new("Really red")
                hrp.CanCollide = false
            end
        end
    else
        -- Р’РѕР·РІСЂР°С‰Р°РµРј СЃС‚Р°РЅРґР°СЂС‚РЅС‹Р№ СЂР°Р·РјРµСЂ (2, 2, 1), РµСЃР»Рё РІС‹РєР»СЋС‡РёР»Рё
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                p.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end)
-- === Р›РћР“РРљРђ Р”Р’РР–Р•РќРРЇ Р РћРўРљР Р«РўРРЇ РњР•РќР® ===
mainToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
end)

mainToggle.Changed:Connect(function(prop)
    if prop == "Position" then
        mainFrame.Position = UDim2.new(0, mainToggle.AbsolutePosition.X, 0, mainToggle.AbsolutePosition.Y + 55)
    end
end)

-- === РњР•РҐРђРќРРљРђ Р РЇР”Р Рћ ESP ===
local function createESPItems()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Filled = false
    box.Thickness = 2

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5

    return {Box = box, Tracer = tracer}
end

local function removeESPItems(player)
    if espObjects[player] then
        espObjects[player].Box:Remove()
        espObjects[player].Tracer:Remove()
        espObjects[player] = nil
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then espObjects[player] = createESPItems() end
end

Players.PlayerAdded:Connect(function(player)
    espObjects[player] = createESPItems()
end)

Players.PlayerRemoving:Connect(function(player)
    removeESPItems(player)
end)

-- === Р¦РРљР› РћР‘РќРћР’Р›Р•РќРРЇ РљРђР”Р РћР’ ===
RunService.RenderStepped:Connect(function()
    watermark.Visible = true 
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.WalkSpeed = Custom_Speed
        if hum.UseJumpPower then
            hum.JumpPower = Custom_Jump
        else
            hum.JumpHeight = Custom_Jump / 3
        end
    end

    if not ESP_Enabled then return end

    local startPoint
    if Tracer_Mode == "Bottom" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    elseif Tracer_Mode == "Center" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    elseif Tracer_Mode == "Top" then
        startPoint = Vector2.new(Camera.ViewportSize.X / 2, 0)
    end

    for player, obj in pairs(espObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            
            local rootPart = character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            local displayColor = Color3.fromRGB(255, 255, 255)
            if player.Team then
                displayColor = player.TeamColor.Color
            end

            obj.Box.Color = displayColor
            obj.Tracer.Color = displayColor

            if onScreen then
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / dist
                
                obj.Box.Size = Vector2.new(scale * 1.5, scale * 2.5)
                obj.Box.Position = Vector2.new(vector.X - obj.Box.Size.X / 2, vector.Y - obj.Box.Size.Y / 2)
                obj.Box.Visible = true

                obj.Tracer.From = startPoint
                obj.Tracer.To = Vector2.new(vector.X, vector.Y + (obj.Box.Size.Y / 2))
                obj.Tracer.Visible = true
            else
                obj.Box.Visible = false
                obj.Tracer.Visible = false
            end
        else
            obj.Box.Visible = false
            obj.Tracer.Visible = false
        end
    end
end)

print("c00lkidd214anzz Classic Dark Hub Loaded!")
