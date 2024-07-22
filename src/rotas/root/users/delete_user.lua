

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function Delete_user(headers, banco)

  local ok, erro_ou_user = Altentica_sem_email(headers,banco,true)

  if not ok then
    return erro_ou_user
  end

  local email = headers.obtem_headder(EMAIL)

  if headers.erro then
    return headers.erro
  end

  local response = user_delete_banco(banco, email)

  return response

end

