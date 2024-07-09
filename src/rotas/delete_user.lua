

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function delete_user(headers, banco)


    local ok, erro = Altentica_root(headers)
  
    if ok == false then
      return erro
    end

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
      
      return headers.erro

    end

    local response = user_delete_banco(banco, email)

    return response
    
end

