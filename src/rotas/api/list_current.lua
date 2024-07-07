

---@param headers table
---@param banco DtwResource
---@return serjaoResponse | nil
function list_current(headers, banco)

    local ok, erro = Altentica_root(headers,banco)

    if ok == false then
      return erro
    end

    local email = headers.obtem_headder("email")

    if headers.erro then
        return headers.erro
    end

    local response = list_current_banco(banco, email)

    return serjao.send_text("Final", 200)

end