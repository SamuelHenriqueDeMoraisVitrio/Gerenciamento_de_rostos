

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function List_current(headers, banco)

    local ok, erro_ou_user = Altentica_sem_email(headers,banco,true)

    if not ok then
      return erro_ou_user
    end

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
        return headers.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)

    if not existe then
      return user_or_error_by_email
    end

    local response = List_current_banco(user_or_error_by_email)

    return response

end