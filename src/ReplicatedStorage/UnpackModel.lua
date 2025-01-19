local function UnpackModel(modelFolder, parentFolder)
    if not parentFolder then
        warn("Parent folder is missing for unpacking the model")
        return
    end

    for _, obj in ipairs(modelFolder:GetChildren()) do
        local clone = obj:Clone()

        if obj:IsA("Folder") then
            local newFolder = parentFolder:FindFirstChild(obj.Name)
            if not newFolder then
                newFolder = Instance.new("Folder")
                newFolder.Name = obj.Name
                newFolder.Parent = parentFolder
            end
            UnpackModel(obj, newFolder)
        else
            clone.Parent = parentFolder
        end
    end
end

return UnpackModel
