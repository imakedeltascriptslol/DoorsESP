
--// GUI with Minimize and Cube Button + ESP for Doors, Keys, Entities //--
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "DoorsESP_GUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Active = true
Frame.Draggable = true
Frame.Name = "MainFrame"

-- Minimize Button
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0, 25, 0, 25)
Minimize.Position = UDim2.new(1, -55, 0, 0)
Minimize.Text = "-"
Minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Minimize.TextColor3 = Color3.new(1, 1, 1)

-- Close Button (turns into cube)
local Close = Instance.new("TextButton", Frame)
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Position = UDim2.new(1, -25, 0, 0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Close.TextColor3 = Color3.new(1, 1, 1)

-- Cube Button
local Cube = Instance.new("TextButton", ScreenGui)
Cube.Size = UDim2.new(0, 40, 0, 40)
Cube.Position = UDim2.new(0.05, 0, 0.6, 0)
Cube.BackgroundColor3 = Color3.new(0, 0, 0)
Cube.TextColor3 = Color3.new(1, 1, 1)
Cube.Text = "🔲"
Cube.Visible = false
Cube.Draggable = true

Minimize.MouseButton1Click:Connect(function()
	for _, obj in pairs(Frame:GetChildren()) do
		if obj ~= Minimize and obj ~= Close then
			obj.Visible = not obj.Visible
		end
	end
end)

Close.MouseButton1Click:Connect(function()
	Frame.Visible = false
	Cube.Visible = true
end)

Cube.MouseButton1Click:Connect(function()
	Frame.Visible = true
	Cube.Visible = false
end)

-- ESP Function
function CreateESP(obj, color, text)
	local box = Instance.new("BillboardGui", obj)
	box.Name = "ESP"
	box.Adornee = obj
	box.Size = UDim2.new(0, 100, 0, 40)
	box.AlwaysOnTop = true

	local label = Instance.new("TextLabel", box)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = color
	label.TextScaled = true
end

-- Add ESP to Items
function AddESP()
	for _, v in pairs(Workspace:GetDescendants()) do
		if v:IsA("Model") or v:IsA("Part") then
			if v:FindFirstChild("DoorPrompt") and not v:FindFirstChild("ESP") then
				CreateESP(v, Color3.fromRGB(0, 255, 255), "🚪 Door")
			elseif v.Name:lower():find("key") and not v:FindFirstChild("ESP") then
				CreateESP(v, Color3.fromRGB(255, 255, 0), "🔑 Key")
			elseif v.Name:lower():find("rush") or v.Name:lower():find("ambush") or v.Name:lower():find("screech") then
				if not v:FindFirstChild("ESP") then
					CreateESP(v, Color3.fromRGB(255, 0, 0), "👹 Entity")
				end
			end
		end
	end
end

AddESP()
Workspace.DescendantAdded:Connect(function()
	task.wait(1)
	AddESP()
end)
