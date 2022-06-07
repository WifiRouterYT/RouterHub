-- Additional Libraries
local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/BoredStuff2/notify-lib/main/lib'),true))()
local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

if(game.PlaceId ~= 189707) then
	Lib.prompt('ERROR! :(', 'This script is inteded to only run on Natural Disaster Survival.', 5)
	do return end
end

Lib.prompt('Game detected!', 'Loaded script for Natural Disaster Survival.', 3)
Lib.prompt('Welcome', "Welcome to WifiRouter's NDS script! You can use Left Alt to toggle the GUI. (Keybind configurable in Settings)", 5)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Natural Disaster Survival")
wait(0.1)
local Player = Window:NewTab("Player")
wait(0.1)
local ServerSide = Window:NewTab("Server-Side")
wait(0.1)
local Teleport = Window:NewTab("Teleport")
wait(0.1)
local Automation = Window:NewTab("Automation")
wait(0.1)
local Settings = Window:NewTab("Settings")
wait(0.1)

getgenv().SSToggled = false
getgenv().FWToggled = false
getgenv().PDToggled = false

getgenv().complete = false

votemenu = game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage

local PlayerSection = Player:NewSection("Player - Scripts for your avatar")
wait(0.06)
PlayerSection:NewSlider("Walk Speed", "Changes how fast you walk", 200, 19, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
wait(0.06)
PlayerSection:NewSlider("Jump Power", "Changes how high you jump", 200, 48, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
wait(0.06)
PlayerSection:NewButton("Reset Character", "Kills your avatar.", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
	Lib.prompt('Success!', 'Killed your avatar.', 3)
end)
wait(0.06)
PlayerSection:NewButton("Rejoin", "Kicks you and then rejoins into the same server.", function()
	Lib.prompt('', 'One moment please...', 3)
	wait(2)
	local ts = game:GetService("TeleportService")

	local p = game:GetService("Players").LocalPlayer
	ts:Teleport(game.PlaceId, p)
end)
wait(0.06)
PlayerSection:NewButton("Server Hop", "Connects you to a different server.", function()
	Lib.prompt('Please wait!', 'Finding a server...', 3)
	wait(0.7)
	module:Teleport(game.PlaceId)
end)
wait(0.06)
PlayerSection:NewButton("Get Green Balloon", "Clones somebody else's Green Balloon to you.", function()
	Lib.prompt('Get Green Balloon', "Attempting to give you a balloon...", 5)
	Lib.prompt('Gave item', "Item received. If you didn't get it, that might be because nobody else has one to clone. Try server hopping until it works.", 5)
	local player = tostring(game.Players.LocalPlayer.Name)
	while true do
		if game.Workspace:FindFirstChild("GreenBalloon") then
			if not game.Workspace[player]:FindFirstChild("GreenBalloon") and not game.Players.LocalPlayer.Backpack:FindFirstChild("GreenBalloon") then
				local workspaceClone = game.Workspace.GreenBalloon:Clone()
				workspaceClone.Parent = game.Workspace[player]
			end
		else
			local balloonCheck = game.Workspace:GetDescendants()
			local balloonClone
			for i, balloon in ipairs(balloonCheck) do
				if (tostring(balloon.Name) == "GreenBalloon") then
					balloonClone = balloon:Clone()
					wait()
				end
			end
			balloonClone.Parent = game.Workspace
			local workspaceClone = game.Workspace.GreenBalloon:Clone()
			workspaceClone.Parent = game.Workspace[player]
		end
		wait()
	end
end)
wait(0.06)
PlayerSection:NewButton("Remove fall damage", "Stops you from taking fall damage.", function() 
	if game.Players.LocalPlayer.Character:findFirstChild("FallDamageScript") then 
		game.Players.LocalPlayer.Character.FallDamageScript:remove()
	end
	Lib.prompt("Success!", "Fall damage has been removed from your avatar.", 3)
end)
wait(0.06)
PlayerSection:NewButton("Remove sandstorm overlay", "Removes that annoying overlay in a sandstorm", function() 
	Lib.prompt("Success!", "Now blocking the sandstorm overlay. In some cases, this may not take affect until the next round.", 7)
	game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(newgui)
		if newgui.Name == "SandStormGui" then
			newgui:remove()
		end
	end)
end)

local FESection = ServerSide:NewSection("Server-side scripts [FE]")
FESection:NewToggle("Show Vote Menu", "Be able to vote for disasters!", function(state)
    if state then
		votemenu.Visible=true
		Lib.prompt('Success!', 'The vote menu has been enabled. Please allow up to 5 seconds for it to appear.', 5)
    else
        votemenu.Visible=false
		Lib.prompt('Success!', 'The vote menu has been disabled.', 3)
    end
end)
FESection:NewToggle("Ear Destroyer [Sound Spammer]", "Spam sounds to destroy everyone's ears.", function(state)
	getgenv().SSToggled = state
	Lib.prompt('Warning', 'This function is very loud and could damage your hearing if on high volumes for long periods of time. Please be careful.', 10)
	Lib.prompt('Warning', 'This function may delay your chat messages by minutes. We have no control over this. Sorry for the inconvinience.', 10)
end)
FESection:NewButton("See next disaster", "Predict the next disaster.", function() 
	local Character = game:GetService("Players").LocalPlayer.Character
	local Tag = Character:FindFirstChild("SurvivalTag")
	if Tag then
		Lib.prompt("Disaster detected!", "The disaster is: " ..Tag.Value, 5)
	end
end)

local TeleportSection = Teleport:NewSection("Teleport - Teleport around the game map!")
TeleportSection:NewButton("Teleport to Lobby", "Teleports you to the waiting area.", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 178, 379)
	Lib.prompt('Success!', 'You have been teleported to the waiting area.', 3)
end)
TeleportSection:NewButton("Teleport to Map", "Teleports you to the game area.", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(106, 55, 3)
	Lib.prompt('Success!', 'You have been teleported to the map.', 3)
end)
TeleportSection:NewButton("Teleport to Mars", "Teleports you really high up in the air.", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(106, 5000, 3)
	Lib.prompt('Success..?', 'You have been teleported to Mars. Except... it doesnt exist. Not in this experience.', 5)
end)

