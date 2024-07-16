



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

    local img = dir_img.get_value_from_sub_resource(IMG)

    return serjao.send_raw(img, TYPE_JPEG, 200)

end

