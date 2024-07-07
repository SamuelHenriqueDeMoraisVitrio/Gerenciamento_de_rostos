
---@return DtwResource
function add_banco()
  local banco = dtw.newResource("data")
  local schema_main = banco.newDatabaseSchema()
  local schema_users = schema_main.sub_schema("usuarios")
  schema_users.add_primary_keys({"email"})
  return banco
end

