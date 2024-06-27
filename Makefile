CONFIG_LUA := config.mk

-include $(CONFIG_LUA)

LUA ?= main.lua
RUN = echo "" && echo "" && echo "Compilação concluida. Executando..." && echo "" && lua $(LUA) && echo ""
g ?= ""
gt ?= ""

teste: clear
	@cd /home/samuel/Documentos/proc/serjaoServerWeb/serjao_web/ && $(RUN)
	@echo ""

zip: clear
	@rm -f serjao_web.zip
	@zip -r serjao_web.zip serjao_web
	@echo ""
	@zip -T serjao_web.zip -v
	@echo ""
	@unzip -l serjao_web.zip
	@echo ""

clear:
	clear
	@ls --color=always -alh
	@echo ""

#TRocar o nome de forma permanente do teste2.lua

set_lua:
	@echo LUA=$(LUA) > $(CONFIG_LUA)
	@echo "$(LUA)"

#Para mexer com git

git: add
	@git push
	@echo ""

add:
ifeq ($(gt),)
	@git add .
	@git commit -m "$(g)"
	@echo ""
else
	@git add .
	@git commit -m "$(g)" -m "$(gt)"
	@echo ""
endif