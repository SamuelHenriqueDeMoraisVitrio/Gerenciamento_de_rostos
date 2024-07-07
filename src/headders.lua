

---@class Headders
---@field erro serjaoResponse |nil
---@field obtem_headder fun(nome:string,default:string|nil):string | nil
---@field existe fun(nome:string):boolean


---@param headers table
---@return Headders
function Cria_headders(headers)

    local tabela = {}
    tabela.headers = headers
    tabela.erro = nil

    tabela.existe = function (nome)
    	  local resultado = tabela.headers[nome]
    	  if resultado then
    	  	return true
    	  end
    	  return false
    end
    tabela.obtem_headder = function (nome,default)
        if tabela.erro then
        	return nil
        end
    	local resultado = tabela.headers[nome]
    	if resultado then
    		return resultado
    	end
        if default then
        	return default
        end

    	tabela.erro = serjao.send_text("headder "..nome.." não informado",404)
    end


    return tabela

end