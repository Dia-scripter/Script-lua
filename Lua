-- Utility function to create UI elements
local function createElement(class, props, parent)
    local element = Instance.new(class)
    for prop, value in pairs(props) do
        element[prop] = value
    end
    element.Parent = parent
    return element
end

-- GUI Setup
local gui = createElement("ScreenGui", {Parent = game.CoreGui, Name = "SpeedSliderGUI"}, nil)
local frame = createElement("Frame", {
    Size = UDim2.new(0, 300, 0, 100),
    Position = UDim2.new(0.5, -150, 0.5, -50),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    Draggable = true, Active = true, Selectable = true
}, gui)

local label = createElement("TextLabel", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
    Text = "Speed: 16", TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.SourceSans, TextSize = 24
}, frame)

local slider = createElement("TextButton", {
    Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(0, 0, 0, 50),
    BackgroundColor3 = Color3.fromRGB(150, 150, 150),
    Text = "Drag to adjust speed", TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.SourceSans, TextSize = 20
}, frame)

local minimize = createElement("TextButton", {
    Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -35, 0, 5),
    BackgroundColor3 = Color3.fromRGB(200, 0, 0),
    Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.SourceSans, TextSize = 20
}, frame)

local restore = createElement("TextButton", {
    Size = UDim2.new(0, 150, 0, 50), Position = UDim2.new(0.5, -75, 0.5, -25),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    Text = "Restore GUI", TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.SourceSans, TextSize = 24, Visible = false
}, gui)

createElement("TextLabel", {
    Size = UDim2.new(0, 150, 0, 30), Position = UDim2.new(1, -160, 0, 0),
    BackgroundTransparency = 1, Text = "Made by Dia", 
    TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansItalic,
    TextSize = 16, TextXAlignment = Enum.TextXAlignment.Right
}, gui)

-- Variables
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local speed, dragging = 16, false

-- Slider Drag Logic
slider.MouseButton1Down:Connect(function() dragging = true end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - frame.AbsolutePosition.X) / frame.AbsoluteSize.X, 0, 1)
        slider.Position = UDim2.new(pos, 0, 0, 50)
        speed = math.floor(pos * 100)
        label.Text = "Speed: " .. speed
        humanoid.WalkSpeed = speed
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Minimize and Restore Logic
minimize.MouseButton1Click:Connect(function()
    frame.Visible = false
    restore.Visible = true
end)
restore.MouseButton1Click:Connect(function()
    frame.Visible = true
    restore.Visible = false
end)
