local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrinkObject = require(ReplicatedStorage.ShrinkObject)
local ExpandObject = require(ReplicatedStorage.ExpandObject)
local GetRandomPosition = require(ReplicatedStorage.GetRandomPosition)

local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Floor = game.Workspace.Floor.floor

local BALL_COUNT = 50
local BALL_SIZE = 1.5

local fragments = {}

local function moveBall(ball)
	ball.Position = GetRandomPosition(BALL_SIZE)
	ball.Transparency = 0
end

local function createFragment()
	if #fragments < BALL_COUNT then
		local fragment = ServerStorage.Models.Fragments.Blob["Blob"]:Clone()
		fragment.Size = Vector3.new(BALL_SIZE, BALL_SIZE, BALL_SIZE)
		fragment.BrickColor = BrickColor.random()
		fragment.Anchored = true
		fragment.CanCollide = false
		fragment.Position = GetRandomPosition(BALL_SIZE)
		fragment.Parent = Floor

		local endSize = fragment.Size
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

					ShrinkObject(fragment)

					Leaderstats.Fragments.Value += 1

					if touchConnection then
						touchConnection:Disconnect()
					end

					task.delay(5, function()
						moveBall(fragment)
						Debounce = false
						ExpandObject(fragment, endSize)
						touchConnection = fragment.Touched:Connect(onTouch)
					end)
				end
			end
		end

		touchConnection = fragment.Touched:Connect(onTouch)

		table.insert(fragments, fragment)

		return fragment
	end
end

local function initializeBalls()
	for i = 1, BALL_COUNT do
		createFragment()
	end
end

initializeBalls()
