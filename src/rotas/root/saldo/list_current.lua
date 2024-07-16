

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function List_current(headers, banco)

    local ok, erro_ou_user = Altentica(headers,banco,true)

    if not ok then
      return erro_ou_user
    end

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
        return headers.erro
    end

    local users = banco.sub_resource(USERS_BANCO)

    local user = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if user == nil then

      return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local response = List_current_banco(user)

    return response

end