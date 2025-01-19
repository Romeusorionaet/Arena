local DataSystem = {}

local INITIAL_COINS = 0
local INITIAL_GEMS = 0
local INITIAL_FRAGMENTS = 0

function DataSystem:NewData(Player)
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = Player

	local Fragment = Instance.new("IntValue")
	Fragment.Name = "Fragments"
	Fragment.Value = INITIAL_FRAGMENTS

	local Coin = Instance.new("IntValue")
	Coin.Name = "Coins"
	Coin.Value = INITIAL_COINS

	local Gem = Instance.new("IntValue")
	Gem.Name = "Gems"
	Gem.Value = INITIAL_GEMS

	Fragment.Parent = Leaderstats
	Coin.Parent = Leaderstats
	Gem.Parent = Leaderstats
end

return DataSystem
