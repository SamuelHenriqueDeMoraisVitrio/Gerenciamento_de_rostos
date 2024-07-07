

---@param headers table
---@param banco DtwResource
---@param decrement boolean | nil
---@return serjaoResponse
function seting_saldo(headers, banco, decrement)

    if decrement == nil then
        decrement = false
    end

    local ok, erro = Altentica_root(headers,banco)
  
    if ok == false then
      return erro
    end


    local filtragem_nome = headers.obtem_headder_opcional("nome")
    local filtragem_email = headers.obtem_headder_opcional("email")
    local filtragem_saldo_min = headers.obtem_headder_opcional("saldo_min")
    local filtragem_saldo_max = headers.obtem_headder_opcional("saldo_max")
    local requisicao_saldo = headers.obtem_headder_opcional("saldo")

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

    if requisicao_saldo then
        
        requisicao_saldo = tonumber(requisicao_saldo)

        if requisicao_saldo == nil then
            return serjao.send_text("Requisição de saldo é invalido", 400)
        end

    end

    if decrement then
        requisicao_saldo = requisicao_saldo * -1
    end

    local response = set_saldo(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max, requisicao_saldo)

    return serjao.send_text(response[1], response[2])
end