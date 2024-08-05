


---@param banco DtwResource
---@param metrics string
---@return serjaoResponse
function Comper_banco(banco, metrics)

    local users = banco.sub_resource(USERS_BANCO)
    local value = users.sub_resource(VALUE_BANCO)

    local find_metrics = value.find(function(element)

        local imgs = element.sub_resource(IMGS_BANCO)
        local values, size = imgs.sub_resource(VALUE_BANCO).list()

        if size < 1 then
            return false
        end

        local acerts = {}
        for i = 1, size do
            local metrics_banco = values[i].sub_resource(FACE_METRICS).get_string()
            local compar = extract.compar(tostring(metrics), metrics_banco)

            if i == 1 and not compar then
                break
            end

            if compar == true then
                acerts[i] = compar
            end
        end

        if #acerts >= (40/100) * size then
            return true
        end
    end)

    if not find_metrics then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    return registra_saldo_email(banco, find_metrics, VALOR_DEBITADO_POR_FACE)
end

