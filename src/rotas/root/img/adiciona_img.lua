

---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return serjaoResponse
function Add_img(headders, banco, body)

    local ok, erro_ou_user = Altentica_sem_email(headders, banco, true)

    if not ok then
      return erro_ou_user
    end

    local email = headders.obtem_headder(EMAIL)
    local file, extension = body.obtem_body_img_extension()

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

    local response = Add_img_banco(banco, file, user_or_error_by_email, extension)

    return response
end