local Tools = {}

local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Backpack = Plr.Backpack

local function LoadFromSource(source)
    if not source then return nil end
    local success, asset = pcall(function()
        if source:match("^rbxassetid://") then
            return game:GetObjects(source)[1]
        elseif source:match("^https?://") then
            return game:GetObjects(source)[1]
        elseif source:match("^%d+$") then
            return game:GetObjects("rbxassetid://" .. source)[1]
        else
            return game:GetObjects(source)[1]
        end
    end)
    return success and asset or nil
end

function Tools.Spawner(config)
    if not config or not config.Name or not config.ToolID then
        warn("Config gak lengkap! Butuh Name ama ToolID")
        return nil
    end

    local tool = LoadFromSource(config.ToolID)
    if not tool then
        warn("Gagal load tool:", config.Name)
        return nil
    end

    tool.Name = config.Name
    tool.Parent = Backpack

    if config.Animation and config.Animation.Enabled then
        local Char = Plr.Character or Plr.CharacterAdded:Wait()
        local RightArm = Char:WaitForChild("RightUpperArm")
        local LeftArm = Char:WaitForChild("LeftUpperArm")
        local RightC1 = RightArm.RightShoulder.C1
        local LeftC1 = LeftArm.LeftShoulder.C1

        local anim = config.Animation
        local rightAngle = anim.RightArmAngle or {-90, -15}
        local leftOffset = anim.LeftArmOffset or {-0.2, -0.3, -0.5}
        local leftAngle = anim.LeftArmAngle or {-125, 25, 25}

        local equipped = false

        tool.Equipped:Connect(function()
            if equipped then return end
            equipped = true
            RightArm.Name = "R_Arm"
            LeftArm.Name = "L_Arm"
            RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(rightAngle[1]), math.rad(rightAngle[2]), 0)
            LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(unpack(leftOffset)) * CFrame.Angles(math.rad(leftAngle[1]), math.rad(leftAngle[2]), math.rad(leftAngle[3]))
        end)

        tool.Unequipped:Connect(function()
            if not equipped then return end
            equipped = false
            RightArm.RightShoulder.C1 = RightC1
            LeftArm.LeftShoulder.C1 = LeftC1
            RightArm.Name = "RightUpperArm"
            LeftArm.Name = "LeftUpperArm"
        end)
    end

    if config.Tools and config.Tools.LighterFlashlight and config.Tools.LighterFlashlight.Enabled then
        local lf = config.Tools.LighterFlashlight
        local lightEnabled = false
        local light = nil

        if lf.Light then
            light = Instance.new("PointLight")
            light.Brightness = lf.Brightness or 3
            light.Color = lf.Color or Color3.fromRGB(255, 255, 255)
            light.Range = lf.Range or 20
            light.Enabled = false
        end

        if lf.ButtonOpenLight then
            local UIS = game:GetService("UserInputService")
            local debounce = false

            UIS.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == Enum.KeyCode.E then
                    if not debounce then
                        debounce = true
                        lightEnabled = not lightEnabled
                        if light then
                            light.Enabled = lightEnabled
                        end
                        print("Light:", lightEnabled and "ON" or "OFF")
                        task.wait(0.5)
                        debounce = false
                    end
                end
            end)
        end

        tool.Equipped:Connect(function()
            if light then
                local handle = tool:FindFirstChild("Handle") or Plr.Character:FindFirstChild("HumanoidRootPart")
                if handle then
                    light.Parent = handle
                end
            end
        end)

        tool.Unequipped:Connect(function()
            if light then
                light.Parent = nil
                lightEnabled = false
            end
        end)
    end

    if config.SettingCrucifix and config.SettingCrucifix.Enabled then
        local Char = Plr.Character or Plr.CharacterAdded:Wait()
        local Root = Char:FindFirstChild("HumanoidRootPart")
        local range = config.entity and config.entity.Range or 25
        local exorcising = false

        local ringAsset = nil
        local chainsAsset = nil
        local crossAsset = nil

        if config.SettingCrucifix.RingID and config.SettingCrucifix.RingID ~= "" then
            ringAsset = LoadFromSource(config.SettingCrucifix.RingID)
        end
        if config.SettingCrucifix.EnabledChains and config.SettingCrucifix.Chains ~= "" then
            chainsAsset = LoadFromSource(config.SettingCrucifix.Chains)
        end
        if config.SettingCrucifix.Cross and config.SettingCrucifix.Cross ~= "" then
            crossAsset = LoadFromSource(config.SettingCrucifix.Cross)
        end

        task.spawn(function()
            while tool and tool.Parent do
                if Root and not exorcising then
                    for _, entity in pairs(workspace:GetDescendants()) do
                        if entity:IsA("Model") and entity:GetAttribute("IsCustomEntity") then
                            local entityPart = entity:FindFirstChild("RushNew") or entity.PrimaryPart
                            if entityPart and (Root.Position - entityPart.Position).magnitude <= range then
                                exorcising = true
                                print("Entity ketangkep!")

                                entityPart.Anchored = true
                                local cf = entityPart.CFrame

                                if ringAsset then
                                    local ring = ringAsset:Clone()
                                    ring.Parent = workspace
                                    ring:PivotTo(cf * CFrame.new(0, -3, 0))
                                    game:GetService("Debris"):AddItem(ring, 4)
                                end

                                if chainsAsset then
                                    local chains = chainsAsset:Clone()
                                    chains.Parent = workspace
                                    chains:SetPrimaryPartCFrame(cf * CFrame.new(0, -3.5, 0) * CFrame.Angles(math.rad(90), 0, 0))
                                    game:GetService("Debris"):AddItem(chains, 4)
                                end

                                if crossAsset then
                                    local cross = crossAsset:Clone()
                                    cross.Parent = workspace
                                    local fakeCross = cross:FindFirstChild("Handle") or cross.PrimaryPart
                                    if fakeCross then
                                        fakeCross.CFrame = CFrame.lookAt(Root.Position, cf.Position)
                                        fakeCross.Anchored = true
                                    end
                                    game:GetService("Debris"):AddItem(cross, 5)
                                end

                                task.wait(0.5)

                                local tween = game:GetService("TweenService"):Create(
                                    entityPart,
                                    TweenInfo.new(2.5),
                                    { CFrame = cf * CFrame.new(0, 50, 0) }
                                )
                                tween:Play()
                                tween.Completed:Wait()

                                entity:Destroy()
                                exorcising = false
                                break
                            end
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
    end

    print("✅ Tool spawned:", config.Name)
    return tool
end

print("✅ Tools.Spawner loaded!")
