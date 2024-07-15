

---@param headders Headders
---@param banco DtwResource
---@return serjaoResponse
function registra_transacao_por_email(headders, banco, multiplicador)

    local ok, erro_ou_user = Altentica(headders, banco, true)

    if not ok then
      return erro_ou_user
    end

    local email = headders.obtem_headder(EMAIL)
    local valor = headders.obtem_headder_numerico(VALOR)

    if headders.erro then
        
        return headders.erro

    end

    valor = valor * multiplicador

    local response = registra_saldo_email(banco, email, valor)


    return response

end