local Players = game:GetService("Players")

local DataSystem = require(script:WaitForChild("DataSystem"))

Players.PlayerAdded:Connect(function(Player)
	print("O jogador: " .. Player.Name .. " entrou no jogo.")
	DataSystem:NewData(Player)
end)