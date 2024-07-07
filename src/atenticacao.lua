

---@param headers Headders
---@param banco DtwResource
---@return boolean,serjaoResponse|nil
function Altentica_root(headers, banco)
  local possivel_header_root = headers.obtem_headder("root_max")

  if headers.erro then
  	return false,headers.erro
  end

  if possivel_header_root == SENHA_ROOT_MAIN then
    return true
  end

  return false, serjao.send_text("A altenticação falhou", 403)
end