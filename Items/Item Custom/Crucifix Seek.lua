local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Backpack = Plr.Backpack

local RightArm = Char:WaitForChild("RightUpperArm")
local LeftArm = Char:WaitForChild("LeftUpperArm")
local RightC1 = RightArm.RightShoulder.C1
local LeftC1 = LeftArm.LeftShoulder.C1

local tool = game:GetObjects("rbxassetid://")[1]
tool.Name = "Crucifix"
tool.Parent = Backpack

local equipped = false

tool.Equipped:Connect(function()
    if equipped then return end
    equipped = true
    RightArm.Name = "R_Arm"
    LeftArm.Name = "L_Arm"
    RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)
    LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))
end)

tool.Unequipped:Connect(function()
    if not equipped then return end
    equipped = false
    RightArm.RightShoulder.C1 = RightC1
    LeftArm.LeftShoulder.C1 = LeftC1
    RightArm.Name = "RightUpperArm"
    LeftArm.Name = "LeftUpperArm"
end)
