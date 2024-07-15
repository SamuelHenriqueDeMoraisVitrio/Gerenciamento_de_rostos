



---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Dell_one_img(headders, banco)

    local ok, erro = Altentica(headders, banco, true)

    if not ok then
        return erro
    end

    local email = headders.obtem_headder(EMAIL)
    local id = headders.obtem_headder_numerico(ID)

    if headders.erro then
        return headders.erro
    end

    if id < 0 or id > 12 then
        return serjao.send_text(ID_INVALID, 400)
    end

    local response = Dell_one_img_banco(banco, email, id)

    return response
    
end


