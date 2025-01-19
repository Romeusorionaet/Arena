local DataSystem = {}

local INITIAL_COINS = 100
local INITIAL_GEMS = 1

function DataSystem:NewData(Player)
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = Player

	local Coin = Instance.new("IntValue")
	Coin.Name = "Coins"
	Coin.Value = INITIAL_COINS

	local Gem = Instance.new("IntValue")
	Gem.Name = "Gems"
	Gem.Value = INITIAL_GEMS

	Coin.Parent = Leaderstats
	Gem.Parent = Leaderstats
end

return DataSystem
