---@param banco DtwResource
---@param user_finding DtwResource
---@param id string
---@return serjaoResponse
function Dell_one_img_banco(banco, user_finding, id)
    local dir_images = user_finding.sub_resource(IMGS_BANCO)
    local imagem_para_deletar = dir_images.get_resource_by_name_id(id)
    imagem_para_deletar.destroy()
    banco.commit()
    return serjao.send_text("imagem deletada", 200)
end
