serjao = require("dependencies/serjao_berranteiro/serjao_berranteiro")
dtw = require("dependencies/luaDoTheWorld/luaDoTheWorld")
require("dependencies/requires")
require("consts")

require_dir("tratamento_de_erros")
require_dir("autentica")

require_dir_recursively("banco")
require_dir_recursively("rotas")

SENHA_ROOT_MAIN = SENHA_ROOT_MAX
SENHA_ROOT_READ = SENHA_ROOT_READ

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
  local body = Cria_body(rq.read_body)


  if API .. ADD .. TOKEN_ROUTE == rq.route then
    return Cria_token(headders, banco)
  end

  if API .. ADD .. USER == rq.route then
    return Cria_user_server(headders, banco)
  end

  if API .. LIST .. USER == rq.route then
    return Lista_users(headders, banco)
  end

  if API .. INCREASES .. BALANCE .. LOTE == rq.route then

    return Registrar_transacoes_rota(headders,banco, 1)
  end

  if API .. DECREASES .. BALANCE .. LOTE == rq.route then

    return Registrar_transacoes_rota(headders, banco, -1)
  end

  if API .. INCREASES .. BALANCE .. USER == rq.route then

    return Registra_transacao_por_email(headders, banco, 1)

  end
  if API .. DECREASES .. BALANCE .. USER == rq.route then

    return Registra_transacao_por_email(headders, banco, -1)

  end

  if API .. DELETE .. USER == rq.route then

    return Delete_user(headders, banco)
  end

  if API .. LIST .. USER .. CURRENT == rq.route then

    return List_current(headders, banco)

  end

  if API .. ADD .. IMAGEM == rq.route then

    return Add_img(headders, banco, body)
  end

  if API .. DELETE .. ALL .. IMAGEM == rq.route then

    return Dell_all_imgs(headders, banco)
  end

  if API .. LIST .. ALL .. IMAGEM == rq.route then

    return List_imgs(headders, banco)
  end

  if API .. PREVIEW .. IMAGEM == rq.route then

    return Preview_img(headders, banco)
  end

  if API .. DELETE .. IMAGEM == rq.route then

    return Dell_one_img(headders, banco)
  end

  if API .. LIST .. USER .. CURRENT .. GUYS == rq.route then

    return List_current_guys(headders, banco)
  end

  if API .. ADD .. IMAGEM .. GUYS == rq.route then

    return Add_img_guys(headders, banco, body)
  end

  if API .. DELETE .. ALL .. IMAGEM .. GUYS == rq.route then

    return Dell_all_imgs_guys(headders, banco)
  end

  if API .. LIST .. ALL .. IMAGEM .. GUYS == rq.route then

    return List_all_imgs_guys(headders, banco)
  end

  if API .. PREVIEW .. IMAGEM .. GUYS == rq.route then

    return Preview_img_guys(headders, banco)
  end

  if API .. DELETE .. IMAGEM .. GUYS == rq.route then

    return Dell_one_img_guys(headders, banco)
  end

  if API .. USER == rq.route then
    return Retorna_dados_do_user(headders, banco)
  end

  return ROTA_NAO_ENCONTRADA, 404
end

serjao.server(3000, 5000, main_server)

