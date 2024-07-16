

---@param headders Headders
---@param banco DtwResource
---@param body Request
---@return serjaoResponse
function Add_img(headders, banco, body)

    local ok, erro_ou_user = Altentica(headders, banco, true)

    if not ok then
      return erro_ou_user
    end

    local email = headders.obtem_headder(EMAIL)
    local file = body.obtem_body(1500000)

    if headders.erro then
        return headders.erro
    end

    if body.erro then
        return body.erro
    end

    local users = banco.sub_resource(USERS_BANCO)

    local user_finding = users.get_resource_matching_primary_key(EMAIL_BANCO, email)

    if not user_finding then
        return serjao.send_text(USER_NOT_FOUND, 404)
    end

    local response = Add_img_banco(banco, file, user_finding)

    return response
end