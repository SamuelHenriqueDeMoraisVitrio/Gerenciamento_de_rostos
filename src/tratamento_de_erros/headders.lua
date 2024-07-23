

---@class Headders
---@field erro serjaoResponse |nil
---@field obtem_headder fun(nome:string,default:string|nil):string | nil
---@field obtem_headder_numerico fun(nome:string,default:string|nil):number | nil
---@field obtem_headder_booleano fun(nome:string, default:string|nil):boolean | nil
---@field obtem_headder_opcional fun(nome:string):string | nil
---@field obtem_headder_numerico_opcional fun(nome:string):number | nil
---@field obtem_headder_booleano_opcional fun(nome:string):boolean | nil
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
        
        return nil
    end

    tabela.obtem_headder_numerico = function (nome, default)
        
    	local valor = tabela.obtem_headder(nome, default)
    	if valor == nil then
    		return nil
    	end

        local valor_convertido = tonumber(valor)
        if valor_convertido == nil then
            tabela.erro = serjao.send_text("headder "..nome.." não é um número")
        end
        return valor_convertido
    end


    tabela.obtem_headder_opcional = function (nome)
        if tabela.erro then
        	return nil
        end

        return tabela.headers[nome]
    end


    tabela.obtem_headder_numerico_opcional = function (nome)
        local valor = tabela.obtem_headder_opcional(nome)
        if valor == nil then
        	return nil
        end

        local valor_convertido = tonumber(valor)
        if valor_convertido == nil then
        	tabela.erro = serjao.send_text("headder "..nome.." não é um número")
        end
        return valor_convertido

    end

    tabela.obtem_headder_booleano = function (nome, default)

        local valor = tabela.obtem_headder(nome, default)

        if valor == nil then
    		return nil
    	end

        if valor == "true" then
            return true
        end

        if valor == "false" then
            return false
        end

        tabela.erro = serjao.send_text("headder "..nome.." não é um valor booleano.")
        return false
    end

    tabela.obtem_headder_booleano_opcional = function (nome)

        local valor = tabela.obtem_headder_opcional(nome)
        if valor == "true" then
            return true
        end

        if valor == "false" then
            return false
        end

        return nil
    end

    return tabela

end