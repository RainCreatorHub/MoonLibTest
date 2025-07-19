local TweenService = game:GetService("TweenService")
local Dropdown = {}

function Dropdown.new(parent, y, info)
    local Camera = game:GetService("Workspace").CurrentCamera
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

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
    nameLabel.Text = info.Name or "Dropdown"
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, -170, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.TextTransparency = 1
    TweenService:Create(nameLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    local dropBtn = Instance.new("TextButton", frame)
    dropBtn.Size = UDim2.new(0, 160, 0, 24)
    dropBtn.Position = UDim2.new(1, -170, 0.5, -12)
    dropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.TextSize = 13
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.Text = "--"
    dropBtn.BackgroundTransparency = 0.3
    dropBtn.AutoButtonColor = false
    dropBtn.ClipsDescendants = true
    dropBtn.ZIndex = 2

    local displayCorner = Instance.new("UICorner", dropBtn)
    displayCorner.CornerRadius = UDim.new(0, 6)
    local displayStroke = Instance.new("UIStroke", dropBtn)
    displayStroke.Color = Color3.fromRGB(80, 80, 80)
    displayStroke.Thickness = 1
    displayStroke.Transparency = 0.5

    local DropdownIco = Instance.new("ImageLabel", dropBtn)
    DropdownIco.Image = "rbxassetid://10709790948"
    DropdownIco.Size = UDim2.new(0, 16, 0, 16)
    DropdownIco.Position = UDim2.new(1, -20, 0.5, -8)
    DropdownIco.BackgroundTransparency = 1
    DropdownIco.ImageColor3 = Color3.fromRGB(180, 180, 180)
    DropdownIco.ImageTransparency = 1
    DropdownIco.ZIndex = 2
    TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()

    local values = info.Values or {}
    local selected = info.Default or values[1]
    local isOpen = false

    local function showValues()
        dropBtn.Text = selected or "--"
        if info.Callback and typeof(info.Callback) == "function" then
            info.Callback(selected)
        end
    end

    dropBtn.MouseButton1Click:Connect(function()
        -- Dropdown list popout (simples, pode expandir)
        if not isOpen then
            isOpen = true
            local listFrame = Instance.new("Frame", frame)
            listFrame.Size = UDim2.new(0, 160, 0, #values * 28)
            listFrame.Position = UDim2.new(1, -170, 1, 2)
            listFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            listFrame.ZIndex = 10
            local corner = Instance.new("UICorner", listFrame)
            corner.CornerRadius = UDim.new(0, 6)
            local stroke = Instance.new("UIStroke", listFrame)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Thickness = 1.5

            for i, v in ipairs(values) do
                local opt = Instance.new("TextButton", listFrame)
                opt.Size = UDim2.new(1, 0, 0, 28)
                opt.Position = UDim2.new(0, 0, 0, (i-1)*28)
                opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                opt.Text = v
                opt.Font = Enum.Font.Gotham
                opt.TextSize = 13
                opt.TextColor3 = Color3.fromRGB(200, 200, 200)
                opt.ZIndex = 11
                opt.MouseButton1Click:Connect(function()
                    selected = v
                    showValues()
                    listFrame:Destroy()
                    isOpen = false
                end)
                opt.MouseEnter:Connect(function()
                    TweenService:Create(opt, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
                end)
                opt.MouseLeave:Connect(function()
                    TweenService:Create(opt, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end)
            end

            UserInputService.InputBegan:Connect(function(input)
                if isOpen and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    if Mouse.X < listFrame.AbsolutePosition.X or Mouse.X > listFrame.AbsolutePosition.X + listFrame.AbsoluteSize.X or
                       Mouse.Y < listFrame.AbsolutePosition.Y or Mouse.Y > listFrame.AbsolutePosition.Y + listFrame.AbsoluteSize.Y then
                        listFrame:Destroy()
                        isOpen = false
                    end
                end
            end)
        end
    end)

    showValues()
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
    return frame
end

return Dropdown
