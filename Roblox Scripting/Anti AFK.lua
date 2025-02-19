wait(0.5)
local ba = Instance.new("ScreenGui")
local ca = Instance.new("TextLabel")
local da = Instance.new("Frame")
local _b = Instance.new("TextLabel")
local ab = Instance.new("TextLabel")

ba.Parent = game.CoreGui
ba.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ca.Parent = ba
ca.Active = true
ca.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
ca.Draggable = true
ca.Position = UDim2.new(0.8, 0, 0.1, 0)  -- Ajusta a posição
ca.Size = UDim2.new(0, 250, 0, 40) -- Reduz tamanho
ca.Font = Enum.Font.SourceSansSemibold
ca.Text = "Anti Afk"
ca.TextColor3 = Color3.new(0, 1, 1)
ca.TextSize = 18  -- Texto menor

da.Parent = ca
da.BackgroundColor3 = Color3.new(0.196, 0.196, 0.196)
da.Position = UDim2.new(0, 0, 1, 0)
da.Size = UDim2.new(0, 250, 0, 80) -- Reduz tamanho

_b.Parent = da
_b.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
_b.Position = UDim2.new(0, 0, 0.75, 0)
_b.Size = UDim2.new(0, 250, 0, 20)
_b.Font = Enum.Font.Arial
_b.Text = "Discord: montovoni"
_b.TextColor3 = Color3.new(0, 1, 1)
_b.TextSize = 16  -- Texto menor

ab.Parent = da
ab.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
ab.Position = UDim2.new(0, 0, 0.15, 0)
ab.Size = UDim2.new(0, 250, 0, 30)
ab.Font = Enum.Font.ArialBold
ab.Text = "Status: Active"
ab.TextColor3 = Color3.new(0, 1, 1)
ab.TextSize = 16 -- Texto menor

local bb = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
    ab.Text = "Roblox kicked you but we didnt let them!"
    wait(2)
    ab.Text = "Status: Active"
end)
