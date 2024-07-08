

---@param banco DtwResource
---@param email string
---@return serjaoResponse
function list_current_banco(banco, email)


    local users = banco.sub_resource(USERS_BANCO)

    local user = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if user == nil then
        
        return serjao.send_text(USER_NOT_FOUND, 404)
    end


    local transactions = user.sub_resource(TRANSACOES_BANCO)

    local list, size = transactions.map(function(element)
        
        local valor = element.get_value_from_sub_resource(VALOR_BANCO_TRANSACOES)
        local data = element.get_value_from_sub_resource(DATA_BANCO_TRANSACOES)
        local valor_total = element.get_value_from_sub_resource(SALDO_NOW_BANCO_TRANSACOES)

        local data_convertida = os.date(DATE_FORMATED, data)

        return {
            valor = valor,
            data = data_convertida,
            saldo = valor_total
        }

    end)

    return serjao.send_json(list, 200)


end


