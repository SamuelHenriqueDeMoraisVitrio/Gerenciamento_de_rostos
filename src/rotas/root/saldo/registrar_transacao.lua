

---@param headers Headders
---@param banco DtwResource
---@param multiplicador number
---@return serjaoResponse
function Registrar_transacoes_rota(headers, banco, multiplicador)

    local ok, erro_ou_user = Altentica_sem_email(headers, banco, true)

    if not ok then
      return erro_ou_user
    end


    local filtragem_nome = headers.obtem_headder_opcional(NOME)
    local filtragem_email = headers.obtem_headder_opcional(EMAIL)
    local filtragem_saldo_min = headers.obtem_headder_numerico_opcional(SALDO_MIN)
    local filtragem_saldo_max = headers.obtem_headder_numerico_opcional(SALDO_MAX)
    local filtragem_img_max = headers.obtem_headder_numerico_opcional(IMG_MAX)
    local filtragem_img_min = headers.obtem_headder_numerico_opcional(IMG_MIN)
    local filtragem_root = headers.obtem_headder_booleano_opcional(ROOT)
    local filtragem_frequencia_min = headers.obtem_headder_numerico_opcional(FREQ_MIN)
    local filtragem_frequencia_max = headers.obtem_headder_numerico_opcional(FREQ_MAX)
    local valor = headers.obtem_headder_numerico(VALOR)

    if headers.erro then
    	return headers.erro
    end
    
    valor = valor * multiplicador
    
    local usuarios_modificados = Registra_transcoes_no_banco(banco,valor,filtragem_nome,filtragem_email,filtragem_saldo_min,filtragem_saldo_max, filtragem_root, filtragem_img_min, filtragem_img_max, filtragem_frequencia_min, filtragem_frequencia_max)
    return usuarios_modificados
end

