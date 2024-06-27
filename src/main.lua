serjao = require("dependencies/serjao_berranteiro/serjao_berranteiro")
dtw = require("dependencies/luaDoTheWorld/luaDoTheWorld")

require("banco/users")
require("atenticacao")
require("rotas/cria_user")

SENHA_ROOT_MAIN = "senha"

---@param rq Request
local function main_server(rq)
  local banco = add_banco()

  if "/add_user" == rq.route then
    return cria_user_server(rq, banco)
  end

  return "Rota não encontrada", 404
end

serjao.server(3000, main_server)