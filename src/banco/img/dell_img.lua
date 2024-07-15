





---@param banco DtwResource
---@param email string
---@param id number
---@return serjaoResponse
function Dell_one_img_banco(banco, email, id)

    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local dir_images, size = user_finding.sub_resource(IMGS_BANCO).list()

    id = id + 1

    if not dir_images[id] then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    dir_images[id].destroy()

    banco.commit()

    return serjao.send_text("Imagem deletada do banco.", 200)
end

