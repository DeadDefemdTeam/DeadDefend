local part = script.Parent
local creater = part.Parent
local isCD = false

part.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player then
		if not isCD then
			if player.Character then
				isCD = true
				local maskObject = player.Character:FindFirstChild("MaskObject")
				if not maskObject then
					maskObject = Instance.new("ObjectValue", player.Character)
					maskObject.Name = "MaskObject"
				end
				
				if maskObject.Value then
					maskObject.Value:Destroy()
				end
				
				local mask = creater.Mask.Value:Clone()
				mask.Parent = player.Character
				maskObject.Value = mask
				
				local position = creater.PrimaryPart.Position
				creater:SetPrimaryPartCFrame(CFrame.new(Vector3.new(position.x, position.y - 1000, position.z)))
				wait(10)
				creater:SetPrimaryPartCFrame(CFrame.new(position))
				isCD = false
			end
		end
	end
end)