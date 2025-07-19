local TweenService = game:GetService("TweenService")
local Toggle = {}

function Toggle.new(parent, y, info)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, y + 20)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 1.5
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 6)

    local nameLabel = Instance.new("TextLabel", frame)
    nameLabel.Text = info.Name or "Toggle"
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, -70, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.TextTransparency = 1
    TweenService:Create(nameLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Size = UDim2.new(0, 50, 0, 24)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""
    toggleBtn.ClipsDescendants = true

    local toggleCorner = Instance.new("UICorner", toggleBtn)
    toggleCorner.CornerRadius = UDim.new(0, 12)
    local toggleIndicator = Instance.new("Frame", toggleBtn)
    toggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    toggleIndicator.Position = UDim2.new(0, 2, 0.5, -10)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleIndicator.BorderSizePixel = 0
    local indicatorCorner = Instance.new("UICorner", toggleIndicator)
    indicatorCorner.CornerRadius = UDim.new(0, 10)

    local isOn = info.Default or false
    local function update()
        local toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        local targetPosition = isOn and UDim2.new(0, 28, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        TweenService:Create(toggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = toggleBackgroundColor}):Play()
        TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPosition}):Play()
        if info.Callback and typeof(info.Callback) == "function" then
            info.Callback(isOn)
        end
    end

    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        update()
    end)

    toggleBtn.MouseEnter:Connect(function()
        if not isOn then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        end
    end)
    toggleBtn.MouseLeave:Connect(function()
        if not isOn then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end
    end)

    update()
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
    return frame
end

return Toggle
