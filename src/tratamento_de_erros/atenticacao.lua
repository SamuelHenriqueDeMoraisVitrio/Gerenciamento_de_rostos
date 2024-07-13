

---@param headers Headders
---@param banco DtwResource
---@return boolean,serjaoResponse|DtwResource|nil
function Altentica_root(headers,banco)

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
  	   return false,serjao.send_text(token_ou_erro,405)
  end
  local ok,usuario_ou_erro= Valida_token(banco,token_ou_erro)
  return ok,usuario_ou_erro
end