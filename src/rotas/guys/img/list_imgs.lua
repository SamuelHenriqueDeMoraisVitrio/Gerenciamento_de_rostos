---@param headders Headders
---@param banco DtwResource
---@return DtwResource|serjaoResponse|nil
function List_all_imgs_guys(headders, banco)
    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local response = List_imgs_banco(banco, error_or_user)

    return response
end
