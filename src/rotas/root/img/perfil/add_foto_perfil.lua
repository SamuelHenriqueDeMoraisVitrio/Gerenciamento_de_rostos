


---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return DtwResource|serjaoResponse|nil
function Add_img_perfil(headders, banco, body)

    local ok, error_or_user = Altentica_sem_email(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local file, extension = body.obtem_body_img_extension()
    local email = headders.obtem_headder(EMAIL_BANCO)

    if headders.erro then
        return headders.erro
    end

    if body.erro then
        return body.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
        return user_or_error_by_email
    end

    local response = Add_img_perfil_banco(banco, user_or_error_by_email, file, extension)

    return response
end


