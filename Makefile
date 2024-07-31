CONFIG_LUA := config.mk

-include $(CONFIG_LUA)

LUA ?= main.lua
RUN = echo "" && echo "" && echo "Compilação concluida. Executando..." && echo "" && lua $(LUA) && echo ""
g ?= ""
gt ?= ""

teste: clear
	@cd /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src && $(RUN)
	@echo ""

build_image: clear
	@cd /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src && sh build.sh
	@echo ""

zip: clear
	@rm -f src.zip
	@zip -r src.zip src
	@echo ""
	@zip -T src.zip -v
	@echo ""
	@unzip -l src.zip
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