


---@param banco DtwResource
---@param email string
---@return table
function user_delete_banco(banco, email)

  local users = banco.sub_resource(USERS_BANCO)

  local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

  if user_finding == nil then

    return serjao.send_text(USER_NOT_FOUND, 404)

  end

  user_finding.destroy()

  banco.commit()

  return serjao.send_text(USER_SUCCESSFULY_DELETED)

end