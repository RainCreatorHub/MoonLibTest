local TweenService = game:GetService("TweenService")
local Section = {}

function Section.new(parent, y, info)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, y + 20)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = info.Name or "Section"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)

    -- Animation (fade in)
    label.TextTransparency = 1
    TweenService:Create(label, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    return frame
end

return Section