local AutoSection = Automation:NewSection("Automation - Farm/Automate things")
AutoSection:NewToggle("Farm Wins", "Automatically TPs you to lobby every game for wins.", function(state)
	getgenv().FWToggled = state
	--game.Players.LocalPlayer.Character.Humanoid.Health = 0
	if (state == true) then 
		Lib.prompt("Success!", "Now farming wins.", 3)
	end
	if(state == false) then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 178, 379)
		Lib.prompt("Note", "No longer farming wins.", 3)
		Lib.prompt("Note", "Please allow up to 10 seconds for the module to fully disable itself.", 5)
	end
end)

local SettingsSection = Settings:NewSection("Settings - Configure this script!")
SettingsSection:NewDropdown("Theme Selector", "Changes the look of the GUI", {"Light", "Dark [Default]", "Grape", "Blood", "Ocean", "Midnight", "Sentinel", "Synapse", "Serpent"}, function(currentOption)
	if(currentOption == "Dark [Default]") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(74, 99, 135))
		Library:ChangeColor("Background", Color3.fromRGB(36, 37, 43))
		Library:ChangeColor("Header", Color3.fromRGB(28, 29, 34))
		Library:ChangeColor("TextColor", Color3.fromRGB(255,255,255))
		Library:ChangeColor("ElementColor", Color3.fromRGB(32, 32, 38))
	elseif(currentOption == "Light") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(150, 150, 150))
		Library:ChangeColor("Background", Color3.fromRGB(255,255,255))
		Library:ChangeColor("Header", Color3.fromRGB(200, 200, 200))
		Library:ChangeColor("TextColor", Color3.fromRGB(0,0,0))
		Library:ChangeColor("ElementColor", Color3.fromRGB(224, 224, 224))
	elseif(currentOption == "Blood") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(227, 27, 27))
		Library:ChangeColor("Background", Color3.fromRGB(10, 10, 10))
		Library:ChangeColor("Header", Color3.fromRGB(5, 5, 5))
		Library:ChangeColor("TextColor", Color3.fromRGB(255,255,255))
		Library:ChangeColor("ElementColor", Color3.fromRGB(20, 20, 20))
	elseif(currentOption == "Grape") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(166, 71, 214))
		Library:ChangeColor("Background", Color3.fromRGB(64, 50, 71))
		Library:ChangeColor("Header", Color3.fromRGB(36, 28, 41))
		Library:ChangeColor("TextColor", Color3.fromRGB(255,255,255))
		Library:ChangeColor("ElementColor", Color3.fromRGB(74, 58, 84))
	elseif(currentOption == "Ocean") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(86, 76, 251))
		Library:ChangeColor("Background", Color3.fromRGB(26, 32, 58))
		Library:ChangeColor("Header", Color3.fromRGB(38, 45, 71))
		Library:ChangeColor("TextColor", Color3.fromRGB(200, 200, 200))
		Library:ChangeColor("ElementColor", Color3.fromRGB(38, 45, 71))
	elseif(currentOption == "Midnight") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(26, 189, 158))
		Library:ChangeColor("Background", Color3.fromRGB(44, 62, 82))
		Library:ChangeColor("Header", Color3.fromRGB(57, 81, 105))
		Library:ChangeColor("TextColor", Color3.fromRGB(255, 255, 255))
		Library:ChangeColor("ElementColor", Color3.fromRGB(52, 74, 95))
	elseif(currentOption == "Sentinel") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(230, 35, 69))
		Library:ChangeColor("Background", Color3.fromRGB(32, 32, 32))
		Library:ChangeColor("Header", Color3.fromRGB(24, 24, 24))
		Library:ChangeColor("TextColor", Color3.fromRGB(119, 209, 138))
		Library:ChangeColor("ElementColor", Color3.fromRGB(24, 24, 24))
	elseif(currentOption == "Synapse") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(46, 48, 43))
		Library:ChangeColor("Background", Color3.fromRGB(13, 15, 12))
		Library:ChangeColor("Header", Color3.fromRGB(36, 38, 35))
		Library:ChangeColor("TextColor", Color3.fromRGB(152, 99, 53))
		Library:ChangeColor("ElementColor", Color3.fromRGB(24, 24, 24))
	elseif(currentOption == "Serpent") then
		Library:ChangeColor("SchemeColor", Color3.fromRGB(0, 166, 58))
		Library:ChangeColor("Background", Color3.fromRGB(31, 41, 43))
		Library:ChangeColor("Header", Color3.fromRGB(22, 29, 31))
		Library:ChangeColor("TextColor", Color3.fromRGB(255,255,255))
		Library:ChangeColor("ElementColor", Color3.fromRGB(22, 29, 31))
	end

	Lib.prompt("Theme changed!", "Theme has successfuly been changed to " .. currentOption, 3)
end)
SettingsSection:NewKeybind("Keybind - Toggle GUI", "Toggles the GUI visibility.", Enum.KeyCode.LeftAlt, function()
	Library:ToggleUI()
end)

-- Loops

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().SSToggled then
        wait(0.5)
		print(game:GetService("SoundService").RespectFilteringEnabled)
		for _, sound in next, workspace:GetDescendants() do
   			if sound:IsA("Sound") then
       			sound:Play()
			end
		end
    end
	if getgenv().FWToggled then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 180, 379)
		game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position+workspace.Camera.CFrame.lookVector*100)
    end
	if getgenv().PDToggled then
	end
end)
