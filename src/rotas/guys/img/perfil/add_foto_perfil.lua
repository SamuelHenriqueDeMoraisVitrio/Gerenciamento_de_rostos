


---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return DtwResource|serjaoResponse|nil
function Add_img_perfil_guys(headders, banco, body)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local file, extension = body.obtem_body_img_extension()

    if body.erro then
        return body.erro
    end

    local response = Add_img_perfil_banco(banco, error_or_user, file, extension)

    return response
end


