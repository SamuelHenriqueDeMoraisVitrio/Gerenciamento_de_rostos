


function Empacota_token(id_usuario,id_token,senha_token)
	return id_usuario..id_token..senha_token
end


---@class Token
---@field id_usuario string
---@field id_token string
---@field senha_token string

---@param token string
---@return boolean,Token | string
function Desempacota_token(token)
    local TAMANHO_TOTAL = 50
    if string.len(token) ~TAMANHO_TOTAL then
    	return false,"token invalido"
    end
    local obj_token = {
              id_usuario=string.sub(token,1,15),
              id_token=string.sub(token,16,30),
              senha_token =string.sub(token,31,50)
    }
    return true,obj_token
end