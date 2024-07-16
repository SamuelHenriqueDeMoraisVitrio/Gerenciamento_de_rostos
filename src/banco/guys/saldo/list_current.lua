

---@param erro_or_user DtwResource
---@return serjaoResponse
function List_current_banco_guys(erro_or_user)

    local transactions = erro_or_user.sub_resource(TRANSACOES_BANCO)

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