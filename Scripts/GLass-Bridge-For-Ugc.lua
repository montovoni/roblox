-- Espera até que o jogo esteja carregado e o jogador local esteja pronto
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

-------------------------------------------------------------------------------

-- Verifica se o script já foi executado antes para evitar duplicação
if getgenv().GuiExecuted then 
    -- Se a GUI foi criada anteriormente, destrua-a
    if game.CoreGui:FindFirstChild("thisoneissocoldww") then
        game.CoreGui.thisoneissocoldww:Destroy()
    end
    getgenv().GuiExecuted = false  -- Marca que a execução foi cancelada 
end

-- Marca o script como executado
getgenv().GuiExecuted = true

-------------------------------------------------------------------------------

-- Cria a interface gráfica (GUI)
local thisoneissocoldww = Instance.new("ScreenGui")
local madebybloodofbatus = Instance.new("Frame")
local UICornerw = Instance.new("UICorner")
local uselesslabelone = Instance.new("TextLabel")
local expandButton = Instance.new("TextButton") -- Botão para expandir
local creditsLabel = Instance.new("TextLabel") -- Label para os créditos
local UICornerww = Instance.new("UICorner")

-- Configurações da GUI
thisoneissocoldww.Name = "thisoneissocoldww"
thisoneissocoldww.Parent = game.CoreGui
thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

madebybloodofbatus.Name = "madebybloodofbatus"
madebybloodofbatus.Parent = thisoneissocoldww
madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
madebybloodofbatus.Position = UDim2.new(0.0854133144, 0, 0.13128835, 0)
madebybloodofbatus.Size = UDim2.new(0, 230, 0, 25) -- Tamanho inicial da GUI

UICornerw.Parent = madebybloodofbatus
UICornerw.CornerRadius = UDim.new(0, 5)

-------------------------------------------------------------------------------

-- Labels
uselesslabelone.Name = "uselesslabelone"
uselesslabelone.Parent = madebybloodofbatus
uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.BackgroundTransparency = 1.000
uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
uselesslabelone.Font = Enum.Font.SourceSans
uselesslabelone.Text = "GLASS BRIDGE"
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 16
uselesslabelone.TextXAlignment = Enum.TextXAlignment.Center
uselesslabelone.Position = UDim2.new(0.5, -uselesslabelone.Size.X.Offset / 2, 0, 0)
uselesslabelone.Font = Enum.Font.ArialBold

-------------------------------------------------------------------------------

-- Botão expandir
expandButton.Name = "expandButton"
expandButton.Parent = madebybloodofbatus
expandButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
expandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
expandButton.Text = "+"
expandButton.Size = UDim2.new(0, 25, 0, 25)
expandButton.Position = UDim2.new(1, -25, 0, 0)
expandButton.Font = Enum.Font.ArialBold
expandButton.TextSize = 16
expandButton.ZIndex = 2

UICornerww.Parent = expandButton

-------------------------------------------------------------------------------

-- Label para créditos (inicialmente escondida)
creditsLabel.Name = "creditsLabel"
creditsLabel.Parent = madebybloodofbatus
creditsLabel.Text = "Discord: montovoni"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Size = UDim2.new(0, 200, 0, 20)
creditsLabel.AnchorPoint = Vector2.new(0.5, 1)
creditsLabel.Position = UDim2.new(0.5, 0, 1, -5)
creditsLabel.Font = Enum.Font.ArialBold
creditsLabel.TextSize = 16
creditsLabel.Visible = false

-------------------------------------------------------------------------------

local isCheckedGlass = false
local originalColors = {}

-- Criando um contêiner para os botões adicionais
local extraButtonsContainer = Instance.new("Frame")
extraButtonsContainer.Name = "extraButtonsContainer"
extraButtonsContainer.Parent = madebybloodofbatus
extraButtonsContainer.BackgroundTransparency = 1
extraButtonsContainer.Size = UDim2.new(1, -10, 0, 60)
extraButtonsContainer.Position = UDim2.new(0, 5, 0, uselesslabelone.Size.Y.Offset + 10)
extraButtonsContainer.Visible = false

-- Criação do container para o CheckboxGlass
local checkboxContainer = Instance.new("Frame")
checkboxContainer.Name = "CheckboxContainer"
checkboxContainer.Parent = extraButtonsContainer
checkboxContainer.BackgroundTransparency = 1
checkboxContainer.Size = UDim2.new(1, -10, 0, 20)
checkboxContainer.Position = UDim2.new(0, 5, 0, 0)

