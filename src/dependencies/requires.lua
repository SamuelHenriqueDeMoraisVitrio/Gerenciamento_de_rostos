

---@param path string
---@return nil
function require_dir(path)

    local concat_path  = false
    local files,size = dtw.list_files(path, concat_path)

    for i=1,size do

        local path_formated = dtw.newPath(string.format("%s/%s", path, files[i]))
        local require_final = path_formated.get_dir() .. path_formated.get_only_name()
        require(require_final)

    end
end


