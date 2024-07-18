


---@param banco DtwResource
---@param user DtwResource
---@return serjaoResponse
function Remove_img_perfil(banco, user)

    local dir_perfil = user.sub_resource(DIR_PERFIL)

    local file_perfil_name = nil

    local files, size = dir_perfil.list()

    for i = 1, size do
        local path_only_name = dtw.newPath(files[i].get_path_string()).get_name()

        if path_only_name ~= BOOL_PERFIL then
            file_perfil_name = path_only_name
        end
    end

    if not file_perfil_name then
        return serjao.send_text(ID_NOT_IMG, 500)
    end

    dir_perfil.set_value_in_sub_resource(BOOL_PERFIL, false)
    dir_perfil.sub_resource(file_perfil_name).destroy()

    banco.commit()

    return serjao.send_text(IMG_DELL, 200)
end

