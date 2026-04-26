local tool = game:GetObjects("rbxassetid://99604162748959")[1]
tool.Name = "Crucifix"
tool.Parent = game.Players.LocalPlayer.Backpack

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local rightArm = char:WaitForChild("RightUpperArm")
local leftArm = char:WaitForChild("LeftUpperArm")
local rightC1 = rightArm.RightShoulder.C1
local leftC1 = leftArm.LeftShoulder.C1
local equipped = false

tool.Equipped:Connect(function()
    if equipped then return end
    equipped = true
    
    rightArm.RightShoulder.C1 = rightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)
    leftArm.LeftShoulder.C1 = leftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))
end)

tool.Unequipped:Connect(function()
    if not equipped then return end
    equipped = false
    
    rightArm.RightShoulder.C1 = rightC1
    leftArm.LeftShoulder.C1 = leftC1
end)

-----------------------[[Function]]-------------------------------------------------------------------------------------------------------------------
-----------------------[[Function]]-------------------------------------------------------------------------------------------------------------------
local SelfModules = {
	  Function = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/refs/heads/main/Functions.lua"))()
}

local CustomShop = {
	   CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Shop%20Items/Source.lua"))() ---Opsional Try to Execute If Possible
}

local Source = "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"

-----------[[Checked Tool]]--------------[[Checked Tool]]--------------

if tool:IsA("Tool") then
    game.StarterGui:SetCore("SendNotification", {
        Title = "✓ SUCCESS",
        Text = "This item is a TOOL! Equip it from your backpack",
        Duration = 3
    })
 
-----Do Not Delete----
loadstring(game:HttpGet(Source))()
  
achievementGiver({
    Title = "THANKS USE SCRIPT ME",
    Desc = "Can You Have Fun",
    Reason = "Script By ScriptGaming",
    Image = "rbxassetid://99226763923744"
})
    
    print("SUCCESS: Item is a Tool, can be equipped!")
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "✗ FAILED",
        Text = "This item is NOT a tool! Might be an accessory or regular model",
        Duration = 3
    })
    warn("FAILED: Item is not a Tool, equip/unequip events won't work!")
  end
