
dtw = require("src.dependencies.luaDoTheWorld.luaDoTheWorld")
require("src.dependencies.requires")



local banco = dtw.newResource("sla")

local sla = banco.sub_resource("sla/sla/sla")

sla.set_value_in_sub_resource("nome", true)

banco.commit()

local list, size = sla.list()

local path_new = dtw.newPath(list[1].get_path_string())

print(path_new.get_only_name())
print(path_new.get_name())
print(path_new.get_extension())
