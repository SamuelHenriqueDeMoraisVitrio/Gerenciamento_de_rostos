
---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Cria_token(headers, banco)

    local email = headers.obtem_headder(EMAIL)
    local senha = headers.obtem_headder(SENHA)

    if headers.erro then
    	return headers.erro
    end

     local users = banco.sub_resource(USERS_BANCO)
     local possivel_usurio = users.get_resource_matching_primary_key(EMAIL_BANCO, email)
     if possivel_usurio == nil then
     	return serjao.send_text(USER_NOT_FOUND,404)
     end

     local sha_da_senha = dtw.generate_sha(senha)
     local senha_real = possivel_usurio.sub_resource(SENHA).get_string()
     if sha_da_senha ~= senha_real then
     	return serjao.send_text("senha inválida",403)
     end

    local expira =  os.time() + (EXPIRACAO * 60)

    --ta garantido que a senha ta certa
    local token  = Cria_token_banco(possivel_usurio)
    local expiracao_str = os.date(DATE_FORMATED,expira)
    banco.commit()
    return {
        token_criado = token,
        expira = expiracao_str
    }
end