while true do
	wait()
	if game.Players.LocalPlayer.Character then
		script.Parent:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame())
	end
end
