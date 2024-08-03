---@param params Params
---@param banco DtwResource
---@return serjaoResponse
function Preview_img_guys(params, banco)
    local ok, error_or_user = Altentica_params(params, banco, false)

    if not ok then
        return error_or_user
    end

    local id = params.obtem_param(ID)

    if params.erro then
        return params.erro
    end

    local response = Preview_img_banco(error_or_user, id)
    print(response)
    return response
end
