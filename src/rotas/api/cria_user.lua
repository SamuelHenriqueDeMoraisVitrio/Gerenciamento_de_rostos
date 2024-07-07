

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Cria_user_server(headers, banco)
  local ok, erro = Altentica_root(headers,banco)

  if ok == false then
    return erro
  end

  local nome = headers.obtem_headder("nome")
  local email = headers.obtem_headder("email")
  local senha = headers.obtem_headder("senha")
  local root_str = headers.obtem_headder("root","false")
  local saldo = headers.obtem_headder("saldo", 100)

  if headers.erro then
  	return headers.erro
  end

  local root = false
  if root_str =="true" then
  	 root = true
  end

  ok, erro_banco = Add_user(banco, nome, email, senha, root, saldo)

  if ok then
    banco.commit()
    return serjao.send_text("O usuario foi criado", 202)
  end


  return serjao.send_text(erro_banco, 409)
end