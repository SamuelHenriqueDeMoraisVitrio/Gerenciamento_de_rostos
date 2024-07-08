
---@class DescricaoUsuario
---@field nome string
---@field email string
---@field saldo number

---@param banco DtwResource
---@param filtragem_nome string | nil
---@param filtragem_email string | nil
---@param filtragem_saldo_min number | nil
---@param filtragem_saldo_max number | nil
---@return DescricaoUsuario[],number
function Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)

  local users = banco.sub_resource(USERS_BANCO)

  local list,size = users.schema_map(function(element)

    local nome = element.get_value_from_sub_resource(NOME_BANCO)
    local email = element.get_value_from_sub_resource(EMAIL_BANCO)
    local saldo = element.get_value_from_sub_resource(SALDO_BANCO)

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

  return list,size
end
