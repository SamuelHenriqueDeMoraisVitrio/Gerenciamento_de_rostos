
---@class DescricaoUsuario
---@field nome string
---@field email string
---@field saldo number
---@field root boolean
---@field imagens number

---@param banco DtwResource
---@param filtragem_nome string | nil
---@param filtragem_email string | nil
---@param filtragem_saldo_min number | nil
---@param filtragem_saldo_max number | nil
---@param filtragem_root boolean | nil
---@param filtragem_img_min number | nil
---@param filtragem_img_max number | nil
---@return DescricaoUsuario[], number
function Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max, filtragem_root, filtragem_img_min, filtragem_img_max)

  local users = banco.sub_resource(USERS_BANCO)

  local list,size = users.schema_map(function(element)

    local nome = element.get_value_from_sub_resource(NOME_BANCO)
    local email = element.get_value_from_sub_resource(EMAIL_BANCO)
    local saldo = element.get_value_from_sub_resource(SALDO_BANCO)
    local root = element.sub_resource(ROOT_BANCO).get_bool()
    local sub_imgs, size = element.sub_resource(IMGS_BANCO).list()

    if "number" == type(email) then
      email = string.format("%d", email)
    end

    if filtragem_nome ~= nome and filtragem_nome then
      return nil
    end

    if filtragem_email ~= email and filtragem_email then
      return nil
    end

    if filtragem_root ~= root and filtragem_root ~= nil then
      return nil
    end

    if filtragem_saldo_min then
      if filtragem_saldo_min > saldo then
        return nil
      end
    end

    if filtragem_saldo_max then
      if filtragem_saldo_max < saldo then
        return nil
      end
    end

    if filtragem_img_min then
      if filtragem_img_min > size then
        return nil
      end
    end

    if filtragem_img_max then
      if filtragem_img_max < size then
        return nil
      end
    end

    return {
      nome = nome,
      email = email,
      saldo = saldo,
      root = root,
      imagens = size
    }
  end)

  return list,size
end
