


---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Dell_img_perfil_guys(headders, banco)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local response = Remove_img_perfil(banco, error_or_user)

    return response
end

