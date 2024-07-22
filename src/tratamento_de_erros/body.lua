
---@class Body
---@field erro serjaoResponse|nil
---@field obtem_body fun(default:number|nil):any|nil
---@field obtem_body_img_extension fun(default:number|nil, extension:string|nil):any|nil,string|nil,string|nil


---@param body table
---@return Body
---@return string|nil
---@return string|nil
function Cria_body(body)

    local table = {}
    table.body = body
    table.erro = nil

    table.obtem_body = function (default)

        if table.erro then
            return nil
        end

        if not default then
            default = 1500000
        end

        local result = table.body(default)

        if not result then
            
            table.erro = serjao.send_text(VALUE_INVALID, 404)

            return nil
        end

        return result
    end

    table.obtem_body_img_extension = function (default, extension)

        if default == nil then
            default = 1500000
        end

        local Not_nil = (extension ~= nil)

        local result = table.body(default)
        if not result then
            table.erro = serjao.send_text(VALUE_INVALID, 404)
            return nil
        end

        local content_type, extension_file = Get_image_info_extension(result)

        if content_type == nil then
            table.erro = serjao.send_text(VALUE_INVALID, 400)
            return nil
        end

        if Not_nil and extension ~= extension_file then
            table.erro = serjao.send_text(VALUE_INVALID, 400)
            return nil
        end

        return result, extension_file, content_type

    end

    return table
    
end