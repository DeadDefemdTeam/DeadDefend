script.Parent.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player and player.Character then
		local dust = player.Character:FindFirstChild("Dust")
		if dust then
			dust:Destroy()
		end
		game.ReplicatedStorage.RemoteEvent.FogEvent:FireClient(player, 0)
	end
end)