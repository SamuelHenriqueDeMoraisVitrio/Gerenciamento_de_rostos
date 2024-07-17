



---@param user_finding DtwResource
---@param id number
---@return serjaoResponse
function Preview_img_banco(user_finding, id)

    local dir_images = user_finding.sub_resource(IMGS_BANCO).list()

    id = id + 1

    if not dir_images[id] then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    local dir_img = dir_images[id]

    local dir_img_list, size = dir_img.list()

    local extension = nil
    local content_type = nil

    for i=1, size do
        local name_file_by_path = dtw.newPath(dir_img_list[i].get_path_string()).get_extension()
        if name_file_by_path ~= "" or name_file_by_path ~= nil then

            content_type, extension = Convert_extension_for_content_type(name_file_by_path)
        end
    end

    if not content_type then

        return serjao.send_text(ID_NOT_IMG, 500)
    end

    local img = dir_img.get_value_from_sub_resource(IMG .. extension)

    return serjao.send_raw(img, content_type, 200)
end

