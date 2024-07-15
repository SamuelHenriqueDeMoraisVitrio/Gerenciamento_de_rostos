

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function List_imgs(headders, banco)

    local ok, erro = Altentica(headders, banco, true)

    if not ok then
        return erro
    end

    local email = headders.obtem_headder(EMAIL)

    if headders.erro then
        return headders.erro
    end

    local response = List_imgs_banco(banco, email)

    return response
end

