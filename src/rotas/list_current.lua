

---@param headers table
---@param banco DtwResource
---@return serjaoResponse
function list_current(headers, banco)

    local email = headers.obtem_headder(EMAIL)

    if headers.erro then
        return headers.erro
    end

    local response = list_current_banco(banco, email)


    return response

end