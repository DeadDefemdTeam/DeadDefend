function PlayerAdd(player)
	if player:FindFirstChild("leaderstats") == nil then
		print(player.Name .. " joined the game! " .. time())
	
		local stats = Instance.new("IntValue")
		stats.Name = "leaderstats"
	
		local currentScore = Instance.new("IntValue")
		currentScore.Name = "Score"
		currentScore.Parent = stats
		
		stats.Parent = player
	end
end

game.Players.PlayerAdded:Connect(PlayerAdd)

for _, player in pairs(game.Players:GetPlayers()) do
	PlayerAdd(player)
end