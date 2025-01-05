-- Referência para o Workspace e os vidros
local glassFolder = game:GetService("Workspace").Glass

-- Função para atualizar a cor dos vidros
local function updateGlassColors()
    -- Iterar sobre os vidros dentro do "Glass"
    for _, glass in pairs(glassFolder:GetChildren()) do
        -- Verificar se o vidro tem o BoolValue "Breaks"
        local breaks = glass:FindFirstChild("Breaks")
        if breaks and breaks:IsA("BoolValue") then
            -- Verificar o valor e alterar a cor do vidro
            if breaks.Value then
                -- Vidro correto (verde)
                if glass:IsA("BasePart") then
                    glass.BrickColor = BrickColor.new("Bright red")
                end
            else
                -- Vidro incorreto (vermelho)
                if glass:IsA("BasePart") then
                    glass.BrickColor = BrickColor.new("Bright green")
                end
            end
        end
    end
end

-- Atualizar as cores ao iniciar o jogo
updateGlassColors()

-- Escutar mudanças no valor de "Breaks" para atualizar as cores em tempo real
for _, glass in pairs(glassFolder:GetChildren()) do
    local breaks = glass:FindFirstChild("Breaks")
    if breaks and breaks:IsA("BoolValue") then
        breaks:GetPropertyChangedSignal("Value"):Connect(updateGlassColors)
    end
end
