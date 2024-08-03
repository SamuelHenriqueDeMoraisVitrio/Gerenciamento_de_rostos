#include <dlfcn.h>
#include <stdio.h>
#include <time.h>
#include "dependencies/LuaCEmbed.h"
#include <stdbool.h>

LuaCEmbedNamespace  lw;

LuaCEmbedResponse *extract_face(LuaCEmbed *args){

    long size;
    unsigned char *bin = (unsigned char *)lw.args.get_raw_str(args, &size, 0);

    if (lw.has_errors(args)) {
        char *erro_msg = lw.get_error_message(args);
        return lw.response.send_error(erro_msg);
    }

    void *handle = dlopen("./dependencies/dlib_face_detection/link/libextract_face_metrics.so", RTLD_LAZY);
    if (!handle) {
        return lw.response.send_error("Erro ao carregar linkagem.");
    }

    char *(*extract)(unsigned char *file, size_t size);

    extract = (char *(*)(unsigned char*, size_t))dlsym(handle, "extract");

    char *response = extract(bin, (size_t)size);

    if(!response){
        return NULL;
    }

    return lw.response.send_str(response);
}

LuaCEmbedResponse *compare_faces_by_metrics(LuaCEmbed *args){

    const char *data1 = lw.args.get_str(args, 0);
    const char *data2 = lw.args.get_str(args, 1);

    if (lw.has_errors(args)) {
        char *erro_msg = lw.get_error_message(args);
        return lw.response.send_error(erro_msg);
    }

    void *handle = dlopen("./dependencies/dlib_face_detection/link/libcompare_face_metrics.so", RTLD_LAZY);
    if (!handle) {
        return lw.response.send_error("Erro ao carregar linkagem.");
    }

    bool (*compar)(const char *str1, const char *str2);

    compar = (bool (*)(const char*, const char *))dlsym(handle, "compar_faces");

    bool response_lua = compar(data1, data2);

    return lw.response.send_bool(response_lua);
}

int extract_face_main(lua_State *state){
    lw = newLuaCEmbedNamespace();

    LuaCEmbed *l  = lw.newLuaLib(state);

    lw.add_callback(l, "extract", extract_face);
    lw.add_callback(l, "compar", compare_faces_by_metrics);

    return lw.perform(l);
}


