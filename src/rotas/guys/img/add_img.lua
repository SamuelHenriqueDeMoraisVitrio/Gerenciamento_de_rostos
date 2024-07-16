

---@param headders Headders
---@param banco DtwResource
---@param body Request
---@return serjaoResponse
function Add_img_guys(headders, banco, body)

    local ok, erro_or_user = Altentica(headders, banco, false)

    if not ok then
        return erro_or_user
    end

    local file = body.obtem_body(1500000)

    if body.erro then
        return body.erro
    end

    local response = Add_img_banco(banco, file, erro_or_user)

    return response

end