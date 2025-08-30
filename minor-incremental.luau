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
local Ores = {}
for i, v in pairs(game.Players.LocalPlayer.Bag.Ores:GetChildren()) do
    table.insert(Ores, v.Name)
end
table.sort(Ores)
local function Sell()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Sell.Pad.Pad.CFrame
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( -18, 4, 53)
    end)
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
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("MinedOre"):FireServer(SelectedOre, AmountToMine)
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
