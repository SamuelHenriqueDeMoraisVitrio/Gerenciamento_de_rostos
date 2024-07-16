

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Retorna_dados_do_user(headders, banco)

  local ok, erro_ou_user = Altentica(headders, banco, false)

  if not ok then
    return erro_ou_user
  end

  local nome = erro_ou_user.get_value_from_sub_resource(NOME)
  local saldo = erro_ou_user.get_value_from_sub_resource(SALDO)
  local email = erro_ou_user.get_value_from_sub_resource(EMAIL)

  local json = {
      nome = nome,
      saldo = saldo,
      email = email
  }

  return serjao.send_json(json)

end