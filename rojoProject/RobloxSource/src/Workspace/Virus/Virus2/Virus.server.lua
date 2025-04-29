local virus = script.Parent

local virusCopy = require(game.ServerScriptService.VirusCopy)

if not game.ReplicatedStorage:FindFirstChild(virus.Name) then
	local copy = virus:Clone()
	copy.Parent = game.ReplicatedStorage
end

while true do
	wait(virus.CD.Value)
	
	virus.LeftTime.Value = virus.LeftTime.Value - virus.CD.Value
	
	if virus.LeftTime.Value <= 0 then
		virusCopy:Copy(virus)
		virus:Destroy()
		return
	end
	
	for index = 1, virus.ShootNum.Value, 1 do
		local currentCFrame = CFrame.Angles(0, math.rad((index - 1) * 360 / virus.ShootNum.Value), 0)
		
		local bullet = virus.Bullet.Value:Clone()
		bullet:SetPrimaryPartCFrame(CFrame.new(virus.PrimaryPart.Position, virus.PrimaryPart.Position + currentCFrame.LookVector))
		
		local objectValue = Instance.new("ObjectValue", bullet)
		objectValue.Value = virus
		objectValue.Name = "Attacker"
		
		local bodyForce = Instance.new("BodyForce", bullet.PrimaryPart)
		bodyForce.Force = Vector3.new(0, game.Workspace.Gravity * bullet.PrimaryPart:GetMass(), 0)
	
		local bodyVelocity = Instance.new("BodyVelocity", bullet.PrimaryPart)
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.Velocity = currentCFrame.LookVector * bullet.Speed.Value
		
		bullet.Parent = game.Workspace
		
		local debris = game:GetService("Debris")
		debris:AddItem(bullet, bullet.LeftTime.Value)
	end
end