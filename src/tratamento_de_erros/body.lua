
---@class Body
---@field erro serjaoResponse |nil
---@field obtem_body fun(default:number|nil):string|nil


---@param body table
---@return Body
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

    return table
    
end