

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function delete_user(headers, banco)


    local ok, erro = Altentica_root(headers,banco)
  
    if ok == false then
      return erro
    end

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
      
      return headers.erro

    end

    local response = user_delete_banco(banco, email)

    return serjao.send_text(response[1], response[2])
    
end

