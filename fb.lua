-- Gui to Lua
-- Version: 3.6

-- Instances:

local XezHub = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Lv = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local Exp = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Stamina = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local UICorner_4 = Instance.new("UICorner")
local ImageButton = Instance.new("ImageButton")

-- Properties:

XezHub.Name = "XezHub"
XezHub.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
XezHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = XezHub
Frame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.26572594, 0, 0.330160171, 0)
Frame.Size = UDim2.new(0, 598, 0, 140)

Lv.Name = "Lv"
Lv.Parent = Frame
Lv.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Lv.BorderColor3 = Color3.fromRGB(0, 0, 0)
Lv.BorderSizePixel = 0
Lv.Position = UDim2.new(0.186677039, 0, 0.105063736, 0)
Lv.Size = UDim2.new(0, 232, 0, 37)
Lv.Font = Enum.Font.SourceSans
Lv.Text = "Lv"
Lv.TextColor3 = Color3.fromRGB(0, 255, 255)
Lv.TextScaled = true
Lv.TextSize = 31.000
Lv.TextStrokeTransparency = 0.000
Lv.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 90)
UICorner.Parent = Lv

Exp.Name = "Exp"
Exp.Parent = Frame
Exp.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Exp.BorderColor3 = Color3.fromRGB(0, 0, 0)
Exp.BorderSizePixel = 0
Exp.Position = UDim2.new(0.592826843, 0, 0.100366868, 0)
Exp.Size = UDim2.new(0, 232, 0, 37)
Exp.Font = Enum.Font.SourceSans
Exp.Text = "Exp"
Exp.TextColor3 = Color3.fromRGB(0, 255, 238)
Exp.TextScaled = true
Exp.TextSize = 31.000
Exp.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 90)
UICorner_2.Parent = Exp

Stamina.Name = "Stamina"
Stamina.Parent = Frame
Stamina.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Stamina.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stamina.BorderSizePixel = 0
Stamina.Position = UDim2.new(0.368407071, 0, 0.555667579, 0)
Stamina.Size = UDim2.new(0, 232, 0, 37)
Stamina.Font = Enum.Font.SourceSans
Stamina.Text = "Stamina"
Stamina.TextColor3 = Color3.fromRGB(0, 255, 238)
Stamina.TextSize = 31.000
Stamina.TextStrokeTransparency = 0.000

UICorner_3.CornerRadius = UDim.new(0, 90)
UICorner_3.Parent = Stamina

UICorner_4.Parent = Frame

ImageButton.Parent = Frame
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BackgroundTransparency = 1.000
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(-0.0245445017, 0, 0.100076295, 0)
ImageButton.Size = UDim2.new(0, 146, 0, 110)
ImageButton.Image = "http://www.roblox.com/asset/?id=123390891643337"

-- Scripts:



MakeDraggable(Frame)




-- Toggle UI visibility with X key
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.X then
            XezHub.Enabled = not XezHub.Enabled
        end
    end
end)

-- Update Level, Exp, and Stamina in Real-Time
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local xezHubGui = playerGui:WaitForChild("XezHub")
local hud = playerGui:WaitForChild("UI"):WaitForChild("HUD")

local LevelAmount = hud:WaitForChild("Level")
local ExpAmount = hud:WaitForChild("EXP")
local StaminaAmount = hud:WaitForChild("Bars"):WaitForChild("ProgressStamina")

Lv.Text = "Lv: " .. LevelAmount.Text
Exp.Text = "Exp: " .. ExpAmount.Text
Stamina.Text = "Stamina: " .. StaminaAmount.Text

LevelAmount:GetPropertyChangedSignal("Text"):Connect(function()
    Lv.Text = "Lv: " .. LevelAmount.Text
end)

ExpAmount:GetPropertyChangedSignal("Text"):Connect(function()
    Exp.Text = "Exp: " .. ExpAmount.Text
end)

StaminaAmount:GetPropertyChangedSignal("Text"):Connect(function()
    Stamina.Text = "Stamina: " .. StaminaAmount.Text
end)


local function MakeDraggable(object)
    local TweenService = game:GetService("TweenService")
    local mouseDown = false
    local dragStart = nil
    local startPos = nil

    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseDown = true
            dragStart = input.Position
            startPos = object.Position
        elseif input.UserInputType == Enum.UserInputType.MouseWheel then
            -- ให้สกิวทำงานได้
            return Enum.ContextActionResult.Pass
        end
    end)

    object.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseDown = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if mouseDown then
                local delta = input.Position - dragStart
                local newPos = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
                local tweenInfo = TweenInfo.new(0.1)
                local tween = TweenService:Create(object, tweenInfo, {Position = newPos})
                tween:Play()
            end
        end
    end)
end


Frame.IgnoreGuiInset = true

 local Player = game.Players.LocalPlayer
 local vim = game:GetService("VirtualInputManager")
 local inset1, inset2 = game:GetService('GuiService'):GetGuiInset()
 local insetOffset = inset1 - inset2

local RunService = game:GetService("RunService")

local function toggleRendering()
    if getgenv().ABC then
        RunService:Set3dRenderingEnabled(false)
    else
        RunService:Set3dRenderingEnabled(true)
    end
end

task.spawn(function()
    while task.wait(1) do 
        if not getgenv().ABC then break end
        toggleRendering()
    end
end)




 while task.wait(.1) do 
     if AutoFarm == true then 
         pcall(function()
	if game.Workspace.Characters.Players:FindFirstChild(game.Players.LocalPlayer.Name) == nil then  -- Menu
        local part =game:GetService("Players").LocalPlayer.PlayerGui.UI.MainMenu.Buttons.Play
        local topLeft = part.AbsolutePosition + insetOffset
        local center = topLeft + (part.AbsoluteSize/2)
        local X = center.X + 30
        local Y = center.Y
          vim:SendMouseButtonEvent(X, Y, 0, true, game, 0)
          task.wait()
          vim:SendMouseButtonEvent(X, Y, 0, false, game, 0)
	elseif game.Workspace.Characters.Players:FindFirstChild(game.Players.LocalPlayer.Name) then 

        if getgenv().Ammount >= Player.Character.Stats:GetAttribute("Stamina") then 
            Player.Character.Humanoid.Health = 0
          end

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1276, 696, -190)

        local numbers = {}
        for _, v in pairs(game.Players.LocalPlayer.PlayerGui.UI.Hotbar:GetChildren()) do
            if v:IsA("TextButton") and tonumber(v.Name) and v:FindFirstChild("Requirement") and v.Requirement.Visible == false then
        local keyMap = {
            ["1"] = Enum.KeyCode.One,
            ["2"] = Enum.KeyCode.Two,
            ["3"] = Enum.KeyCode.Three,
            ["4"] = Enum.KeyCode.Four,
            ["5"] = Enum.KeyCode.Five,
            ["6"] = Enum.KeyCode.Six,
        }
        local keyCode = keyMap[v.Name]
        if keyCode then
            table.insert(numbers, keyCode)
        end
    end
end


for _, keyCode in pairs(numbers) do
    game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, game)
  task.wait(1)
    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait()
    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
  task.wait(2)
				end
    		end
		end)
else
    wait()
        break
        end 
	end
