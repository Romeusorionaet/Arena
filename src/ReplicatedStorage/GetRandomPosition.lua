local Floor = game.Workspace.Floor.floor

local function GetRandomPosition(ObjectSize)
	local floorSize = Floor.Size
	local floorPosition = Floor.Position
	local randomX = math.random(floorPosition.X - floorSize.X / 2, floorPosition.X + floorSize.X / 2)
	local randomZ = math.random(floorPosition.Z - floorSize.Z / 2, floorPosition.Z + floorSize.Z / 2)
	local yPosition = floorPosition.Y + floorSize.Y / 2 + ObjectSize / 2

	return Vector3.new(randomX, yPosition, randomZ)
end

return GetRandomPosition