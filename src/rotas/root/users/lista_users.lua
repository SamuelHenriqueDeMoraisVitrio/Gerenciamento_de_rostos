

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Lista_users(headers, banco)

    local ok, erro_ou_user = Altentica(headers,banco,true)

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
    
    if headers.erro then
    	return headers.erro
    end

    local descricao  = Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max, filtragem_root, filtragem_img_min, filtragem_img_max)
    return descricao
end

