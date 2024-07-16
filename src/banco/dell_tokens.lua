


---@param banco DtwResource
---@param user DtwResource
---@return serjaoResponse
function Dell_tokens_banco(banco, user)

    local dir = user.sub_resource(TOKENS)

    dir.destroy()

    banco.commit()

    return serjao.send_text("Tokens deletados")
end