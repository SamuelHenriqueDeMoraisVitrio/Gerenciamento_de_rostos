



---@param banco DtwResource
---@param user_finding DtwResource
---@param valor number
---@return serjaoResponse
function registra_saldo_email(banco, user_finding, valor)

    local dir_transacao, size = user_finding.sub_resource(TRANSACOES_BANCO).list()
    local time_now = os.time()
    local time_last_transaction = 0
    if size > 0 then
        time_last_transaction = tonumber(dir_transacao[size].get_value_from_sub_resource(DATA_BANCO_TRANSACOES))
    end

    local saldo = user_finding.get_value_from_sub_resource(SALDO_BANCO)
    local nome = user_finding.get_value_from_sub_resource(NOME_BANCO)
    local email = user_finding.get_value_from_sub_resource(EMAIL_BANCO)
    local frequencia = tonumber(user_finding.get_value_from_sub_resource(FREQUENCY_BANCO))

    if not frequencia or not time_last_transaction then
        return serjao.send_text("Problema no banco", 500)
    end

    if (saldo < (valor * -1) and valor < 0) or valor == 0 then
        return serjao.send_text(VALUE_INVALID)
    end

    local novo_saldo = 0
    local frequecie_now = frequencia

    if time_last_transaction < (time_now - ONE_DAY_IN_SECONDS) and (time_last_transaction > (time_now - TWO_DAYS_IN_SECONDS) or size == 0) then

            if frequencia > 10 then
                novo_saldo = saldo + (valor + (valor * 0.1))
            else
                novo_saldo = saldo + (valor + (valor * (frequencia/100)))
            end

        frequecie_now = frequencia + 1
        user_finding.set_value_in_sub_resource(FREQUENCY_BANCO, frequecie_now)
    end

    if time_last_transaction < (time_now - TWO_DAYS_IN_SECONDS) then
        frequecie_now = 0
        user_finding.set_value_in_sub_resource(FREQUENCY_BANCO, frequecie_now)
        novo_saldo = saldo + valor
    else
        novo_saldo = saldo + valor
    end

    user_finding.set_value_in_sub_resource(SALDO_BANCO, novo_saldo)

    local transacoes  = user_finding.sub_resource(TRANSACOES_BANCO)
    local transacao_atual =  transacoes.sub_resource_next()

    transacao_atual.set_value_in_sub_resource(VALOR_BANCO_TRANSACOES,valor)
    transacao_atual.set_value_in_sub_resource(DATA_BANCO_TRANSACOES, time_now)
    transacao_atual.set_value_in_sub_resource(SALDO_NOW_BANCO_TRANSACOES, novo_saldo)

    local usuario_modificado = {
        nome = nome,
        email = email,
        credito = valor,
        saldo = novo_saldo,
        frequencia = frequecie_now
    }

    banco.commit()

    return serjao.send_json(usuario_modificado, 202)
end


