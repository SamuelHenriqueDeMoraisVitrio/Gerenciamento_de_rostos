

---@param rq Request
---@param banco DtwResource
---@return serjaoResponse|nil
function altentica_root(rq, banco)
  local possivel_header_root = rq.header["root_max"]

  if possivel_header_root == SENHA_ROOT_MAIN then
    return true
  end

  return false, serjao.send_text("A altenticação falhou", 403)
end