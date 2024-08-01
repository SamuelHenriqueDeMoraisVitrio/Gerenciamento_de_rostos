---@param banco DtwResource
---@param user DtwResource
---@return serjaoResponse
function Remove_img_perfil(banco, user)
    local imagem = user.sub_resource(IMG_PERFIL)
    imagem.destroy()
    banco.commit()
    return serjao.send_text(IMG_DELL, 200)
end
