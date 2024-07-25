
extern "C"{

#include "dependencies/LuaCEmbed.h"

LuaCEmbedNamespace  lua_n;

}


#include <string>
#include <iostream>



LuaCEmbedResponse  *add_cfunc(LuaCEmbed *args){
    
    std::string nome = "sla";
    std::cout << "nome " << nome << '\n';

    return NULL;
}

LuaCEmbedResponse  *sub_cfunc(LuaCEmbed *args){

    double first_num = lua_n.args.get_double(args,0);
    double second_num = lua_n.args.get_double(args,1);

    if(lua_n.has_errors(args)){
        char *message = lua_n.get_error_message(args);
        return lua_n.response.send_error(message);
    }
    double result = first_num - second_num;
    return lua_n.response.send_double(result);
}

extern "C"{
    int gerente_faces(lua_State *state){
        lua_n = newLuaCEmbedNamespace();
        //functions will be only assescible by the required reciver
        LuaCEmbed * l  = lua_n.newLuaLib(state);
        lua_n.add_callback(l,"add",add_cfunc);
        lua_n.add_callback(l,"sub",sub_cfunc);

    return lua_n.perform(l);
    }
}



