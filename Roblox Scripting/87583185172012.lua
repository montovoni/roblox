-- Variáveis principais
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local replicatedStorage = game:GetService("ReplicatedStorage")
local endPart = replicatedStorage:FindFirstChild("Storage") and replicatedStorage.Storage:FindFirstChild("Finish") and replicatedStorage.Storage.Finish:FindFirstChild("endPart")
local teleporting = false -- Controla o loop de teleporte

-- Função de teleporte
local function teleportCharacter()
    while teleporting do
        if endPart then
            humanoidRootPart.CFrame = CFrame.new(endPart.Position)
        end
        wait(4) -- Espera 4 segundos antes do próximo teleporte
    end
end

-- Criando a GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundTransparency = 0.1

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Discord: @montovoni"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0

local checkbox = Instance.new("TextButton")
checkbox.Parent = frame
checkbox.Size = UDim2.new(0, 40, 0, 40)
checkbox.Position = UDim2.new(0, 20, 0, 70)
checkbox.Text = "Off"
checkbox.Font = Enum.Font.GothamBold
checkbox.TextSize = 14
checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
checkbox.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local checkboxCorner = Instance.new("UICorner")
checkboxCorner.CornerRadius = UDim.new(0, 8)
checkboxCorner.Parent = checkbox

local checkboxLabel = Instance.new("TextLabel")
checkboxLabel.Parent = frame
checkboxLabel.Size = UDim2.new(0, 200, 0, 40)
checkboxLabel.Position = UDim2.new(0, 70, 0, 70)
checkboxLabel.Text = "Ativar teleporte"
checkboxLabel.Font = Enum.Font.Gotham
checkboxLabel.TextSize = 14
checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
checkboxLabel.BackgroundTransparency = 1

local closeButton = Instance.new("TextButton")
closeButton.Parent = frame
closeButton.Size = UDim2.new(0, 120, 0, 40)
closeButton.Position = UDim2.new(0.5, -60, 1, -50)
closeButton.Text = "Fechar"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Eventos
checkbox.MouseButton1Click:Connect(function()
    teleporting = not teleporting
    if teleporting then
        checkbox.Text = "On"
        checkbox.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        teleportCharacter()
    else
        checkbox.Text = "Off"
        checkbox.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
