
#include "dependencies/LuaCEmbed.h"
#include <MagickWand/MagickWand.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

LuaCEmbedNamespace  lw;

void ThrowWandException(MagickWand *wand) {
    char *description;
    ExceptionType severity;

    description = MagickGetException(wand, &severity);
    (void) fprintf(stderr, "Error: %s\n", description);
    description = (char *) MagickRelinquishMemory(description);
    exit(EXIT_FAILURE);
}

unsigned char *resize_and_convert_image(unsigned char *input_data, size_t input_size, size_t *output_size) {
    MagickWand *magick_wand;
    unsigned char *output_data = NULL;

    // Initialize the MagickWand environment
    MagickWandGenesis();

    // Allocate a wand
    magick_wand = NewMagickWand();

    // Read the input image from memory
    if (MagickReadImageBlob(magick_wand, input_data, input_size) == MagickFalse) {
        ThrowWandException(magick_wand);
    }

    // Resize the image to 100x100 pixels
    if (MagickResizeImage(magick_wand, 100, 100, LanczosFilter) == MagickFalse) {
        ThrowWandException(magick_wand);
    }

    // Set the output image format to JPEG
    if (MagickSetImageFormat(magick_wand, "JPEG") == MagickFalse) {
        ThrowWandException(magick_wand);
    }

    // Set the image compression quality to 85
    if (MagickSetImageCompressionQuality(magick_wand, 85) == MagickFalse) {
        ThrowWandException(magick_wand);
    }

    // Write the output image to a blob
    output_data = MagickGetImageBlob(magick_wand, output_size);

    // Clean up
    if (magick_wand) magick_wand = DestroyMagickWand(magick_wand);

    // Terminate the MagickWand environment
    MagickWandTerminus();

    return output_data;
}

LuaCEmbedResponse  *format_img_lua(LuaCEmbed *args){
    long size;
    unsigned char *bin = lw.args.get_raw_str(args, &size, 0);

    if(lw.has_errors(args)){
        char *message = lw.get_error_message(args);
        return lw.response.send_error(message);
    }

    size_t new_size_response;
    unsigned char *bin_response = resize_and_convert_image(bin, (size_t)size, &new_size_response);
    
    return lw.response.send_raw_string((char *)bin_response, (long)new_size_response);
}

int luaopen_my_lib(lua_State *state){

    lw = newLuaCEmbedNamespace();

    LuaCEmbed *l  = lw.newLuaLib(state);

    lw.add_callback(l, "image_formated", format_img_lua);

    return lw.perform(l);
}

