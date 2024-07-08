

---@param banco DtwResource
---@param email string
---@return serjaoResponse
function list_current_banco(banco, email)


    local users = banco.sub_resource("usuarios")

    local user = users.get_resource_matching_primary_key("email", email)

    if user == nil then
        
        return serjao.send_text("Usuario não encontrado", 404)
    end


    local transactions = user.sub_resource("transacoes")

    local list, size = transactions.map(function(element)
        
        local valor = element.get_value_from_sub_resource("valor")
        local data = element.get_value_from_sub_resource("data")
        local valor_total = element.get_value_from_sub_resource("saldo_now")

        local data_convertida = os.date(DATE_FORMATED, data)

        return {
            valor = valor,
            data = data_convertida,
            saldo = valor_total
        }

    end)

    return serjao.send_json(list, 200)


end


