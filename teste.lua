
dtw = require("src.dependencies.luaDoTheWorld.luaDoTheWorld")
require("src.dependencies.requires")

DATE_FORMATED = "%Y-%m-%d %H:%M:%S"


local time = os.time()

local date1 = os.date(DATE_FORMATED, time)

time = time + 86400

local date2 = os.date(DATE_FORMATED, time)

local date3 = os.date("%d", time)

local sla1 = 86400 * 2

print(date1, date2, type(date3), sla1)
