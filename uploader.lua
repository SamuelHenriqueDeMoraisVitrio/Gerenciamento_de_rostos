local dtw = require("luaDoTheWorld/luaDoTheWorld")

local function mudanca()
    print("iniciando upload")
    os.execute("cd ../Gerenciamento_de_rostos")
    os.execute("killall screen")
    os.execute("sleep 60")
    os.execute("cd src")
    os.execute("screen -dm bash -c 'lua main.lua'")
    os.execute("cd ..")
    os.execute("cd ../base")
end

local sha_antigo = dtw.generate_sha_from_folder_by_content("src")
while true do
    print("verifying..")
    os.execute("git pull")
    local sha_novo = dtw.generate_sha_from_folder_by_content("src")
    if sha_antigo ~= sha_novo then
        sha_antigo = sha_novo
        mudanca()
    end
    os.execute("sleep 60")
end
