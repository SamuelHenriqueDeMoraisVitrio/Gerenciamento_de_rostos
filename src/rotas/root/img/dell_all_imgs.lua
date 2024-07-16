

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Dell_all_imgs(headders, banco)
   
    local ok, erro_ou_user = Altentica(headders, banco, true)

    if not ok then
      return erro_ou_user
    end

    local email = headders.obtem_headder(EMAIL)

    if headders.erro then
        return headders.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
      return user_or_error_by_email
    end

    local response = Dell_imgs_banco(banco, user_or_error_by_email)

    return response
end