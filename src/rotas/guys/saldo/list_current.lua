

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function List_current_guys(headders, banco)

    local ok, erro_or_user = Altentica(headders, banco, false)

    if not ok then
        return erro_or_user
    end

    local response = List_current_banco(erro_or_user)

    return response
end

