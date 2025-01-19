local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrinkObject = require(ReplicatedStorage.ShrinkObject)
local ExpandObject = require(ReplicatedStorage.ExpandObject)

local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Floor = game.Workspace.Floor.floor

local COIN_COUNT = 50
local COIN_SIZE = 1.5 --Need fix coin size for be like a real coin

local coins = {}

local function getRandomPosition()
	local floorSize = Floor.Size
	local floorPosition = Floor.Position
	local randomX = math.random(floorPosition.X - floorSize.X / 2, floorPosition.X + floorSize.X / 2)
	local randomZ = math.random(floorPosition.Z - floorSize.Z / 2, floorPosition.Z + floorSize.Z / 2)
	local yPosition = floorPosition.Y + floorSize.Y / 2 + 3 / 2

	return Vector3.new(randomX, yPosition, randomZ)
end

local function moveCoin(Coin)
	Coin.Position = getRandomPosition()
	Coin.Transparency = 0
end

local function createCoin()
	if #coins < COIN_COUNT then
		local coin = ServerStorage.Models.ModelsCoin.Coin["Coin"]:Clone()
		coin.Size = Vector3.new(COIN_SIZE, COIN_SIZE, COIN_SIZE)
		coin.Anchored = true
		coin.CanCollide = false
		coin.Position = getRandomPosition()
		coin.Parent = Floor

		local touchConnection = nil
		local Debounce = false

		local function onTouch(hit)
			if not Debounce then
				local character = hit.Parent

				if character:FindFirstChild("Humanoid") then
					Debounce = true
					local Player = Players:FindFirstChild(hit.Parent.Name)

					if not Player then return end

					local Leaderstats = Player:WaitForChild("leaderstats")

					ShrinkObject(coin)

					Leaderstats.Coins.Value += 1

					if touchConnection then
						touchConnection:Disconnect()
					end

					task.delay(5, function()
						moveCoin(coin)
						Debounce = false
						ExpandObject(coin, COIN_SIZE)
						touchConnection = coin.Touched:Connect(onTouch)
					end)
				end
			end
		end

		touchConnection = coin.Touched:Connect(onTouch)

		table.insert(coins, coin)

		return coin
	end
end

local function initializeCoins()
	for i = 1, COIN_COUNT do
		createCoin()
	end
end

initializeCoins()

