
---@class Altentica_raw
---@field Altentica fun(headers:Headders, banco:DtwResource, precisa_ser_root:boolean):boolean,serjaoResponse|nil
---@field Altentica_params fun(params:Params, banco:DtwResource, precisa_ser_root:boolean):boolean,serjaoResponse|nil
---@field Altentica_sem_email fun(headers:Headders, banco:DtwResource, precisa_ser_root:boolean):boolean,serjaoResponse|nil

---@param headers Headders
---@param banco DtwResource
---@param precisa_ser_root boolean
---@return Altentica_raw
---@return Altentica_raw
function Altentica(headers,banco,precisa_ser_root)

  local possivel_root_max = headers.obtem_headder_opcional(ROOT_MAX)
  if possivel_root_max then

    local root_max_sha = dtw.generate_sha(possivel_root_max)
    if root_max_sha == SENHA_ROOT_MAIN then

      local possivel_email_response = headers.obtem_headder(EMAIL)

      if headers.erro then
        return false, headers.erro
      end

      local existe, user_or_error_by_email = User_finding_by_email(banco, possivel_email_response)

      if not existe then
        return false, user_or_error_by_email
      end

      return true, user_or_error_by_email
    end
    return false, serjao.send_text(ALTENTICA_FALHOU, 403)
  end

  local token_raw = headers.obtem_headder(TOKEN)
  if headers.erro then
  	return false, headers.erro
  end

  local ok,token_ou_erro = Desempacota_token(token_raw)

  if not ok then
  	   return false, serjao.send_text(token_ou_erro, 403)
  end
  local ok,usuario_ou_erro= Valida_token(banco,token_ou_erro,precisa_ser_root)

  return ok,usuario_ou_erro
end



---@param params Params
---@param banco DtwResource
---@param precisa_ser_root boolean
---@return Altentica_raw
---@return Altentica_raw
function Altentica_params(params, banco, precisa_ser_root)

  --local possivel_root_max = params.obtem_param_opcional(ROOT_MAX)
  --if possivel_root_max then

      --local root_max_sha = dtw.generate_sha(possivel_root_max)
      --if root_max_sha == SENHA_ROOT_MAIN then
        --return true
      --end
      --return false, serjao.send_text(ALTENTICA_FALHOU, 403)
  --end

  local token_raw = params.obtem_param(TOKEN)
  if params.erro then
  	   return false, params.erro
  end

  local ok_token, token_ou_erro = Desempacota_token(token_raw)

  if not ok_token then
  	   return false, serjao.send_text(token_ou_erro, 403)
  end
  local ok, usuario_ou_erro= Valida_token(banco,token_ou_erro,precisa_ser_root)

  return ok,usuario_ou_erro
end



---@param headers Headders
---@param banco DtwResource
---@param precisa_ser_root boolean
---@return Altentica_raw
---@return Altentica_raw
function Altentica_sem_email(headers,banco,precisa_ser_root)

  local possivel_root_max = headers.obtem_headder_opcional(ROOT_MAX)
  if possivel_root_max then

    local root_max_sha = dtw.generate_sha(possivel_root_max)
    if root_max_sha == SENHA_ROOT_MAIN then

      return true, serjao.send_text("erro no banco", 500)
    end
    return false, serjao.send_text(ALTENTICA_FALHOU, 403)
  end

  local token_raw = headers.obtem_headder(TOKEN)
  if headers.erro then
  	return false, headers.erro
  end

  local ok,token_ou_erro = Desempacota_token(token_raw)

  if not ok then
  	   return false, serjao.send_text(token_ou_erro, 403)
  end
  local ok,usuario_ou_erro= Valida_token(banco,token_ou_erro,precisa_ser_root)

  return ok,usuario_ou_erro
end