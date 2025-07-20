--[[
📜 Doors ESP GUI by ChatGPT
Run this in Delta or any Lua executor
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0, 20, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0

-- Function to create buttons
local function createButton(text, yOffset, callback)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, yOffset)
    Button.Text = text
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.MouseButton1Click:Connect(callback)
end

-- Highlight function
local function highlightObject(obj, color)
    if obj:IsA("BasePart") and not obj:FindFirstChild("ESPHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "ESPHighlight"
        hl.FillColor = color
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.FillTransparency = 0.5
        hl.Parent = obj
        hl.Adornee = obj
    end
end

-- Scan functions
local function scanForKeyword(keyword, color)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find(keyword) then
            highlightObject(obj, color)
        elseif obj:IsA("Model") and obj.Name:lower():find(keyword) then
            for _, part in pairs(obj:GetDescendants()) do
                highlightObject(part, color)
            end
        end
    end
end

-- ESP Toggles
createButton("🟩 ESP Doors", 0, function()
    scanForKeyword("door", Color3.fromRGB(0, 255, 0))
end)

createButton("🟨 ESP Keys", 45, function()
    scanForKeyword("key", Color3.fromRGB(255, 255, 0))
end)

createButton("🟪 ESP Levers", 90, function()
    scanForKeyword("lever", Color3.fromRGB(170, 0, 255))
end)

createButton("🟦 ESP Closets", 135, function()
    scanForKeyword("wardrobe", Color3.fromRGB(0, 150, 255))
end)

createButton("🔴 ESP Entities", 180, function()
    local entityNames = {"rush", "ambush", "screech", "seek", "figure"}
    for _, name in ipairs(entityNames) do
        scanForKeyword(name, Color3.fromRGB(255, 0, 0))
    end
end)

createButton("❌ Clear ESP", 225, function()
    for _, obj in pairs(workspace:GetDescendants()) do
        local esp = obj:FindFirstChild("ESPHighlight")
        if esp then
            esp:Destroy()
        end
    end
end)
