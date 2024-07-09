
dtw = require("src/dependencies/luaDoTheWorld/luaDoTheWorld")

DATE_FORMATED = "%Y-%m-%d %H:%M:%S"

local sla = nil

local data = os.date(DATE_FORMATED, sla)

print(data)