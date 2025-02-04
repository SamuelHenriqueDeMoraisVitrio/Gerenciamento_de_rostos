

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Preview_img(headders, banco)

    local ok, erro_or_user = Altentica_sem_email(headders, banco, true)

    if not ok then
        return erro_or_user
    end

    local email = headders.obtem_headder(EMAIL)
    local id = headders.obtem_headder_numerico(ID)

    if headders.erro then
        return headders.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
        return user_or_error_by_email
    end

    if id < 0 or id > 12 then
        return serjao.send_text(ID_INVALID, 400)
    end

    local response = Preview_img_banco(user_or_error_by_email, id)

    return response
    
end