local runService = game:GetService("RunService")

runService.Stepped:Connect(function(allTime, step)
	script.Parent.Orientation = script.Parent.Orientation + Vector3.new(0, step * 90, 0)
end)