

---@param banco DtwResource
---@param nome string
---@param email string
---@param senha string
---@param root boolean
---@param saldo number
---@return boolean ,string | nil
function Add_user(banco, nome, email, senha, root, saldo)

  local users = banco.sub_resource("usuarios")
  local user_add = users.schema_new_insertion()
  local current = user_add.sub_resource("current")

  user_add.set_value_in_sub_resource("nome", nome)
  user_add.set_value_in_sub_resource("saldo", saldo)

  local formatted_time = os.date(date)
  current.set_value_in_sub_resource(formatted_time, saldo)

  local ok, erro = user_add.try_set_value_in_sub_resource("email", email)

  if ok == false then
    return false, erro
  end

  user_add.set_value_in_sub_resource("root", root)

  local sha_senha = dtw.generate_sha(senha)

  user_add.set_value_in_sub_resource("senha", sha_senha)

  return true
end
