---@param user_finding DtwResource
---@param id number
---@return serjaoResponse
function Preview_img_banco(user_finding, id)
    local dir_images = user_finding.sub_resource(IMGS_BANCO)
    local imagem = dir_images.get_resource_by_name_id(id)
    return serjao.send_raw(imagem.get_value(), TYPE_JPEG, 200)
end
