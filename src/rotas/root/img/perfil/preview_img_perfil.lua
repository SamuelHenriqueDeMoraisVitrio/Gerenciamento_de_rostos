


---@param headders Headders
---@param banco DtwResource
---@return DtwResource|serjaoResponse|nil
function Preview_image_perfil(headders, banco)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local email = headders.obtem_headder(EMAIL)

    if headders.erro then
        return headders.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
        return user_or_error_by_email
    end

    local response = Preview_image_perfil_banco(user_or_error_by_email)

    return response
end