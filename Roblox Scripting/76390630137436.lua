local bridge = workspace.Main.Bridge

-- Função para mudar a cor do vidro
local function updateGlassColor(platform)
    local glass = platform:FindFirstChild("Glass")
    if glass and glass:FindFirstChild("RagdollTrigger") then
        local isEnabled = glass.RagdollTrigger.Enabled
        if isEnabled then
            glass.BrickColor = BrickColor.new(255, 0, 0) -- Vermelho mais forte (RGB)
        elseif not isEnabled then
            glass.BrickColor = BrickColor.new("Bright green") -- Verde para os vidros que não quebram
        else
            glass.BrickColor = BrickColor.new(0, 255, 0) -- Verde bem forte (RGB)
        end
    end
end

-- Percorre todas as plataformas
for _, platform in ipairs(bridge:GetChildren()) do
    if platform:IsA("Model") then
        updateGlassColor(platform)
    end
end
