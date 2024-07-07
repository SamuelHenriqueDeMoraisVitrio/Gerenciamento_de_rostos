

---@param headers Headders
---@param banco DtwResource
---@param multiplicador number
---@return serjaoResponse
function Registrar_transacoes_rota(headers, banco,multiplicador)


    local ok, erro = Altentica_root(headers,banco)
  
    if ok == false then
      return erro
    end


    local filtragem_nome = headers.obtem_headder_opcional("nome")
    local filtragem_email = headers.obtem_headder_opcional("email")
    local filtragem_saldo_min = headers.obtem_headder_numerico_opcional("saldo_min")
    local filtragem_saldo_max = headers.obtem_headder_numerico_opcional("saldo_max")
    local valor = headers.obtem_headder_numerico("valor")

    if headers.erro then
    	return headers.erro
    end
    valor = valor * multiplicador
    local usuarios_modificados = Registra_transcoes_no_banco(banco,valor,filtragem_nome,filtragem_email,filtragem_saldo_min,filtragem_saldo_max)
    return usuarios_modificados
end

