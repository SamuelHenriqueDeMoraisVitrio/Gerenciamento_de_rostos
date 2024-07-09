

---@param banco DtwResource
---@param email string
---@return serjaoResponse
function List_imgs_banco(banco, email)
    
    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local dir_images = user_finding.sub_resource(IMGS_BANCO)

    if not dir_images then
        return serjao.send_text(IMG_NOT_FOUND, 404)
    end

    local list, size = user_finding.map(function(element)
       local  
    end)


    return serjao.send_text("Its ok")
end