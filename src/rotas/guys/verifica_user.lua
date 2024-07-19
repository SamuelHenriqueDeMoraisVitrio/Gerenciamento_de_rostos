


---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function Retorna_dados_do_user(headders, banco)

  local ok, erro_ou_user = Altentica(headders, banco, false)

  if not ok then
    return erro_ou_user
  end

  local nome = erro_ou_user.get_value_from_sub_resource(NOME_BANCO)
  local saldo = erro_ou_user.get_value_from_sub_resource(SALDO_BANCO)
  local email = erro_ou_user.get_value_from_sub_resource(EMAIL_BANCO)
  local class = erro_ou_user.get_value_from_sub_resource(CLASS_BANCO)
  local frequencia = erro_ou_user.get_value_from_sub_resource(FREQUENCY_BANCO)
  local root = erro_ou_user.sub_resource(ROOT_BANCO).get_bool()
  local perfil_dir = erro_ou_user.sub_resource(DIR_PERFIL)
  local perfil_bool = perfil_dir.sub_resource(BOOL_PERFIL).get_bool()

  local json = {
      nome = nome,
      saldo = saldo,
      email = email,
      class = class,
      root = root,
      frequencia = frequencia,
      perfil_bool = perfil_bool
  }

  return serjao.send_json(json)

end