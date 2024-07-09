

---@param headers Headders
---@return boolean,serjaoResponse|nil
function Altentica_root(headers)
  local possivel_header_root = headers.obtem_headder(ROOT_MAX)

  if headers.erro then
  	return false,headers.erro
  end

  local root_max_sha = dtw.generate_sha(possivel_header_root)

  if root_max_sha == SENHA_ROOT_MAIN then
    return true
  end

  return false, serjao.send_text(ALTENTICA_FALHOU, 403)
end