---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return serjaoResponse
function Add_img_guys(headders, banco, body)
    local ok, erro_or_user = Altentica(headders, banco, false)

    if not ok then
        return erro_or_user
    end

    local file = body.obtem_body_img_extension()

    if body.erro then
        return body.erro
    end

    local converted = imageMgk.convert_to_jpeg(file)
    local file_img = imageMgk.image_formated(converted)

    local metrics = extract.extract(converted)

    if not metrics then
        return serjao.send_text(FACE_NOT_FOUND, 404)
    end

    local response = Add_img_banco(banco, file_img, erro_or_user, metrics)

    return response
end
