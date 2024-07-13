



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

    local dir_images = user_finding.sub_resource(IMGS_BANCO)

    banco.commit()

    local finding_img = dir_images.sub_resource(string.format("%s", id))

    local list, size = dtw.list_files(string.format("%s", finding_img), false)

    if size > 0 then
        local sla = nil
    end

    return {}

end

