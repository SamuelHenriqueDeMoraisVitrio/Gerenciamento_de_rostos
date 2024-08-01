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
    local sha_resource = nova_imagem.sub_resource(SHA_IMAGE)
    local ok, error = sha_resource.try_set_value(dtw.generate_sha(file))
    if not ok then
        return serjao.send_text(IMG_JA_ADD, 400)
    end

    nova_imagem.set_value_in_sub_resource(DATE, os.time())
    nova_imagem.set_value_in_sub_resource(IMG, file)
    banco.commit()

    return serjao.send_text(IMG_ADD, 202)
end
