local function ExpandObject(object, endSize)
	local duration = 0.3
	local startSize = object.Size
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