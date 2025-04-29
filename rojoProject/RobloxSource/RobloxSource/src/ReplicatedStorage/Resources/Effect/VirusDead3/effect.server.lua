local tweenService = game:GetService("TweenService")
local tween = tweenService:Create(script.Parent.Out, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = Vector3.new(100,100,100), Transparency = 1})
tween:Play()
tween = tweenService:Create(script.Parent.In, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = Vector3.new(80,80,80), Transparency = 1})
tween:Play()

local debris = game:GetService("Debris")
debris:AddItem(script.Parent, 0.5)