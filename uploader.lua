local dtw = require("luaDoTheWorld/luaDoTheWorld")

local function move_src()
    dtw.copy_any_overwriting("producao/data", "backups/" .. os.time())
    local files, size = dtw.list_all("src")
    for i = 1, size do
        local item = files[i]
        local caminho_antigo = dtw.concat_path("src", item)

        if item ~= 'data' then
            local novo_caminho = dtw.concat_path("producao", item)
            dtw.copy_any_overwriting(caminho_antigo, novo_caminho)
        end
    end
end

local function mudanca()
    os.execute("screen -X -S server quit")
    print("torcendo para a porta estar livre")
    os.execute("sleep 60")
    print("movendo arquivos")
    move_src()
    print("iniciando novo servidor")
    os.execute("cd producao/ && screen -S server -dm bash -c 'lua main.lua'")
    print("deve estar rodando")
end
mudanca()

if false then
    local sha_antigo = dtw.generate_sha_from_folder_by_content("src")
    while true do
        mudanca()
        print("verificando ..")
        os.execute("git pull")
        local sha_novo = dtw.generate_sha_from_folder_by_content("src")
        if sha_antigo ~= sha_novo then
            sha_antigo = sha_novo
            mudanca()
        end
        os.execute("sleep 60")
    end
end
