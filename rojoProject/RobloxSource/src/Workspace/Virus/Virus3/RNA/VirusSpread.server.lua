local random = Random.new()
local spread = script.Parent

wait(random:NextInteger(script.Parent.SpreadTime.Value, script.Parent.SpreadTime.Value + 10))

local virus = spread.Virus.Value:Clone()
virus.Parent = game.Workspace
virus:SetPrimaryPartCFrame(CFrame.new(spread.Part.Position))
virus.Virus.Disabled = false

spread:Destroy()