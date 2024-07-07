serjao = require("dependencies/serjao_berranteiro/serjao_berranteiro")
dtw = require("dependencies/luaDoTheWorld/luaDoTheWorld")

set_server.single_process = false
set_server.nullterminator = "null"

require("headders")
require("banco/users")
require("atenticacao")
require("rotas/tudo")

SENHA_ROOT_MAIN = "senha"

---@param rq Request
local function main_server(rq)
  local banco = add_banco()
  local headders = Cria_headders(rq.header)

  if "/api/add_user" == rq.route then
    return Cria_user_server(headders, banco)
  end

  if "/api/list_users" == rq.route then
    return Lista_users(headders, banco)
  end

  if "/api/incrementasaldo" == rq.route then
    
    return seting_saldo(headders, banco)
  end

  if "/api/decrementasaldo" == rq.route then
    return seting_saldo(headders, banco, true)
  end

  if "/api/excluir/user" == rq.route then
    
    return { nada = "null"}

  end

  return "Rota não encontrada", 404
end

serjao.server(3000, 5000, main_server)

