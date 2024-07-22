
---@class Params
---@field erro serjaoResponse|nil
---@field existe fun(nome:string):boolean
---@field obtem_param fun(nome:string, default:string|nil):nil|string
---@field obtem_param_opcional fun(nome:string):nil|string

---@param Request Request
---@return Params
function Cria_params(Request)

    local table = {}
    table.params = Request
    table.erro = nil

    table.existe = function (nome)
        local resultado = table.params[nome]

        if resultado then
            return true
        end

        return false
    end

    table.obtem_param = function (nome, default)
        if table.erro then
        	return nil
        end

    	local resultado = table.params[nome]
    	if resultado then

    		return resultado
    	end

        if default then

        	return default
        end

    	table.erro = serjao.send_text("Param " .. nome .. " não informado", 404)

        return nil
    end

    table.obtem_param_opcional = function(nome)

        if table.erro then
        	return nil
        end

        return table.params[nome]
    end

    return table
end


