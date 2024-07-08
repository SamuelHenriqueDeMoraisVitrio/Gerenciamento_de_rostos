serjao = require("dependencies/serjao_berranteiro/serjao_berranteiro")
dtw = require("dependencies/luaDoTheWorld/luaDoTheWorld")

set_server.single_process = false
set_server.nullterminator = "null"

require("headders")
require("banco.tudo")
require("atenticacao")
require("rotas.tudo")
require("consts")

SENHA_ROOT_MAIN = "senha"

---@param rq Request
local function main_server(rq)

  if rq.route == "/" then
    
    return serjao.send_file("pages/index.html")

  end


  if not dtw.starts_with(rq.route, API) then
    
    local arquivo = dtw.concat_path("pages", rq.route)

    arquivo = arquivo .. ".html"

    if dtw.isfile(arquivo) then
      
      return serjao.send_file(arquivo)

    end

    return serjao.send_file("pages/not_found.html", 404)

  end


  local banco = add_banco()
  local headders = Cria_headders(rq.header)

  if API .. ADD .. USER == rq.route then
    return Cria_user_server(headders, banco)
  end

  if API .. LIST .. USER == rq.route then
    return Lista_users(headders, banco)
  end

  if API .. INCREASES .. BALANCE == rq.route then
    return Registrar_transacoes_rota(headders,banco, 1)
  end

  if API .. DECREASES .. BALANCE == rq.route then
    return Registrar_transacoes_rota(headders, banco, -1)
  end

  if API .. DELETE .. USER == rq.route then
    
    return delete_user(headders, banco)
  end

  if API .. LIST .. USER .. CURRENT == rq.route then
    
    return list_current(headders, banco)

  end

  return ROTA_NAO_ENCONTRADA, 404
end

serjao.server(3000, 5000, main_server)

