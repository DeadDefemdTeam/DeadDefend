game.ReplicatedStorage.RemoteEvent.FogEvent.OnClientEvent:Connect(function(flag)
	if game.Players.LocalPlayer.Character then
		local fogEffect = game.Players.LocalPlayer.Character:FindFirstChild("FogEffect")
		if flag == 1 then
			if not fogEffect then
				local fog = game.ReplicatedStorage.Resources.FogEffect:Clone()
				fog.Parent = game.Players.LocalPlayer.Character
			end
		else
			if fogEffect then
				fogEffect:Destroy()
			end
		end
	end
end)