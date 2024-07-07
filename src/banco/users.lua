

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
---@param filtragem_nome string | nil
---@param filtragem_email string | nil
---@param filtragem_saldo_min number | nil
---@param filtragem_saldo_max number | nil
---@return table
function Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)

  local users = banco.sub_resource("usuarios")
  local list = users.schema_map(function(element)
  
    nome = element.get_value_from_sub_resource("nome")
    email = element.get_value_from_sub_resource("email")
    saldo = element.get_value_from_sub_resource("saldo")

    if filtragem_nome ~= nome and filtragem_nome then
      return nil
    end

    if filtragem_email ~= email and filtragem_email then

      return nil
    
    end

    if filtragem_saldo_min then

      if filtragem_saldo_min >= saldo then

        return nil
      
      end

    end

    if filtragem_saldo_max then
      if filtragem_saldo_max <= saldo then

        return nil
      
      end
    end

    return {
      nome = nome,
      email = email,
      saldo = saldo
    }
  end)

  return list
end

