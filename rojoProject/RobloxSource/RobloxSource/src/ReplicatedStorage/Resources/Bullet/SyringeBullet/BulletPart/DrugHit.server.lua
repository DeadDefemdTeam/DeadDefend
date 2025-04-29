local part = script.Parent
local bullet = part.Parent
local attacker = bullet:WaitForChild("Attacker")

local virusCopy = require(game.ServerScriptService.VirusCopy)

part.Touched:Connect(function(hitPart)
	local player = game.Players:GetPlayerFromCharacter(hitPart.Parent)
	if player then
		if player == attacker.Value then
			return
		end
		
		player.Character.Humanoid:TakeDamage(bullet.Damage.Value)
		part:Destroy()
	else
		if hitPart.Parent:FindFirstChild("IsVirus") then
			local virus = hitPart.Parent
			virus.Humanoid:TakeDamage(bullet.Damage.Value)
			if virus.Humanoid.Health <= 0 then
				virusCopy:Copy(virus)
				virus:Destroy()
				
				attacker.Value.leaderstats.Score.Value = attacker.Value.leaderstats.Score.Value + 1
			end
			part:Destroy()
		end
	end
end)