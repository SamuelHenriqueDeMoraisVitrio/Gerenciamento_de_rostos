

---@param banco DtwResource
---@param user_finding DtwResource
---@return serjaoResponse
function Dell_imgs_banco(banco, user_finding)

    local imgs_dir = user_finding.sub_resource(IMGS_BANCO)

    imgs_dir.destroy()

    banco.commit()

    return serjao.send_text(IMG_DELL)
end