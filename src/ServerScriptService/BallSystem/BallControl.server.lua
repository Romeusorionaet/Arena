local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrinkObject = require(ReplicatedStorage.ShrinkObject)
local ExpandObject = require(ReplicatedStorage.ExpandObject)

local ServerStorage = game:GetService("ServerStorage")

local Floor = game.Workspace.Floor.floor

local BALL_COUNT = 50
local BALL_SIZE = 1.5

local balls = {}

local function getRandomPosition()
	local floorSize = Floor.Size
	local floorPosition = Floor.Position
	local randomX = math.random(floorPosition.X - floorSize.X / 2, floorPosition.X + floorSize.X / 2)
	local randomZ = math.random(floorPosition.Z - floorSize.Z / 2, floorPosition.Z + floorSize.Z / 2)
	local yPosition = floorPosition.Y + floorSize.Y / 2 + BALL_SIZE / 2
	return Vector3.new(randomX, yPosition, randomZ)
end

local function moveBall(ball)
	ball.Position = getRandomPosition()
	ball.Transparency = 0
end

local function createBall()
	if #balls < BALL_COUNT then
		local ball = ServerStorage.Models.ModelsBall.HalfBall["Half Ball"]:Clone()
		ball.Size = Vector3.new(BALL_SIZE, BALL_SIZE, BALL_SIZE)
		ball.BrickColor = BrickColor.random()
		ball.Anchored = true
		ball.CanCollide = false
		ball.Position = getRandomPosition()
		ball.Parent = Floor

		local touchConnection = nil
		local Debounce = false

		local function onTouch(hit)
			print('collided')
			if not Debounce then
				local character = hit.Parent

				if character:FindFirstChild("Humanoid") then
					ShrinkObject(ball)
					Debounce = true

					if touchConnection then
						touchConnection:Disconnect()
					end

					task.delay(5, function()
						moveBall(ball)
						Debounce = false
						ExpandObject(ball, BALL_SIZE)
						touchConnection = ball.Touched:Connect(onTouch)
					end)
				end
			end
		end

		touchConnection = ball.Touched:Connect(onTouch)

		table.insert(balls, ball)

		return ball
	end
end

local function initializeBalls()
	for i = 1, BALL_COUNT do
		createBall()
	end
end

initializeBalls()
