local function ExpandObject(object, object_SIZE)
	local duration = 0.3
	local startSize = object.Size
	local endSize = Vector3.new(object_SIZE, object_SIZE, object_SIZE)
	local startTime = tick()

	while tick() - startTime < duration do
		local elapsedTime = tick() - startTime
		local sizeFactor = elapsedTime / duration
		object.Size = startSize + (endSize - startSize) * sizeFactor
		object.CFrame = object.CFrame

		task.wait(0.03)
	end

	object.Size = endSize
end

return ExpandObject