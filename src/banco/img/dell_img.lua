





---@param banco DtwResource
---@param user_finding DtwResource
---@param id string
---@return serjaoResponse
function Dell_one_img_banco(banco, user_finding, id)

    local dir_images = user_finding.sub_resource(IMGS_BANCO)

    banco.commit()

    local response, size = dir_images.map(
        function(element)
            
            local id_foto = dtw.newPath(element.get_path_string()).get_only_name()

            if id == id_foto then
                element.destroy()
                return {result = true}
            end

            return {result = false}
        end
    )

    local tem = false

    for i=1, size do
        if response[i].result == true then
            tem = true
        end
    end

    if not tem then
        return serjao.send_text(ID_NOT_IMG, 404)
    end

    banco.commit()

    return serjao.send_text("Imagem na posição " .. id .. " deletada do banco.", 200)
end

