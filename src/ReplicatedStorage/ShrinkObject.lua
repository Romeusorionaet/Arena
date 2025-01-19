function ShrinkObject(object)
	local duration = 0.2
	local startSize = object.Size
	local endSize = Vector3.new(0, 0, 0)
	local startTime = tick()

	while tick() - startTime < duration do
		local elapsedTime = tick() - startTime
		local sizeFactor = 1 - (elapsedTime / duration)
		object.Size = startSize * sizeFactor
		object.CFrame = object.CFrame

		task.wait(0.03)
	end

	object.Size = endSize
	object.Transparency = 1
end

return ShrinkObject