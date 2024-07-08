

---@param banco DtwResource
---@param nome string
---@param email string
---@param senha string
---@param root boolean
---@param saldo number
---@return boolean ,string | nil
function Add_user(banco, nome, email, senha, root, saldo)

  local users = banco.sub_resource(USERS_BANCO)
  local user_add = users.schema_new_insertion()

  user_add.set_value_in_sub_resource(NOME_BANCO, nome)
  user_add.set_value_in_sub_resource(SALDO_BANCO, saldo)

  local ok, erro = user_add.try_set_value_in_sub_resource(EMAIL_BANCO, email)

  if ok == false then
    return false, erro
  end

  user_add.set_value_in_sub_resource(ROOT_BANCO, root)

  local sha_senha = dtw.generate_sha(senha)

  user_add.set_value_in_sub_resource(SENHA_BANCO, sha_senha)

  return true
end
