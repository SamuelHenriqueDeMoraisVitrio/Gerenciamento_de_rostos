


---@param banco DtwResource
---@param email string
---@return boolean
---@return serjaoResponse
function User_finding_by_email(banco, email)

    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return false, serjao.send_text(USER_NOT_FOUND, 404)
    end

    return true, user_finding

end