-- Função para mudar a cor do vidro
local function updateGlassColor(glass, isChecked)
    local ragdollTrigger = glass:FindFirstChild("RagdollTrigger")
    if ragdollTrigger then
        if isChecked then
            if not originalColors[glass] then
                originalColors[glass] = glass.Color -- Armazena a cor original
            end
            if ragdollTrigger.Enabled then
                glass.Color = Color3.fromRGB(255, 0, 0) -- Vermelho se inválido
            else
                glass.Color = Color3.fromRGB(0, 255, 0) -- Verde se válido
            end
        else
            -- Restaura a cor original
            if originalColors[glass] then
                glass.Color = originalColors[glass]
            end
        end
    end
end

-- Função para aplicar a lógica de colorir os vidros
local function updateAllGlassColors(isChecked)
    for _, glassGroup in ipairs(workspace.Bridge:GetChildren()) do
        if glassGroup.Name == "GlassGroup" then
            for _, glass in ipairs(glassGroup:GetChildren()) do
                if glass:IsA("Part") and glass.Name == "Glass" then
                    updateGlassColor(glass, isChecked)
                end
            end
        end
    end
end

-- Criação do CheckboxGlassLabel
local CheckboxGlassLabel = Instance.new("TextLabel")
CheckboxGlassLabel.Name = "CheckboxGlassLabel"
CheckboxGlassLabel.Parent = checkboxContainer
CheckboxGlassLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxGlassLabel.BackgroundTransparency = 1
CheckboxGlassLabel.TextXAlignment = Enum.TextXAlignment.Left
CheckboxGlassLabel.Font = Enum.Font.ArialBold
CheckboxGlassLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxGlassLabel.TextSize = 16
CheckboxGlassLabel.Size = UDim2.new(0, 100, 0, 20)
CheckboxGlassLabel.Text = "Check windows"
CheckboxGlassLabel.Position = UDim2.new(0, 0, 0, 0)

-- Criação do CheckboxGlass
local CheckboxGlass = Instance.new("Frame")
CheckboxGlass.Name = "CheckboxGlass"
CheckboxGlass.Parent = checkboxContainer
CheckboxGlass.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxGlass.AnchorPoint = Vector2.new(1, 0)
CheckboxGlass.Position = UDim2.new(1, -5, 0, 0)
CheckboxGlass.Size = UDim2.new(0, 18, 0, 18)
CheckboxGlass.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Arredondando as pontas do CheckboxGlass
local UICornerCheckboxGlass = Instance.new("UICorner")
UICornerCheckboxGlass.Parent = CheckboxGlass
UICornerCheckboxGlass.CornerRadius = UDim.new(0, 3)

-- Criação do CheckboxGlassButton
local CheckboxGlassButton = Instance.new("TextButton")
CheckboxGlassButton.Name = "CheckboxGlassButton"
CheckboxGlassButton.Parent = CheckboxGlass
CheckboxGlassButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxGlassButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxGlassButton.Text = "✔️"

-- Arredondando o CheckboxGlassButton
local UICornerCheckboxGlassButton = Instance.new("UICorner")
UICornerCheckboxGlassButton.Parent = CheckboxGlassButton
UICornerCheckboxGlassButton.CornerRadius = UDim.new(0, 3)

-- Função para lidar com o clique no CheckboxGlass
CheckboxGlassButton.MouseButton1Click:Connect(function()
    isCheckedGlass = not isCheckedGlass -- Inverte o estado  

    if isCheckedGlass then
        CheckboxGlassButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
    else
        CheckboxGlassButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
    end

    -- Aplica a lógica de colorir os vidros
    updateAllGlassColors(isCheckedGlass)
end)

-------------------------------------------------------------------------------

-- Função para expandir/retrair a GUI
local expanded = false
expandButton.MouseButton1Click:Connect(function()
    expanded = not expanded

    if expanded then
        madebybloodofbatus.Size = UDim2.new(0, 230, 0, 90)
        creditsLabel.Visible = true
        expandButton.Text = "-"
        extraButtonsContainer.Visible = true
    else
        madebybloodofbatus.Size = UDim2.new(0, 230, 0, 25)
        creditsLabel.Visible = false
        expandButton.Text = "+"
        extraButtonsContainer.Visible = false
    end
end)

-------------------------------------------------------------------------------

-- Função para arrastar a GUI pela tela
local Drag = madebybloodofbatus
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    local dragTime = 0.04
    local SmoothDrag = {}
    SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    local dragSmoothFunction = game:GetService("TweenService"):Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
    dragSmoothFunction:Play()
end

Drag.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Drag.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Drag.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and Drag.Size then
        update(input)
    end
end)

-------------------------------------------------------------------------------