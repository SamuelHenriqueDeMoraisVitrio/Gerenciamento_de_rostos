
---@return DtwResource
function add_banco()
  local banco = dtw.newResource(BANCO)
  local schema_main = banco.newDatabaseSchema()
  local schema_users = schema_main.sub_schema(USERS_BANCO)
  schema_users.add_primary_keys({EMAIL_BANCO})
  return banco
end

