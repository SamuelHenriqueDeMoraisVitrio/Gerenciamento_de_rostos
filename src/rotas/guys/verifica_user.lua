


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
  local img_perfil = erro_ou_user.get_value_from_sub_resource(IMG_PERFIL)
  local root = erro_ou_user.sub_resource(ROOT_BANCO).get_bool()
  local perfil_bool = false
  if img_perfil then
    perfil_bool = true
  end

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


