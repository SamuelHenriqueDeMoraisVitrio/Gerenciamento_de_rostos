

---@class Getextension
---@field Get_image_info_extension fun(content:any)string|nil,string|nil
---@field Convert_extension_for_content_type fun(extension:string):string|nil,string|nil
---@field Convert_content_type_for_extension fun(content_type:string):string|nil,string|nil

---@param content any
---@return string|nil
---@return string|nil
function Get_image_info_extension(content)

    if #content < 8 then
        return nil  -- Tipo genérico para conteúdo desconhecido
    end

    local header = content:sub(1, 8)

    if header:sub(1, 8) == "\137PNG\r\n\26\n" then
        return "image/png", ".png"
    elseif header:sub(1, 3) == "\255\216\255" then
        return "image/jpeg", ".jpg"
    elseif header:sub(1, 6) == "GIF87a" or header:sub(1, 6) == "GIF89a" then
        return "image/gif", ".gif"
    elseif header:sub(1, 2) == "BM" then
        return "image/bmp", ".bmp"
    else
        return nil
    end

end


---@param extension string
---@return string | nil
---@return string | nil
function Convert_extension_for_content_type(extension)

    if extension == "png" then
        return "image/png", ".png"
    end

    if extension == "jpg" or extension == "jpeg" then

        return "image/jpeg", ".jpg"
    end

    if extension == "gif" then

        return "image/gif", ".gif"
    end

    if extension == "bmp" then

        return "image/bmp", ".bmp"
    end

    return nil, nil
end


---@param content_type string
---@return string | nil
---@return string | nil
function Convert_content_type_for_extension(content_type)

    if content_type == "image/png" then
        return "png", ".png"
    end

    if content_type == "image/jpeg"then

        return "jpg", ".jpg"
    end

    if content_type == "image/gif" then

        return "gif", ".gif"
    end

    if content_type == "image/bmp" then

        return "bmp", ".bmp"
    end

    return nil, nil
end


