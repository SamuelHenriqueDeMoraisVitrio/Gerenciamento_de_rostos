

---@param path string
---@return nil
function require_dir(path)

    local concat_path  = true
    local files,size = dtw.list_files(path, concat_path)

    for i=1,size do

        local path_formated = dtw.newPath(string.format("%s", files[i]))
        local extension = path_formated.get_extension()

        if extension == "lua" or extension == "so" then

            local require_final = path_formated.get_dir() .. path_formated.get_only_name()

            require(require_final)
        end

    end
end


---@param path string
---@return nil
function require_dir_recursively(path)

    local concat_path  = true
    local dirs, size = dtw.list_dirs_recursively(path, concat_path)

    for i = 1, size do
        require_dir(string.format("%s", dirs[i]))
    end

end

