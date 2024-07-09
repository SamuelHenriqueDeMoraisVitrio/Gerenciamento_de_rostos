

---@param headers Headders
---@param banco DtwResource
---@param multiplicador number
---@return serjaoResponse
function Registrar_transacoes_rota(headers, banco, multiplicador)

    local ok, erro = Altentica_root(headers)
  
    if ok == false then
      return erro
    end


    local filtragem_nome = headers.obtem_headder_opcional(NOME)
    local filtragem_email = headers.obtem_headder_opcional(EMAIL)
    local filtragem_saldo_min = headers.obtem_headder_numerico_opcional(SALDO_MIN)
    local filtragem_saldo_max = headers.obtem_headder_numerico_opcional(SALDO_MAX)
    local valor = headers.obtem_headder_numerico(VALOR)

    if headers.erro then
    	return headers.erro
    end
    
    valor = valor * multiplicador
    
    local usuarios_modificados = Registra_transcoes_no_banco(banco,valor,filtragem_nome,filtragem_email,filtragem_saldo_min,filtragem_saldo_max)
    return usuarios_modificados
end

