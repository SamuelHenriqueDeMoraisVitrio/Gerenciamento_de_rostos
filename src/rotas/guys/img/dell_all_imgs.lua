


---@param headders Headders
---@param banco DtwResource
---@return DtwResource|serjaoResponse|nil
function Dell_all_imgs_guys(headders, banco)

    local ok, erro_or_user = Altentica(headders, banco, false)

    if not ok then
        return erro_or_user
    end

    local response = Dell_imgs_banco(banco, erro_or_user)

    return response

end