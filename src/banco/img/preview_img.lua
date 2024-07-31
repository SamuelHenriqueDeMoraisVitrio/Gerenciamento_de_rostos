



---@param user_finding DtwResource
---@param id number
---@return serjaoResponse
function Preview_img_banco(user_finding, id)

    local dir_images = user_finding.sub_resource(IMGS_BANCO)

    if not dir_images then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    local response, size_map = dir_images.map(
        function(element)
            
            local id_foto = dtw.newPath(element.get_path_string()).get_only_name()

            if id == id_foto then
                element.destroy()
                return {result = true, finding_dir_id = element}
            end

            return {result = false}
        end
    )

    local tem = false
    local dir_img = nil

    for i=1, size_map do
        if response[i].result == true then
            tem = true
            dir_img = response[i].finding_dir_id
        end
    end

    if not tem or not dir_img then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

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

