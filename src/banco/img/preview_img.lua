



---@param banco DtwResource
---@param email string
---@param id number
---@return serjaoResponse
function preview_img_banco(banco, email, id)

    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local dir_images, size = user_finding.sub_resource(IMGS_BANCO).list()

    id = id + 1
    if size < id then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    local dir_img = dir_images[id]

    local img = dir_img.get_value_from_sub_resource(IMG)

    return serjao.send_raw(img, TYPE_JPEG, 200)

end

