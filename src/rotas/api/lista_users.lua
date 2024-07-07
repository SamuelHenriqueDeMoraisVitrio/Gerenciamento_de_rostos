

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Lista_users(headers, banco)
    local ok, erro = Altentica_root(headers,banco)
  
    if ok == false then
      return erro
    end

    local filtragem_nome = headers.obtem_headder_opcional("nome")
    local filtragem_email = headers.obtem_headder_opcional("email")
    local filtragem_saldo_min = headers.obtem_headder_opcional("saldo_min")
    local filtragem_saldo_max = headers.obtem_headder_opcional("saldo_max")

    if filtragem_saldo_min then
        filtragem_saldo_min = tonumber(filtragem_saldo_min)

        if filtragem_saldo_min == nil then
            return serjao.send_text("Saldo minimo não é um numero valido", 404)
        end
    end

    if filtragem_saldo_max then

        filtragem_saldo_max = tonumber(filtragem_saldo_max)

        if filtragem_saldo_max == nil then

            return serjao.send_text("Saldo maximo é um numeoro invalido.", 404)

        end

    end


    return Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)

end

