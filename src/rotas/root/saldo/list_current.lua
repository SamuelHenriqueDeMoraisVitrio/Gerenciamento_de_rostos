

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function list_current(headers, banco)

    local ok, erro_ou_user = Altentica(headers,banco,true)

    if not ok then
      return erro_ou_user
    end

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
        return headers.erro
    end

    local response = list_current_banco(banco, email)


    return response

end