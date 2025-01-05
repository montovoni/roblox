-- Acessar as pastas de vidros
local glassesFolder = game:GetService("Workspace").Glasses

-- Alterar a cor de todos os vidros errados para vermelho
for _, wrongGlass in pairs(glassesFolder.Wrong:GetChildren()) do
    if wrongGlass:IsA("Part") then
        wrongGlass.BrickColor = BrickColor.new("Bright red")
    end
end

-- Alterar a cor de todos os vidros corretos para verde
for _, correctGlass in pairs(glassesFolder.Correct:GetChildren()) do
    if correctGlass:IsA("Part") then
        correctGlass.BrickColor = BrickColor.new("Bright green")
    end
end
