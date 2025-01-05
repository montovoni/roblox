-- Obtenha o personagem do jogador
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Verifique se o personagem tem um modelo válido
if character and character:FindFirstChild("HumanoidRootPart") then
    -- Acesse a pasta de checkpoints
    local checkpoints = game:GetService("Workspace").Checkpoints:GetChildren()

    -- Ordena os checkpoints pelo nome (assumindo que estão numerados como "1", "2", "3", ...)
    table.sort(checkpoints, function(a, b)
        return tonumber(a.Name) < tonumber(b.Name)
    end)

    -- Função para teleportar o personagem para o próximo checkpoint
    local function teleportToCheckpoint(checkpoint)
        local checkpointPosition = checkpoint.Position
        local newPosition = Vector3.new(checkpointPosition.X, checkpointPosition.Y + 5, checkpointPosition.Z) -- Ajuste de altura (Y + 5)
        character.HumanoidRootPart.CFrame = CFrame.new(newPosition)
    end

    -- Percorre todos os checkpoints
    for _, checkpoint in ipairs(checkpoints) do
        -- Teleporta para o checkpoint
        teleportToCheckpoint(checkpoint)
        -- Espera um pouco antes de ir para o próximo checkpoint
        wait(1)  -- Ajuste o tempo de espera conforme necessário
    end
end
