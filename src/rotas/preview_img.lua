

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function preview_img(headders, banco)

    local ok, erro = Altentica_read(headders)

    if not ok then
        return erro
    end

    local email = headders.obtem_headder(EMAIL)
    local id = headders.obtem_headder_numerico(ID)

    if headders.erro then
        return headders.erro
    end

    local response = preview_img_banco(banco, email, id)

    return response
    
end