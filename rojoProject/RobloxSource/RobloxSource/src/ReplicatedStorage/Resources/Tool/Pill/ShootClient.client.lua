local tool = script.Parent
local isCD = false
local bulletNumTextLabel = nil

tool.Equipped:Connect(function()
	bulletNumTextLabel = game.Players.LocalPlayer.PlayerGui.MainUI.Root.BulletNumFrame.BulletNum
	bulletNumTextLabel.Text = tool.BulletNum.Value
end)

tool.Activated:Connect(function()
	if not isCD then
		local mouse = game.Players.LocalPlayer:GetMouse()
		bulletNumTextLabel.Text = tool.BulletNum.Value - 1
		game.ReplicatedStorage.RemoteEvent.ShootEvent:FireServer(mouse.Hit.Position)
		isCD = true
		wait(tool.CD.Value)
		isCD = false
	end
end)

tool.Unequipped:Connect(function()
	bulletNumTextLabel.Text = 0
end)