

---@param lista_de_tokens DtwResource[]
---@param tamanho number
local function privado_remove_token_mais_antigo(lista_de_tokens,tamanho)
    local mais_antigo = lista_de_tokens[1]
    local data_mais_antiga = mais_antigo.get_value_from_sub_resource("criacao")
    for i=1,tamanho do
        local atual = lista_de_tokens[i]
        local criacao = atual.get_value_from_sub_resource("criacao")

        if criacao + (EXPIRACAO * 60) <  os.time() then
        	atual.destroy()
        	return
        end

        if criacao < data_mais_antiga then
        	mais_antigo = atual
        end
    end
    mais_antigo.destroy()

end

---@param user DtwResource
---@return string
function Cria_token_banco(user)
	local tokens = user.sub_resource("tokens")
    local todos_tokens,tamanho = tokens.list()
    if tamanho > MAXIMO_DE_TOKENS then
        privado_remove_token_mais_antigo(todos_tokens,tamanho)
    end
    local token = tokens.sub_resource_random()
    token.set_value_in_sub_resource("criacao",os.time())

    local hasher  = dtw.newHasher()
    hasher.digest(dtw.newRandonizer().generate_token(50))
    hasher.digest(user.get_value_from_sub_resource(SENHA))
    hasher.digest(os.time())

    local senha = string.sub(hasher.get_value(),1,20)
    token.set_value_in_sub_resource(SENHA,senha)

    local user_id = dtw.newPath(user.get_path_string()).get_only_name()
    local token_id = dtw.newPath(token.get_path_string()).get_only_name()

    return Empacota_token(user_id,token_id,senha)

end

---@param banco DtwResource
---@param token Token
---@param precisa_ser_root boolean
---@return boolean,serjaoResponse | nil
function  Valida_token(banco,token,precisa_ser_root)
	local users = banco.sub_resource(USERS_BANCO)
	local possivel_usuario = users.get_resource_by_name_id(token.id_usuario)
    if possivel_usuario == nil then
    	return false,serjao.send_text(USER_NOT_FOUND,403)
    end

    if precisa_ser_root then
    	local root = possivel_usuario.get_value_from_sub_resource("root")
    	if root ~= true then
    		return false,serjao.send_text("usuario não é root",403)
    	end

    end
    local tokens = possivel_usuario.sub_resource("tokens")
    local possivel_token = tokens.sub_resource(token.id_token)

    if possivel_token.get_type() == "null" then
    	 return false,serjao.send_text("token invalido",403)
    end

    local senha = possivel_token.sub_resource(SENHA).get_string()
    if senha ~= token.senha_token then
    	return false,serjao.send_text("token invalido",403)
    end

    local criacao = possivel_token.get_value_from_sub_resource("criacao")

    if criacao + (EXPIRACAO * 60) < os.time() then
    	return false,serjao.send_text("token expirado",403)
    end
    return true,possivel_usuario
end
