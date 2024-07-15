

---@param banco DtwResource
---@param file string
---@param email string
---@return serjaoResponse
function Add_img_banco(banco, file, email)
    
    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local imgs = user_finding.sub_resource(IMGS_BANCO)

    local list, size = dtw.list_dirs(string.format("%s", imgs))

    if size > 12 then
        return serjao.send_text(IMG_FULL, 405)
    end

    local imgs_now = imgs.sub_resource_next()

    imgs_now.set_value_in_sub_resource(IMG, file)
    imgs_now.set_value_in_sub_resource(DATE, os.time())

    banco.commit()

    return serjao.send_text(IMG_ADD, 202)
end