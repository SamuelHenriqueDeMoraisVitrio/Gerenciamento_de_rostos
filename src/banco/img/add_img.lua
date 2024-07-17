
---@param banco DtwResource
---@param file string
---@param user_finding DtwResource
---@param extension string
---@return serjaoResponse
function Add_img_banco(banco, file, user_finding, extension)

    local imgs = user_finding.sub_resource(IMGS_BANCO)

    --local img_mais_extension = IMG .. extension
    --print(img_mais_extension)

    local list, size = imgs.list()

    local name_dir = "0"
    local time = 0

    print("size", size)

    if size == 0 then
        goto continue
    end

    --print("list 3", list[3].get_path_string())
    --print("list 4", list[4].get_path_string())
    for i = 1, size do
        print("i_in_for", i)
        print("size", size)
        print("path_in_for", list[i].get_path_string())
        local path = dtw.newPath(list[i].get_path_string())
        local dir_in_number = tonumber(path.get_name())

        print("get_name", dir_in_number)
        print("time", time)

        if time ~= dir_in_number then
            name_dir = tostring(time)
            break
        end

        time = time + 1
        name_dir = tostring(time)
    end

    print(name_dir)

    if size > 13 then
        return serjao.send_text(IMG_FULL, 405)
    end

    ::continue::

    local imgs_now = imgs.sub_resource(name_dir)

    print(imgs_now.get_path_string())

    imgs_now.set_value_in_sub_resource("imagem.jpg", file)
    imgs_now.set_value_in_sub_resource(DATE, os.time())

    banco.commit()

    print("Chegou aq")

    return serjao.send_text(IMG_ADD, 202)
end