
---@param banco DtwResource
---@param file string
---@param user_finding DtwResource
---@param extension string
---@return serjaoResponse
function Add_img_banco(banco, file, user_finding, extension)

    local imgs = user_finding.sub_resource(IMGS_BANCO)

    local img_mais_extension = IMG .. extension

    local list, size = imgs.list()
    
    local name_dir = "0"
    local time = 0
    local tem_igual = false

    for i = 1, size do

        local path = dtw.newPath(list[i].get_path_string())
        local dir_in_number = tonumber(path.get_name())

        if time ~= dir_in_number then
            name_dir = tostring(time)
            break
        end

        time = time + 1
        name_dir = tostring(time)
    end

    if size > 13 then
        return serjao.send_text(IMG_FULL, 405)
    end

    imgs.map(function (element)

        local img_request = element.get_value_from_sub_resource(img_mais_extension)
        if img_request == file then
            tem_igual = true
        end
    end)

    if tem_igual then
        return serjao.send_text(IMG_JA_ADD, 400)
    end

    local imgs_now = imgs.sub_resource(name_dir)
    
    
    imgs_now.set_value_in_sub_resource(img_mais_extension, file)
    imgs_now.set_value_in_sub_resource(DATE, os.time())
    
    banco.commit()

    return serjao.send_text(IMG_ADD, 202)
end

