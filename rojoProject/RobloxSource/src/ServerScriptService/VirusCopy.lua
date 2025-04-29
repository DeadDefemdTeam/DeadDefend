local VirusCopy = {}

function VirusCopy:Copy(virus)
	local rna = virus.RNA:Clone()
	
	local objectValue = Instance.new("ObjectValue", rna)
	objectValue.Name = "Virus"
	local virusClone = game.ReplicatedStorage[virus.Name]
	objectValue.Value = virusClone
	
	local numberValue = Instance.new("NumberValue", rna)
	numberValue.Name = "SpreadTime"
	numberValue.Value = virus.SpreadTime.Value

	rna:SetPrimaryPartCFrame(virus.PrimaryPart.CFrame)
	rna.VirusSpread.Disabled = false
	rna.Parent = game.Workspace
	
	local deadEffect = virus.DeadEffect.Value:Clone()
	deadEffect.Parent = game.Workspace
	deadEffect:SetPrimaryPartCFrame(virus:GetPrimaryPartCFrame())
end

return VirusCopy
