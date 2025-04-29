script.Parent.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player and player.Character then
		local maskObject = player.Character:FindFirstChild("MaskObject")
		if maskObject and maskObject.Value then
			local mask = maskObject.Value
			if mask.DefenseType.Value ~= 3 then
				player.Character.Humanoid.Health = 0
			end
		else
			player.Character.Humanoid.Health = 0
		end
	end
end)