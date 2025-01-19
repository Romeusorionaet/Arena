local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShrinkObject = require(ReplicatedStorage.ShrinkObject)
local ExpandObject = require(ReplicatedStorage.ExpandObject)
local GetRandomPosition = require(ReplicatedStorage.GetRandomPosition)

local ServerStorage = game:GetService("ServerStorage")

local Floor = game.Workspace.Floor.floor

local BALL_COUNT = 50
local BALL_SIZE = 1.5

local parts = {}

local function moveBall(ball)
	ball.Position = GetRandomPosition(BALL_SIZE)
	ball.Transparency = 0
end

local function createBall()
	if #parts < BALL_COUNT then
		local part = ServerStorage.Models.Fragments.Blob["Blob"]:Clone()
		part.Size = Vector3.new(BALL_SIZE, BALL_SIZE, BALL_SIZE)
		part.BrickColor = BrickColor.random()
		part.Anchored = true
		part.CanCollide = false
		part.Position = GetRandomPosition(BALL_SIZE)
		part.Parent = Floor

		local endSize = part.Size
		local touchConnection = nil
		local Debounce = false

		local function onTouch(hit)
			print("Algo tocou a bola: " .. tostring(hit))

			if not Debounce then
				local character = hit.Parent
				print(character.Name .. " tocou a bola!")

				if character:FindFirstChild("Humanoid") then
					Debounce = true
					ShrinkObject(part)

					if touchConnection then
						touchConnection:Disconnect()
					end

					task.delay(5, function()
						moveBall(part)
						Debounce = false
						ExpandObject(part, endSize)
						touchConnection = part.Touched:Connect(onTouch)
					end)
				end
			end
		end

		touchConnection = part.Touched:Connect(onTouch)

		table.insert(parts, part)

		return part
	end
end

local function initializeBalls()
	for i = 1, BALL_COUNT do
		createBall()
	end
end

initializeBalls()
