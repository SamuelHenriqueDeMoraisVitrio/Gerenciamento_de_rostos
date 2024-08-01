---@param user DtwResource
---@return serjaoResponse
function Preview_image_perfil_banco(user)
    local imagem = user.sub_resource(IMG_PERFIL)
    if imagem.get_type() ~= 'file' then
        serjao.send_text("foto de perfil não existe", 404)
    end
    return serjao.send_raw(imagem.get_value(), TYPE_JPEG, 200)
end
