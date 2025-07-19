local Section = require(script.Parent.Parent.Elementos.Section)
local Label = require(script.Parent.Parent.Elementos.Label)
local Button = require(script.Parent.Parent.Elementos.Button)
local Toggle = require(script.Parent.Parent.Elementos.Toggle)
local Dropdown = require(script.Parent.Parent.Elementos.Dropdown)

local Tab = {}
Tab.__index = Tab

function Tab.new(window, TabScrollFrame)
    local self = setmetatable({}, Tab)
    self.window = window
    self.TabScrollFrame = TabScrollFrame
    self.ButtonY = 0
    self.TabList = {}
    return self
end

function Tab:MakeTab(TabInfo)
    local Button = Instance.new("TextButton", self.TabScrollFrame)
    Button.Size = UDim2.new(0, 120, 0, 30)
    Button.Position = UDim2.new(0, 0, 0, self.ButtonY)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.AutoButtonColor = false
    Button.Text = TabInfo.Name or "Tab"
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    self.ButtonY = self.ButtonY + Button.Size.Y.Offset + 5
    self.TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, self.ButtonY)

    local TabContent = Instance.new("ScrollingFrame", self.window)
    TabContent.Name = TabInfo.Name or "TabContent"
    TabContent.Size = UDim2.new(1, -150, 1, -80)
    TabContent.Position = UDim2.new(0, 140, 0, 70)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = (#self.TabList == 0)
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
    TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    table.insert(self.TabList, TabContent)

    Button.MouseButton1Click:Connect(function()
        for _, f in ipairs(self.TabList) do f.Visible = false end
        TabContent.Visible = true
        for _, btn in ipairs(self.TabScrollFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end
        Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    local elementY = 0
    local TabFunctions = {}

    function TabFunctions:AddSection(info)
        local section = Section.new(TabContent, elementY, info)
        elementY = elementY + section.Size.Y.Offset + 5
        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
        return section
    end

    function TabFunctions:AddLabel(info)
        local label = Label.new(TabContent, elementY, info)
        elementY = elementY + label.Size.Y.Offset + 5
        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
        return label
    end

    function TabFunctions:AddButton(info)
        local button = Button.new(TabContent, elementY, info)
        elementY = elementY + button.Size.Y.Offset + 5
        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
        return button
    end

    function TabFunctions:AddToggle(info)
        local toggle = Toggle.new(TabContent, elementY, info)
        elementY = elementY + toggle.Size.Y.Offset + 5
        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
        return toggle
    end

    function TabFunctions:AddDropdown(info)
        local dropdown = Dropdown.new(TabContent, elementY, info)
        elementY = elementY + dropdown.Size.Y.Offset + 5
        TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
        return dropdown
    end

    return TabFunctions
end

return Tab
print("Tab Completa.")
