---@param headders Headders
---@param banco DtwResource
---@param body Body
---@return serjaoResponse
function Compar_image_by_metrics(headders, banco, body)

    local ok, error_or_user = Altentica_sem_email(headders, banco, true)

    if not ok then
        return error_or_user
    end

    local file = body.obtem_body_img_extension()

    if body.erro then
        return body.erro
    end

    local converted = imageMgk.convert_to_jpeg(file)

    local metrics = extract.extract(converted)

    if not metrics then
        return serjao.send_text(FACE_NOT_FOUND, 404)
    end

    local response = Comper_banco(banco, metrics)

    return response
end
