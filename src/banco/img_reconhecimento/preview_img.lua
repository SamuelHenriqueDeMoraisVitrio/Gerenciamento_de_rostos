---@param user_finding DtwResource
---@param id number
---@return serjaoResponse
function Preview_img_banco(user_finding, id)
    local dir_images = user_finding.sub_resource(IMGS_BANCO)
    local imagem = dir_images.get_resource_by_name_id(id)

    if not imagem then
        print("not image")
        return serjao.send_text("foto não encontrada", 404)
    end

    local file = imagem.get_value_from_sub_resource(IMG)
    return serjao.send_raw(file, TYPE_JPEG, 200)
end

