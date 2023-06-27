getgenv().SecureMode = true
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))() --// Link to the ui library.
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Sirius/request/library/sense/source.lua'))() --// ESP Library

--// Upvalues (Discord invite, Key)
local DiscordInviteLink = "https://discord.gg/VtmpzePBMK" --// Discord invite link.
local ScriptHubKey = "foxsen" --// Will be changed every week. This is just a temporary key.

--// Library Window
local Window = library:CreateWindow({
    Name = "Project Redux X",
    LoadingTitle = "Redux X",
    LoadingSubtitle = "by 1nvolyte#0001",
    Discord = {
       Enabled = true,
       Invite = DiscordInviteLink,
       RememberJoins = false
    },
    KeySystem = true,
    KeySettings = {
       Title = "Redux X",
       Subtitle = "Key System",
       Note = "Discord: "..DiscordInviteLink,
       FileName = "Redux X",
       SaveKey = false,
       GrabKeyFromSite = false,
       Key = ScriptHubKey
    }
 })

local CombatTab = Window:CreateTab("👊 Combat")
local AimbotTab = Window:CreateTab("🔫 Aimbot")
local ESPTab = Window:CreateTab("🕶 ESP")
local FarmTab = Window:CreateTab("👨‍🌾 Farming")
local TeleportTab = Window:CreateTab("✈ Teleports")

CombatTab:CreateSection("👊 Combat")
AimbotTab:CreateSection("🔫 Aimbot")
ESPTab:CreateSection("🕶 ESP")
FarmTab:CreateSection("👨‍🌾 Farming")
TeleportTab:CreateSection("✈ Teleports")

--//Local vars
local LCP = game:GetService("Players").LocalPlayer
local TS = game:GetService("TweenService")

local InitialWalkSpeed  = LCP.Character.Humanoid.WalkSpeed
local InitialJumpPower = LCP.Character.Humanoid.JumpPower

--//Functions
function TweenTo(Position, Speed)
	TS:Create(LCP.Character.HumanoidRootPart, TweenInfo.new((LCP.Character.HumanoidRootPart.Position - Position.p).magnitude / Speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		CFrame = Position
	}):Play()
end

--//Hooking metamethods || functions
local OldIndex
local OldNamecall

OldIndex = hookmetamethod(game, "__index", function(Self, Index)
	if Index == "WalkSpeed" then
		return InitialWalkSpeed
	elseif Index == "JumpPower" then
		return InitialJumpPower
	end
	return OldIndex(Self, Index)
end)

--//Anti kick just incase
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
	local NCM = getnamecallmethod()
	if NCM == "Kick" then
		library:Notify({
			Title = "Redux X",
			Content = "The game tried pulling an uno reverse card (Kick)🗿",
			Duration = 3
		})
		return nil
	end
	return OldNamecall(Self, ...)

end)

--//Settings
getgenv().Settings = {
	TeleportSpeed = 200,
	CharacterSJ = false,
	DashModsEnabled = false,
	CharacterValues = {
		Walkspeed = 16,
		JumpPower = 50
	},
	DashModifications = {
		DashSpeed = 5555,
		DashDistance = 45
	}
}

local TPLocations = {
	["Anteiku"] = CFrame.new(-1495, 147, -660),
	["Arena"] = CFrame.new(-1664, 65, -1255),
	["CCG HQ"] = CFrame.new(-1594, 70, 310),
	["Arena Roof"] = CFrame.new(-1865, 654, -1367),
	["CCG HQ Roof"] = CFrame.new(-1562, 1245, 311),
	["Yard"] = CFrame.new(-917, 65, -1323),
	["Parking Lot"] = CFrame.new(-393, 156, -835),
	["Containers"] = CFrame.new(-1053, 106, -339),
	["Mask Shop"] = CFrame.new(-910, 66, -915),
	["Kagune Shop"] = CFrame.new(-287, 66, -1283),
	["Specials Shop"] = CFrame.new(-523, 66, 1010),
	["Quinque Shop"] = CFrame.new(-1652, 68, 1330)
}

--// Combat Tab
CombatTab:CreateToggle({
	Name = "Enable Walk Speed & Jump Power",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Settings.CharacterSJ = Value
	end
})

CombatTab:CreateSlider({ --// Walkspeed slider
	Name = "Walk Speed",
	Range = {
		InitialWalkSpeed,
		300
	},
	Increment = 1,
	Suffix = "",
	CurrentValue = InitialWalkSpeed,
	Flag = "",
	Callback = function(Value)
		Settings.CharacterValues.WalkSpeed = Value
	end
})

