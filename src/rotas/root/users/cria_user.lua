

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Cria_user_server(headers, banco)
  local ok, erro_ou_user = Altentica(headers,banco,true)

  if not ok then
    return erro_ou_user
  end

  local nome = headers.obtem_headder(NOME)
  local email = headers.obtem_headder(EMAIL)
  local senha = headers.obtem_headder(SENHA)
  local root = headers.obtem_headder_booleano(ROOT, "false")
  local saldo = headers.obtem_headder_numerico(SALDO, 100)
  local class = headers.obtem_headder(CLASS_BANCO)

  if headers.erro then
  	return headers.erro
  end

  if saldo < 1 then

    return serjao.send_text(VALUE_INVALID, 406)

  end

  ok, erro_banco = Add_user(banco, nome, email, senha, root, saldo, class)

  if ok then
    banco.commit()
    return serjao.send_text(USUARIO_CRIADO, 202)
  end


  return serjao.send_text(erro_banco, 409)
end