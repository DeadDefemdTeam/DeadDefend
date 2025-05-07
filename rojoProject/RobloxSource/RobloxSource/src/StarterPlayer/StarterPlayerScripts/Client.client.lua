local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameManager = require(ReplicatedStorage.Script.BaseSetting.GameManager)
local ConfigMagager = require(ReplicatedStorage.Script.BaseSetting.ConfigManager)

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	ConfigMagager.Init()
	GameManager.Init()
end)