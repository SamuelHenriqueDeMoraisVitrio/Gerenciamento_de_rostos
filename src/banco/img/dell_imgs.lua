

---@param banco DtwResource
---@param email string
---@return serjaoResponse
function Dell_imgs_banco(banco, email)
    
    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local imgs_dir = user_finding.sub_resource(IMGS_BANCO)

    imgs_dir.destroy()

    banco.commit()

    return serjao.send_text(IMG_DELL)
end