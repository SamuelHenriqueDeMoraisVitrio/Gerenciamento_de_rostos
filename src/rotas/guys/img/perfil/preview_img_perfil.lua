


---@param headders Headders
---@param banco DtwResource
---@return DtwResource|serjaoResponse|nil
function Preview_image_perfil_guys(headders, banco)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local response = Preview_image_perfil_banco(error_or_user)

    return response
end