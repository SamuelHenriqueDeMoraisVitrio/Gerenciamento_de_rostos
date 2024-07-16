





---@param banco DtwResource
---@param user_finding DtwResource
---@param id number
---@return serjaoResponse
function Dell_one_img_banco(banco, user_finding, id)

    local dir_images = user_finding.sub_resource(IMGS_BANCO).list()

    id = id + 1

    if not dir_images[id] then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    dir_images[id].destroy()

    banco.commit()

    return serjao.send_text("Imagem deletada do banco.", 200)
end

