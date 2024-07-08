


---@param banco DtwResource
---@param email string
---@return table
function user_delete_banco(banco, email)

  local users = banco.sub_resource("usuarios")

  local user_finding = users.get_resource_matching_primary_key("email", email)

  if user_finding == nil then

    return {"Usuario não encontrado", 404}

  end

  user_finding.destroy()

  banco.commit()

  return {"Usuario excluido com suscesso", 200}

end