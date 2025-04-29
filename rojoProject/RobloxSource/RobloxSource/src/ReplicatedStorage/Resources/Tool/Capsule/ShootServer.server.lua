local tool = script.Parent

local intValue = Instance.new("IntValue", tool)
intValue.Name = "BulletNum"
intValue.Value = tool.MaxBulletNum.Value

game.ReplicatedStorage.RemoteEvent.ShootEvent.OnServerEvent:Connect(function(player, targetPosition)
	if player.Character == tool.Parent then
		local bullet = tool.Bullet.Value:Clone()
		bullet:SetPrimaryPartCFrame(CFrame.new(tool.Handle.Position, targetPosition))
		
		local objectValue = Instance.new("ObjectValue", bullet)
		objectValue.Value = player
		objectValue.Name = "Attacker"
		
		local bodyForce = Instance.new("BodyForce", bullet.PrimaryPart)
		bodyForce.Force = Vector3.new(0, game.Workspace.Gravity * bullet.PrimaryPart:GetMass(), 0)
		
		local bodyVelocity = Instance.new("BodyVelocity", bullet.PrimaryPart)
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.Velocity = (targetPosition - tool.Handle.Position).Unit * bullet.Speed.Value
		
		bullet.Parent = game.Workspace
		
		local debris = game:GetService("Debris")
		debris:AddItem(bullet, bullet.LeftTime.Value)
		
		intValue.Value = intValue.Value - 1
		if intValue.Value <= 0 then
			tool:Destroy()
		end
	end
end)