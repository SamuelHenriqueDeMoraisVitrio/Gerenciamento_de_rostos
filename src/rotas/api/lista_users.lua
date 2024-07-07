

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Lista_user(headers, banco)
    local ok, erro = Altentica_root(headers,banco)
  
    if ok == false then
      return erro
    end

    return Describe_users(banco)

end


