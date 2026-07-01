-- AimbotModule.lua
local AimbotModule = {}
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Функция проверки препятствий
local function isVisible(targetPart)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(Camera.CFrame.Position, targetPart.Position - Camera.CFrame.Position, params)
    return not result or result.Instance:IsDescendantOf(targetPart.Parent)
end

function AimbotModule.Process(isEnabled, WallCheck, TeamCheck)
    if not isEnabled then return end
    
    local closest, maxDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            -- Проверка команды
            local isEnemy = (not TeamCheck) or (p.Team ~= LocalPlayer.Team)
            
            if isEnemy then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    -- Если WallCheck включен, проверяем видимость
                    if (not WallCheck) or isVisible(head) then
                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                            if dist < maxDist then
                                maxDist = dist
                                closest = head
                            end
                        end
                    end
                end
            end
        end
    end
    
    if closest then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
    end
end

return AimbotModule