CombatTab:CreateSlider({ --// Jump Power Slider
	Name = "Jump Power",
	Range = {
		InitialJumpPower,
		300
	},
	Increment = 1,
	Suffix = "",
	CurrentValue = InitialJumpPower,
	Flag = "",
	Callback = function(Value)
		Settings.CharacterValues.JumpPower = Value
	end
})

CombatTab:CreateSection("🏃‍♂️ Dash Modifications")

CombatTab:CreateToggle({
	Name = "Enable Dash Modifications",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Settings.DashModsEnabled = Value
	end,
})

CombatTab:CreateSlider({ --// Dash Distance slider
	Name = "Dash Distance",
	Range = {
		100,
		1000
	},
	Increment = 5,
	Suffix = "",
	CurrentValue = 100,
	Flag = "",
	Callback = function(Value)
		Settings.DashModifications.DashDistance = Value
	end
})

CombatTab:CreateSlider({ --// Dash Speed slider
	Name = "Dash Speed",
	Range = {
		100,
		5000
	},
	Increment = 10,
	Suffix = "",
	CurrentValue = 1750,
	Flag = "",
	Callback = function(Value)
		Settings.DashModifications.DashSpeed = Value
	end
})

CombatTab:CreateParagraph({
	Title = "⚠ Warning",
	Content = "You are more likely to die with a higher dash speed or distance!"
})

--//Aimbot tab

--//ESP TAB
--Default Settings
Sense.teamSettings.friendly.boxColor[1] = Color3.fromRGB(255, 255, 255)
Sense.teamSettings.enemy.boxColor[1] = Color3.fromRGB(255, 255, 255)

Sense.teamSettings.friendly.boxFillColor[1] = Color3.fromRGB(255, 255, 255)
Sense.teamSettings.enemy.boxFillColor[1] = Color3.fromRGB(255, 255, 255)

Sense.teamSettings.friendly.tracerColor[1] = Color3.fromRGB(255, 255, 255)
Sense.teamSettings.enemy.tracerColor[1] = Color3.fromRGB(255, 255, 255)

Sense.teamSettings.friendly.boxOutline = false
Sense.teamSettings.enemy.boxOutline = false

Sense.teamSettings.friendly.tracerOutline = false
Sense.teamSettings.enemy.tracerOutline = false

Sense.teamSettings.friendly.nameOutline = false
Sense.teamSettings.enemy.nameOutline = false

Sense.sharedSettings.textFont = 3

ESPTab:CreateToggle({
	Name = "Team ESP",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.friendly.enabled = true
	end,
})

ESPTab:CreateToggle({
	Name = "Enemy ESP",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.enabled = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Names",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.name = Value
		Sense.teamSettings.friendly.name = Value
	end,
})

ESPTab:CreateToggle({
	Name = "ESP Boxes",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.box = Value
		Sense.teamSettings.friendly.box = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Health Bar",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.healthBar = Value
		Sense.teamSettings.friendly.healthBar = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Tracers",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.tracer = Value
		Sense.teamSettings.friendly.tracer = Value
	end,
})

ESPTab:CreateToggle({
	Name = "ESP Box Filled",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.boxFill = Value
		Sense.teamSettings.friendly.boxFill = Value
	end,
})

ESPTab:CreateDropdown({
	Name = "Tracer Origin",
	Options = {
		"Top",
		"Middle",
		"Bottom"
	},
	CurrentOption = "Bottom",
	Flag = "",
	Callback = function(Option)
		Sense.teamSettings.enemy.tracerOrigin = Option
		Sense.teamSettings.friendly.tracerOrigin = Option
	end,
})

ESPTab:CreateColorPicker({
	Name = "ESP Box Color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.boxColor[1] = Value
		Sense.teamSettings.friendly.boxColor[1] = Value
	end
})

ESPTab:CreateColorPicker({
	Name = "ESP Box Filled Color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.boxFillColor[1] = Value
		Sense.teamSettings.friendly.boxFillColor[1] = Value
	end
})

ESPTab:CreateColorPicker({
	Name = "Tracer Color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "",
	Callback = function(Value)
		Sense.teamSettings.enemy.tracerColor[1] = Value
		Sense.teamSettings.friendly.tracerColor[1] = Value
	end
})

