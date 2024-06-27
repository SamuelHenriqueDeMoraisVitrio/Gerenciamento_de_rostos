
---@param rq Request
---@param banco DtwResource
---@return serjaoResponse
function cria_user_server(rq, banco)
  local ok, erro = altentica_root(rq)

  if ok == false then
    return erro
  end

  local nome = rq.header["nome"]
  if nome == nil then
    return serjao.send_text("O nome não foi informado", 404)
  end

  local email = rq.header["email"]
  if email == nil then
    return serjao.send_text("O email não foi informado", 404)
  end

  local senha = rq.header["senha"]
  if senha == nil then
    return serjao.send_text("A senha não foi informado", 404)
  end

  local root = false

  if rq.header["root"] == "true" then
    root = true
  end

  ok, erro = add_user(banco, nome, email, senha, root)

  if ok then

    banco.commit()

    return serjao.send_text("O usuario foi criado", 202)
  end

  return serjao.send_text(erro, 409)
end