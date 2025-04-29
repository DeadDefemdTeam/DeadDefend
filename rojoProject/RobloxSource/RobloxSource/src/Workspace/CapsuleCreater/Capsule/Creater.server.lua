local part = script.Parent
local creater = part.Parent
local isCD = false

part.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player then
		if not isCD then
			isCD = true
			local tool = creater.Tool.Value:Clone()
			tool.Parent = player.Backpack
			local position = creater.PrimaryPart.Position
			creater:SetPrimaryPartCFrame(CFrame.new(Vector3.new(position.x, position.y - 1000, position.z)))
			wait(10)
			creater:SetPrimaryPartCFrame(CFrame.new(position))
			isCD = false
		end
	end
end)