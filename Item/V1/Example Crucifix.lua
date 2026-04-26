loadstring(game:HttpGet("https://raw.githubusercontent.com/arkanzulfadliputra-oss/Testing/refs/heads/main/Items/Example.lua"))()

Tools.Spawner({
    Name = "Crucifix",
    ToolID = "12381314657",
    Animation = {
        Enabled = true,
        RightArmAngle = {-90, -15},
        LeftArmOffset = {-0.2, -0.3, -0.5},
        LeftArmAngle = {-125, 25, 25}
    },
    SettingCrucifix = {
        Enabled = false,
        RingID = "11582377043",
        EnabledChains = true,
        Chains = "12218755892",
        Cross = "12860244798"
    },
    entity = {
        Enabled = true,
        Range = 25
    }
})
