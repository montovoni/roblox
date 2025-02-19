--1. Coletar Todas Automaticamente
local emeralds = workspace.Secured.EmeraldPickups:GetChildren()
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InventoryService:CollectEmeraldEvent")

for _, emerald in ipairs(emeralds) do
    local emeraldId = emerald:GetAttribute("ID") or _
    remote:FireServer(emeraldId)
end


-- 2. Teleportar o Player para Cada Esmeralda

-- local player = game.Players.LocalPlayer
-- local character = player.Character or player.CharacterAdded:Wait()
-- local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InventoryService:CollectEmeraldEvent")
-- local emeralds = workspace.Secured.EmeraldPickups:GetChildren()

-- for _, emerald in ipairs(emeralds) do
--     local position = emerald.Position
--     character:SetPrimaryPartCFrame(CFrame.new(position)) -- Move o personagem
--     task.wait(0.5) -- Espera para garantir que a posição seja atualizada no servidor
--     remote:FireServer(emerald:GetAttribute("ID") or _)
-- end
