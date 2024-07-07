
---@param banco DtwResource
---@param email string
---@return table
function list_current_banco(banco, email)

  local users = banco.sub_resource("usuarios")

  local finding_from_email = users.get_resource_matching_primary_key("email", email)

  local current_user = finding_from_email.sub_resource("current")

  print("finding_from_email: ", finding_from_email, '\n')
  print("current_user", current_user, '\n')

  return {"sla", 200}


end

