local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrinkObject = require(ReplicatedStorage.ShrinkObject)
local ExpandObject = require(ReplicatedStorage.ExpandObject)
local GetRandomPosition = require(ReplicatedStorage.GetRandomPosition)

local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Floor = game.Workspace.Floor.floor

local COIN_COUNT = 50
local COIN_SIZE = 1.5

local coins = {}

local function moveCoin(Coin)
	Coin.Position = GetRandomPosition(COIN_SIZE)
	Coin.Transparency = 0
end

local function createCoin()
	if #coins < COIN_COUNT then
		local coin = ServerStorage.Models.Coins.Coin["Coin"]:Clone()
		coin.Size = Vector3.new(COIN_SIZE, COIN_SIZE, 0.2)
		coin.Anchored = true
		coin.CanCollide = false
		coin.Position = GetRandomPosition(COIN_SIZE)
		coin.Parent = Floor

		for _, child in pairs(coin:GetDescendants()) do
			if child:IsA("Decal") then
				print("Decal Face:", child.Face) -- Verifica a face aplicada
				child.Face = Enum.NormalId.Front -- Ajuste para a face frontal, se necessário
			end
		end
		
		

		local endSize = coin.Size
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
						ExpandObject(coin, endSize)
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

