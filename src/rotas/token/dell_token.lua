


function Dell_tokens(headders, banco)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local response = Dell_tokens_banco(banco, error_or_user)

    return response
end