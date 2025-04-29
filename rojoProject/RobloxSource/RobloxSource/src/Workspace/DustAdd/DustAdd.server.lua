script.Parent.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player and player.Character and not player.Character:FindFirstChild("Dust") then
		local maskObject = player.Character:FindFirstChild("MaskObject")
		if not maskObject or not maskObject.Value then
			local dust = game.ServerStorage.Script.Dust:Clone()
			dust.Parent = player.Character
		end
		game.ReplicatedStorage.RemoteEvent.FogEvent:FireClient(player, 1)
	end
end)