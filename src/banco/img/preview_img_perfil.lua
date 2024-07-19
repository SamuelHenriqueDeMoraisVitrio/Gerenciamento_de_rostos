



---@param perfil_dir DtwResource
---@return string | boolean
---@return string | nil
local function perfil_img_for_bool(perfil_dir)
      local perfil, size = perfil_dir.list()
      for i = 1, size do
        local path = dtw.newPath(perfil[i].get_path_string())
        local name_file = path.get_name()

        if name_file ~= BOOL_PERFIL then
            local extension_get = path.get_extension()
            local content = Convert_extension_for_content_type(extension_get)

            return name_file, content
        end
      end
      return false
  end




---@param user DtwResource
---@return serjaoResponse
function Preview_image_perfil_banco(user)

    local dir_perfil = user.sub_resource(DIR_PERFIL)

    local name_file_or_error, content_type = perfil_img_for_bool(dir_perfil)

    if not name_file_or_error then
        return serjao.send_text(IMG_NOT_FOUND, 404)
    end

    local file = dir_perfil.get_value_from_sub_resource(name_file_or_error)

    return serjao.send_raw(file, content_type, 200)
    
end