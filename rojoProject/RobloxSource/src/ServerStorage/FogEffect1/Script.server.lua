local tweenService = game:GetService("TweenService")
local childs = script.Parent:GetChildren()

for index = 1, #childs, 1 do
	if childs[index]:IsA("Part") then
		local oldPosition = childs[index].Position
		local tween = tweenService:Create(childs[index], TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true), {Position = oldPosition + Vector3.new(500, 0 ,0)})
		tween:Play()
	end
end