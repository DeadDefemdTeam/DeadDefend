local part = script.Parent
local bullet = part.Parent

part.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player and player.Character then
		local maskObject = player.Character:FindFirstChild("MaskObject")
		local defense = 0
		if maskObject and maskObject.Value then
			local mask = maskObject.Value
			defense = mask.Defense.Value
		end
		player.Character.Humanoid:TakeDamage(bullet.Damage.Value * (1 - defense / 100))
		part:Destroy()
	end
end)