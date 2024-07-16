

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function List_imgs(headders, banco)

    local ok, erro = Altentica(headders, banco, true)

    if not ok then
        return erro
    end

    local email = headders.obtem_headder(EMAIL)

    if headders.erro then
        return headders.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
        return user_or_error_by_email
    end

    local response = List_imgs_banco(banco, user_or_error_by_email)

    return response
end

