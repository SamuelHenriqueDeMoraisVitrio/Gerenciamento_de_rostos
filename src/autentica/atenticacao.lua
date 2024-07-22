


---@param headers Headders
---@param banco DtwResource
---@param precisa_ser_root boolean
---@return boolean 
---@return serjaoResponse|DtwResource|nil
function Altentica(headers,banco,precisa_ser_root)

  local possivel_root_max = headers.obtem_headder_opcional(ROOT_MAX)
  if possivel_root_max then

      local root_max_sha = dtw.generate_sha(possivel_root_max)
      if root_max_sha == SENHA_ROOT_MAIN then
        return true
      end
      return false, serjao.send_text(ALTENTICA_FALHOU, 403)
  end

  local token_raw = headers.obtem_headder(TOKEN)
  if headers.erro then
  	   return headers.erro
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
---@return boolean
---@return serjaoResponse|DtwResource|nil
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
  	   return params.erro
  end

  local ok_token, token_ou_erro = Desempacota_token(token_raw)

  if not ok_token then
  	   return false, serjao.send_text(token_ou_erro, 403)
  end
  local ok, usuario_ou_erro= Valida_token(banco,token_ou_erro,precisa_ser_root)

  return ok,usuario_ou_erro
end


