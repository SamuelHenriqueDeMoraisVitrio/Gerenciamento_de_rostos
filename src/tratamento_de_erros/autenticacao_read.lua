

---@param headers Headders
---@return boolean,serjaoResponse|nil
function Altentica_read(headers)
    local possivel_header_root = headers.obtem_headder(ROOT_READ)
  
    if headers.erro then
        return false,headers.erro
    end
  
    local root_read_sha = dtw.generate_sha(possivel_header_root)
  
    if root_read_sha == SENHA_ROOT_READ then
      return true
    end
  
    return false, serjao.send_text(ALTENTICA_FALHOU, 403)
  end