


---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return DtwResource|serjaoResponse|nil
function Add_img_perfil_guys(headders, banco, body)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local file = body.obtem_body(1500000)
    local content_type = headders.obtem_headder(CONTENT_TYPE)

    if headders.erro then
        return headders.erro
    end

    if body.erro then
        return body.erro
    end

    print(content_type)

    local extension_name, extension = Convert_content_type_for_extension(content_type)

    if not extension_name then
        return serjao.send_text(VALUE_INVALID, 400)
    end

    local response = Add_img_perfil_banco(banco, error_or_user, file, extension)

    return response
end


