local tool = game:GetObjects("rbxassetid://18247669030")[1]
tool.Name = "Coca Cola Is Pupaaaa"
tool.Parent = game.Players.LocalPlayer.Backpack

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:FindFirstChild("Humanoid")

local AnimIdle = Instance.new("Animation")
AnimIdle.AnimationId = "rbxassetid://9982615727"
local idleTrack = hum:LoadAnimation(AnimIdle)

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://7209200833"
sound.Volume = 5

tool.Equipped:Connect(function()
    idleTrack:Play()
    print("Equip - idle Start")
    
    sound.Parent = char
    sound:Play()
end)

tool.Unequipped:Connect(function()
    idleTrack:Stop()
    print("Unequip - idle Stop")
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
