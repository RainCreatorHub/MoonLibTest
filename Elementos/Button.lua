local TweenService = game:GetService("TweenService")
local Button = {}

function Button.new(parent, y, info)
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

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 2

    local nameLabel = Instance.new("TextLabel", frame)
    nameLabel.Text = info.Name or "Button"
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, -20, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.TextTransparency = 1
    TweenService:Create(nameLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    local descLabel = Instance.new("TextLabel", frame)
    descLabel.Text = info.Description or ""
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.BackgroundTransparency = 1
    descLabel.Size = UDim2.new(1, -20, 0.5, 0)
    descLabel.Position = UDim2.new(0, 10, 0.5, 0)
    descLabel.TextTransparency = 1
    TweenService:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()

    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    if info.Callback and typeof(info.Callback) == "function" then
        btn.MouseButton1Click:Connect(function()
            local success, callbackError = pcall(info.Callback)
            if not success then
                warn("Button Callback Error: " .. tostring(callbackError))
            end
        end)
    end

    return frame
end

return Button
