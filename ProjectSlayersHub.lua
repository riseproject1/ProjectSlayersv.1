_G.Options = {
    AutoPickupChest = false
}

local Compactio = loadstring(game:HttpGet("https://raw.githubusercontent.com/xa1lt/compactio-root/main/Source.lua"))()
local Breathing = game:GetService("ReplicatedStorage").PlayerValues[game.Players.LocalPlayer.Name].Breath
local Stamina = game:GetService("ReplicatedStorage").PlayerValues[game.Players.LocalPlayer.Name].Stamina
local Box = Compactio.Render({
    Title = "Idle' Hub",
    Save = true,
    Options = 
    {
        SizeX = 450,
        SizeY = 450
    }
})

local Tab = Box.Tab({
    Title = "Main"
})
local Tab2 = Box.Tab({
    Title = "Misc"
})
local Section = Tab.Section({
    Title = "Clan Skills"
})
local Section2 = Tab.Section({
    Title = "Autofarm"
})
local Section3 = Tab2.Section({
    Title = "Auto Section"
})
local Section4 = Tab2.Section({
    Title = "Character"
})

local InfBreath = Section.new({
    Type = "Toggle";
    Title = "Inf Breathing";
    Default =  false,
    Callback = function(InfBreath)
        if InfBreath then
    Breathing:GetPropertyChangedSignal("Value"):Connect(
    function()
        Breathing.Value = 9e9
    if not InfBreath then
        Breathing.Value = nil
            end
        end)
    end 
end
})

local InfBreath = Section.new({
    Type = "Toggle";
    Title = "Inf Stamina";
    Default =  false,
    Callback = function(InfStamina)
        if InfStamina then
    Breathing:GetPropertyChangedSignal("Value"):Connect(
    function()
        Stamina.Value = 9e9
    if not InfStamina then
        Stamina.Value = nil
            end
        end)
    end 
end
})

local godspeed = Section.new({
    Type = "Toggle";
    Title = "God Speed (Human Only!)";
    Default =  false,
    Callback = function(Godspeed)
        if Godspeed then
            game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(true)
        else
            game:GetService("ReplicatedStorage").Remotes.thundertang123:FireServer(false)
        end
    end
})

local rengoku = Section.new({
Type = "Toggle",
Title = "Set Heart A Blaze!(Human Only!)",
Default = false,
Callback = function(Rengokusclan)
    if Rengokusclan then
    game:GetService("ReplicatedStorage").Remotes["heart_ablaze_mode_remote"]:FireServer(true)
else
    game:GetService("ReplicatedStorage").Remotes["heart_ablaze_mode_remote"]:FireServer(false)
    end
end
})
local keyfordodge = Section.new({
    Type = "Keybind",
    Title = "Dodge 11 times",
    Key = Enum.KeyCode.RightAlt,
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes["spacial_awareness_remote"]:FireServer(true)  
    end
})

local AutoChest = Section2.new({
    Type = "Toggle",
    Title = "Auto Collect Chest",
    Default = false,
    Callback = function(value)
            _G.Options.AutoCollectChests = value
        end
})

Section4.new({
    Type = "Button",
    Title = "Reset Character ",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})



Section4.new({
    Type = "Button",
    Title = "Check Breathing Progress",
    Callback = function()
        local Plr = game:GetService("Players").LocalPlayer
        local breath = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].BreathingProgress
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Idle' Hub",
            Text = "Breathing Progress: " .. breath["1"].Value .. " / " .. breath["2"].Value,
            Duration = 10
        })
    end
})

Section4.new({
    Type = "Button",
    Title = "Check Demon Progress",
    Callback = function()
        local Plr = game:GetService("Players").LocalPlayer
        local demon = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].DemonProgress
 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Idle' Hub",
            Text = "Demon Progress: " .. demon["1"].Value .. " / " .. demon["2"].Value,
            Duration = 10
        })
    end
})


if _G.AutoPickupChest then
    local chest = game:GetService("Workspace").Debree:FindFirstChild("Loot_Chest")
       
    if chest and #chest:WaitForChild("Drops"):GetChildren() > 0 then
        local remote = chest:WaitForChild("Add_To_Inventory")

        for _,v in next, chest:WaitForChild("Drops"):GetChildren() do
            if not game:GetService("ReplicatedStorage")["Player_Data"][game.Players.LocalPlayer.Name].Inventory:FindFirstChild(v.Name, true) then
                remote:InvokeServer(v.Name)
            end
        end
    end
end  