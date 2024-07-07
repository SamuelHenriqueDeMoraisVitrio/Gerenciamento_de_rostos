

local date = "%Y-%m-%d %H:%M:%S"

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

---@param banco DtwResource
---@param filtragem_nome string | nil
---@param filtragem_email string | nil
---@param filtragem_saldo_min number | nil
---@param filtragem_saldo_max number | nil
---@param number number
---@return table
function set_saldo(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max, number)

  local list = Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)

  if list == nil then
    
    return {"Esse usuario não existe", 404}

  end

  if number == nil or number == 0 then

    return {"Numero para requisição de set_saldo invalido", 400}

  end

  local users = banco.sub_resource("usuarios")
  
  local list_users_saldo = {}
  for index_user, user_list in ipairs(list) do
    
    local user_email_list = user_list.email

    local user_finding = users.get_resource_matching_primary_key("email", user_email_list)
    
    local name_user = user_finding.get_value_from_sub_resource("nome")
    local saldo_user = user_finding.get_value_from_sub_resource("saldo")
    
    
    if not saldo_user then
      
      return {"saldo salvo em banco é invalido", 500}
      
    end

    saldo_user = tonumber(saldo_user)
    if not saldo_user then
     
      return {"saldo não é um número válido", 500}

    end
    
    saldo_user = saldo_user + number

    list_users_saldo[index_user] = {nome = name_user, saldo = saldo_user}
    
    user_finding.set_value_in_sub_resource("saldo", saldo_user)

    local time = os.date(date)

    local current_user = user_finding.sub_resource("current")

    current_user.set_value_in_sub_resource(time, saldo_user)

  end
  
  banco.commit()

  return {list_users_saldo, 201, true}

end

---@param banco DtwResource
---@param email string
---@return table
function user_delete_banco(banco, email)

  local users = banco.sub_resource("usuarios")

  local user_finding = users.get_resource_matching_primary_key("email", email)

  if not user_finding then
    
    return {"Usuario não encontrado", 404}

  end

  user_finding.destroy()

  banco.commit()

 
  return {"Usuario excluido com suscesso", 200}

end

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

