-- Gui Setup
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "DoorsESP_GUI"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true

-- Minimize Button
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -65, 0, 5)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)

-- Hidden Cube
local cube = Instance.new("TextButton", gui)
cube.Size = UDim2.new(0, 50, 0, 50)
cube.Position = UDim2.new(0.5, 0, 0.5, 0)
cube.Text = "📦"
cube.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
cube.Visible = false
cube.Draggable = true
cube.Active = true

-- Minimize logic
minBtn.MouseButton1Click:Connect(function()
	for _, v in pairs(frame:GetChildren()) do
		if v:IsA("TextButton") and v ~= minBtn and v ~= closeBtn then
			v.Visible = not v.Visible
		end
	end
end)

-- Close into cube
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	cube.Visible = true
end)

-- Reopen from cube
cube.MouseButton1Click:Connect(function()
	frame.Visible = true
	cube.Visible = false
end)

-- ESP Function
local function createESP(target, color)
	local esp = Instance.new("BoxHandleAdornment")
	esp.Adornee = target
	esp.AlwaysOnTop = true
	esp.ZIndex = 5
	esp.Size = target:GetExtentsSize()
	esp.Transparency = 0.5
	esp.Color3 = color
	esp.Parent = target
end

-- Start ESP
for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("Model") then
		if obj.Name == "KeyObtain" then
			createESP(obj, Color3.fromRGB(255, 255, 0)) -- Yellow for keys
		elseif obj.Name:lower():find("door") then
			createESP(obj, Color3.fromRGB(0, 255, 255)) -- Cyan for doors
		elseif obj.Name:lower():find("lever") or obj.Name:lower():find("crank") then
			createESP(obj, Color3.fromRGB(255, 125, 0)) -- Orange for levers
		elseif obj.Name:lower():find("seek") or obj.Name:lower():find("screech") then
			createESP(obj, Color3.fromRGB(255, 0, 0)) -- Red for mobs
		end
	end
end
