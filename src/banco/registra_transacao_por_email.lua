
---@param banco DtwResource
---@param email string
---@param valor number
---@return serjaoResponse
function registra_saldo_email(banco, email, valor)

    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)


    if not user_finding then

    return serjao.send_text(USER_NOT_FOUND, 404)

    end

    local saldo = user_finding.get_value_from_sub_resource(SALDO_BANCO)
    local nome = user_finding.get_value_from_sub_resource(NOME_BANCO)
    local email = user_finding.get_value_from_sub_resource(EMAIL_BANCO)

    if (saldo < (valor * -1) and valor < 0) or valor == 0 then
        return serjao.send_text("valor creditado invalido.")
    end

    local novo_saldo = saldo + valor

    user_finding.set_value_in_sub_resource(SALDO_BANCO, novo_saldo)

    local transacoes  = user_finding.sub_resource(TRANSACOES_BANCO)
    local transacao_atual =  transacoes.sub_resource_next()

    transacao_atual.set_value_in_sub_resource(VALOR_BANCO_TRANSACOES,valor)
    transacao_atual.set_value_in_sub_resource(DATA_BANCO_TRANSACOES,os.time())
    transacao_atual.set_value_in_sub_resource(SALDO_NOW_BANCO_TRANSACOES, novo_saldo)

    local usuario_modificado = {
        nome = nome,
        email = email,
        credito = valor,
        saldo = novo_saldo
    }

    banco.commit()

    return serjao.send_json(usuario_modificado, 202)

end