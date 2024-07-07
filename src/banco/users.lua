

---@return DtwResource
function add_banco()
  local banco = dtw.newResource("data")
  local schema_main = banco.newDatabaseSchema()

  local schema_users = schema_main.sub_schema("usuarios")

  schema_users.add_primary_keys({"email"})

  return banco
end

---@param banco DtwResource
---@param nome string
---@param email string
---@param senha string
---@param root boolean
---@return boolean ,string | nil
function Add_user(banco, nome, email, senha, root)

  local users = banco.sub_resource("usuarios")
  local user_add = users.schema_new_insertion()

  user_add.set_value_in_sub_resource("nome", nome)
  user_add.set_value_in_sub_resource("saldo", 100)
  local ok, erro = user_add.try_set_value_in_sub_resource("email", email)

  if ok == false then
    return false, erro
  end

  user_add.set_value_in_sub_resource("root", root)

  local sha_senha = dtw.generate_sha(senha)

  user_add.set_value_in_sub_resource("senha", sha_senha)

  return true
end

---@param banco DtwResource
function Describe_users(banco)

  local users = banco.sub_resource("usuarios")
  local list = users.schema_map(function(element)
  
    return {
      nome = element.get_value_from_sub_resource("nome"),
      email = element.get_value_from_sub_resource("email")
    }

  end)
  
  return nil

end