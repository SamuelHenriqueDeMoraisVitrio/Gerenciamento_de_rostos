

---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return serjaoResponse
function Add_img(headders, banco, body)

    local ok, erro_ou_user = Altentica_sem_email(headders, banco, true)

    if not ok then
      return erro_ou_user
    end

    local email = headders.obtem_headder(EMAIL)
    local file = body.obtem_body_img_extension()

    if headders.erro then
        return headders.erro
    end

    if body.erro then
        return body.erro
    end

    local existe, user_or_error_by_email = User_finding_by_email(banco, email)
    
    if not existe then
        return user_or_error_by_email
    end

    local converted = imageMgk.convert_to_jpeg(file)
    local file_img = imageMgk.image_formated(converted)

    local metrics = extract.extract(converted)

    if not metrics then
        return serjao.send_text(FACE_NOT_FOUND, 404)
    end

    local response = Add_img_banco(banco, file_img, user_or_error_by_email, metrics)

    return response
end