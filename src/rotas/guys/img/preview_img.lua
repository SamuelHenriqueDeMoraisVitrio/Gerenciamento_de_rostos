

---@param params Params
---@param banco DtwResource
---@return serjaoResponse
function Preview_img_guys(params, banco)

    local ok, error_or_user = Altentica_params(params, banco, false)

    if not ok then
        return error_or_user
    end

    local id = params.obtem_param_numerico(ID)

    if params.erro then
        return params.erro
    end

    id = tostring(id)

    if not id then
        return serjao.send_text(VALUE_INVALID, 400)
    end

    local response = Preview_img_banco(error_or_user, id)

    return response
end

