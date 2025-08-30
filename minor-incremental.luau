-- If you actually need to skid from this then you are the biggest re***d i have ever seen ☠️

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "NXP Hub",
    Icon = 0,
    LoadingTitle = "Nxp hub",
    LoadingSubtitle = "Minining incremental",
    ShowText = "NXP HUB",
    Theme = "Default",

    ToggleUIKeybind = "K",
})

local Tab = Window:CreateTab("Auto farm", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Auto Mine")
local Tab2 = Window:CreateTab("Buy", 4483362458)      -- Title, Image
local Section2 = Tab2:CreateSection("Buy")

local function Magic(path)
    local Sorted = {}
    for i, v in pairs(path:GetChildren()) do
        table.insert(Sorted, v.Name)
    end
    table.sort(Sorted)
    return Sorted
end

-- Ores
local Ores = Magic(game.Players.LocalPlayer.Bag.Ores)

-- Backpacks
local Backpacks = Magic(game:GetService("ReplicatedStorage").Backpacks)

-- Pickaxes
local Pickaxes = Magic(game:GetService("ReplicatedStorage").PickaxesF)

local function Sell()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Sell.Pad.Pad.CFrame
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-18, 4, 53)
    end)
end
local function Rebirth()
    local args = {
        "DoRebirth"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer(unpack(args))
end
local SelectedOre = "Coal"
local AmountToMine = 1
Tab:CreateToggle({
    Name = "Auto Mine",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.AutoMine = Value
        task.spawn(function()
            while _G.AutoMine and task.wait(0.05) do
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("MinedOre"):FireServer(
                SelectedOre, AmountToMine)
            end
        end)
    end,
})
Tab:CreateDropdown({
    Name = "Selected Ore",
    Options = Ores,
    CurrentOption = "Coal",
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        SelectedOre = Options[1]
    end,
})
Tab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.AutoSell = Value
        task.spawn(function()
            while _G.AutoSell and task.wait(0.2) do
                Sell()
            end
        end)
    end,
})
local Input = Tab:CreateInput({
    Name = "Amount To Mine",
    CurrentValue = "1",
    PlaceholderText = "Enter a number",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        if tonumber(Text) then
            AmountToMine = tonumber(Text)
        end
    end,
})
Tab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.AutoRebirth = Value
        task.spawn(function()
            while _G.AutoRebirth and task.wait(0.2) do
                Rebirth()
            end
        end)
    end,
})

local SPickaxe = "Stone Pickaxe"
Tab2:CreateDropdown({
    Name = "Select Pickaxe",
    Options = Pickaxes,
    CurrentOption = "Stone Pickaxe",
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        SPickaxe = Options[1]
    end,
})
local SBackpack = "Copper Bag"
Tab2:CreateDropdown({
    Name = "Select Backpack",
    Options = Backpacks,
    CurrentOption = "Copper Bag",
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        SBackpack = Options[1]
    end,
})

Tab2:CreateButton({
    Name = "Buy Pickaxe",
    Callback = function()
        local args = {
            SPickaxe,
            "pickaxe",
            require(game:GetService("ReplicatedStorage").Modules.Pickaxes)[SPickaxe].Price
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Purchase"):FireServer(unpack(args))
    end,
})
Tab2:CreateButton({
    Name = "Buy Backpack",
    Callback = function()
        local args = {
            SBackpack,
            "bag",
            require(game:GetService("ReplicatedStorage").Modules.Bags)[SBackpack].Price
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Purchase"):FireServer(unpack(args))
    end,
})
