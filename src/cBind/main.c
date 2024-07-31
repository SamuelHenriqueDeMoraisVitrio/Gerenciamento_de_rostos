
#include "dependencies/LuaCEmbed.h"

LuaCEmbedNamespace  lw;


LuaCEmbedResponse  *add_cfunc(LuaCEmbed *args){
    double first_num = lw.args.get_double(args,0);
    double second_num = lw.args.get_double(args,1);

    if(lw.has_errors(args)){
        char *message = lw.get_error_message(args);
        return lw.response.send_error(message);
    }
    double result = first_num + second_num;
    return lw.response.send_double(result);
}

LuaCEmbedResponse  *sub_cfunc(LuaCEmbed *args){
    double first_num = lw.args.get_double(args,0);
    double second_num = lw.args.get_double(args,1);

    if(lw.has_errors(args)){
        char *message = lw.get_error_message(args);
        return lw.response.send_error(message);
    }
    double result = first_num - second_num;
    return lw.response.send_double(result);
}

int luaopen_my_lib(lua_State *state){

    lw = newLuaCEmbedNamespace();

    LuaCEmbed *l  = lw.newLuaLib(state);
    lw.add_callback(l, "add", add_cfunc);
    lw.add_callback(l, "sub", sub_cfunc);

    return lw.perform(l);

}