ESPTab:CreateSlider({
	Name = "ESP Text Size",
	Range = {
		5,
		100
	},
	Increment = 1,
	Suffix = "",
	CurrentValue = 13,
	Flag = "",
	Callback = function(Value)
		Sense.sharedSettings.textSize = Value
	end
})
Sense.Load()

--//Farm tab
FarmTab:CreateParagraph({
	Title = "⚠ Info",
	Content = "We only support Exulus (Gyakusatsu Autofarm) at the moment. More to come later!\n\nTo get the autofarm script, join:\nhttps://dsc.gg/SaintX and place the script in your autoexec folder."
})

local SelectedSide;

FarmTab:CreateDropdown({
	Name = "Pick A Side",
	Options = {
		"Ghoul",
		"CCG"
	},
	CurrentOption = "",
	Flag = "",
	Callback = function(Option)
		SelectedSide = Option
	end
})

FarmTab:CreateToggle({
	Name = "Ping (Discord Ping)",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		getgenv().Ping = Value
	end
})

FarmTab:CreateToggle({
	Name = "Gyakusatsu Finder (This won't execute the autofarm)",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		getgenv().Gyakusatsu_Finder = Value
	end
})

FarmTab:CreateButton({
	Name = "Start",
	Callback = function()
		if not SelectedSide then
			library:Notify({
				Title = "Exulus",
				Content = "Please select a side!",
				Duration = math.huge,
				Actions = {
					Ignore = {
						Name = "👍 Okay!",
						Callback = nil
					}
				}
			})
		else
			library:Notify({
				Title = "Exulus",
				Content = "Selected side: " .. SelectedSide .. "\nStarting up...",
				Duration = 3
			})
         
         --// Exulus Globals
			getgenv().Side = SelectedSide
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Saint0-0/Ro_Ghoul_Autofarm/main/Main.lua"))()
		end
	end
})

--//Teleport tab
local SelectedOption

TeleportTab:CreateDropdown({
	Name = "Locations",
	Options = {
		"Anteiku",
		"Arena",
		"CCG HQ",
		"Arena Roof",
		"CCG HQ Roof",
		"Yard",
		"Parking Lot",
		"Containers",
		"Mask Shop",
		"Kagune Shop",
		"Specials Shop",
		"Quinque Shop"
	},
	CurrentOption = "",
	Flag = "",
	Callback = function(Option)
		SelectedOption = Option
	end,
})

TeleportTab:CreateSlider({ --// Walkspeed slider
	Name = "Teleport Speed",
	Range = {
		1,
		500
	},
	Increment = 1,
	Suffix = "",
	CurrentValue = 200,
	Flag = "",
	Callback = function(Value)
		Settings.TeleportSpeed = Value
	end,
})

TeleportTab:CreateButton({
	Name = "Teleport",
	Callback = function()
		for i, v in pairs(TPLocations) do
			for _, k in pairs(SelectedOption) do
                if k == i then
                    TweenTo(v, Settings.TeleportSpeed)
                end
            end
		end
	end
})

TeleportTab:CreateParagraph({
	Title = "⚠ Warning",
	Content = "You are more likely to die with a higher teleport speed!"
})

while task.wait() do
	if Settings.CharacterSJ then
		LCP.Character:WaitForChild("Humanoid").WalkSpeed = tonumber(Settings.CharacterValues.WalkSpeed)
		LCP.Character:WaitForChild("Humanoid").JumpPower = tonumber(Settings.CharacterValues.JumpPower)
	end
	if Settings.DashModsEnabled then
        --[[
            The credit for the original dash boost script goes to Nahida#9368.
            This version was rewritten by ⚔Saint#6099 and has been slightly modified to eliminate the use of hooking the wait function.
        ]]
		for _, v in next, getgc(true) do
			if type(v) == "function" and getfenv(v).script == game.Workspace:WaitForChild(LCP.Name).ClientControl then
				local Constants = getconstants(v)
				if Constants[1] == "UserInputType" and Constants[2] == "Enum" and Constants[3] == "MouseButton1" then
					local Dash  = LCP.Character:WaitForChild("HumanoidRootPart"):WaitForChild("Dash")
					local Distance = (Dash.Position - LCP.Character:WaitForChild("HumanoidRootPart").Position)
					local Direction = Distance.Unit
					Dash.P = Settings.DashModifications.DashSpeed
					Dash.Position = LCP.Character:WaitForChild("HumanoidRootPart").Position + Direction * Settings.DashModifications.DashDistance
				end
			end
		end
	end
end
