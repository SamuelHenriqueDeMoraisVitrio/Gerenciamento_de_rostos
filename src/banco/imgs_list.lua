

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

    banco.commit()

    local list = dir_images.map(
    function(element)

        local date = element.get_value_from_sub_resource(DATE)

        local convert_date = nil
        if date then
            convert_date = os.date(DATE_FORMATED, date)
        end

        return {
            id_foto = dtw.newPath(element.get_path_string()).get_only_name(),
            data = convert_date
        }
    end)

    return list
end