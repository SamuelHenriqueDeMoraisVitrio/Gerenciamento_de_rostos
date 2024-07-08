

---@param banco DtwResource
---@param valor number
---@param filtragem_nome string | nil
---@param filtragem_email string | nil
---@param filtragem_saldo_min number | nil
---@param filtragem_saldo_max number | nil
---@return table
function Registra_transcoes_no_banco(banco, valor,filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)

  local usuarios,tamanho_usuarios = Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)
  local resource_users = banco.sub_resource("usuarios")
  local usuarios_modificados  = {}
  for i=1,tamanho_usuarios do
    local usuario = usuarios[i]
    local user_finding = resource_users.get_resource_matching_primary_key("email", usuario.email)
    local novo_saldo = usuario.saldo + valor
    user_finding.set_value_in_sub_resource("saldo",novo_saldo)
    local transacoes  = user_finding.sub_resource("transacoes")
    local transacao_atual =  transacoes.sub_resource_next()
    transacao_atual.set_value_in_sub_resource("valor",valor)
    transacao_atual.set_value_in_sub_resource("data",os.time())
    transacao_atual.set_value_in_sub_resource("saldo_now", novo_saldo)
    usuarios_modificados[i] = {
    nome=usuario.nome,
    email = usuario.email,
    novo_saldo = novo_saldo
    }
  end

  banco.commit()
  return usuarios_modificados

end


