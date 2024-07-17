

---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return serjaoResponse
function Add_img_guys(headders, banco, body)

    local ok, erro_or_user = Altentica(headders, banco, false)

    if not ok then
        return erro_or_user
    end

    local file, extension = body.obtem_body_img_extension()

    if body.erro then
        return body.erro
    end

    local response = Add_img_banco(banco, file, erro_or_user, extension)

    return response

end