---@param banco DtwResource
---@param user DtwResource
---@param file any
---@return serjaoResponse
function Add_img_perfil_banco(banco, user, file)
    user.set_value_in_sub_resource(IMG_PERFIL, file)
    banco.commit()
    return serjao.send_text(IMG_ADD, 200)
end
