---@param banco DtwResource
---@param file string
---@param user_finding DtwResource
---@return serjaoResponse
function Add_img_banco(banco, file, user_finding)
    local imgs = user_finding.sub_resource(IMGS_BANCO)

    local todas, tamanho = imgs.list()

    if tamanho > 13 then
        return serjao.send_text(IMG_FULL, 405)
    end

    local nova_imagem = imgs.schema_new_insertion()

    local ok, error   = nova_imagem.try_set_value_in_sub_resource(
        SHA_IMAGE, dtw.generate_sha(file)
    )

    if ok == false then
        return serjao.send_text(error, 404)
    end

    nova_imagem.set_value_in_sub_resource(DATE, os.time())
    nova_imagem.set_value_in_sub_resource(IMG, file)
    banco.commit()

    return serjao.send_text(IMG_ADD, 202)
end
