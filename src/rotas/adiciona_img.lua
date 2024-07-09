

---@param headders Headders
---@param banco DtwResource
---@param body Request
---@return serjaoResponse
function Add_img(headders, banco, body)
    
    local ok, erro = Altentica_root(headders)

    if not ok then
        
        return erro
    end

    local email = headders.obtem_headder(EMAIL)
    local file = body.obtem_body(1500000)

    if headders.erro then
        return headders.erro
    end

    if body.erro then
        return body.erro
    end

    local response = Add_img_banco(banco, file, email)

    return response
end