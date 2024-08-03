

#include "dependencies/LuaCEmbed.h"
#include <MagickWand/MagickWand.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

LuaCEmbedNamespace lw;

void ThrowWandException(MagickWand *wand) {
    char *description;
    ExceptionType severity;

    description = MagickGetException(wand, &severity);
    (void) fprintf(stderr, "Error: %s\n", description);
    description = (char *) MagickRelinquishMemory(description);
    exit(EXIT_FAILURE);
}

unsigned char *convert_to_jpeg(unsigned char *input_data, size_t input_size, size_t *output_size) {
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

    // Check if the image format is not JPEG and convert it if necessary
    if (strcmp(MagickGetImageFormat(magick_wand), "JPEG") != 0) {
        // Set the output image format to JPEG
        if (MagickSetImageFormat(magick_wand, "JPEG") == MagickFalse) {
            ThrowWandException(magick_wand);
        }
    }

    // Write the output image to a blob
    output_data = MagickGetImageBlob(magick_wand, output_size);

    // Clean up
    if (magick_wand) magick_wand = DestroyMagickWand(magick_wand);

    // Terminate the MagickWand environment
    MagickWandTerminus();

    return output_data;
}

unsigned char *resize_image(unsigned char *input_data, size_t input_size, size_t *output_size) {
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

LuaCEmbedResponse *format_img_lua(LuaCEmbed *args) {
    long size;
    unsigned char *bin = lw.args.get_raw_str(args, &size, 0);

    if (lw.has_errors(args)) {
        char *message = lw.get_error_message(args);
        return lw.response.send_error(message);
    }

    size_t resized_size;
    unsigned char *resized_data = resize_image(bin, (size_t)size, &resized_size);
    
    return lw.response.send_raw_string((char *)resized_data, (long)resized_size);
}

LuaCEmbedResponse *convert_to_jpeg_response(LuaCEmbed *args){

    long size;
    unsigned char *bin = lw.args.get_raw_str(args, &size, 0);

    if (lw.has_errors(args)) {
        char *message = lw.get_error_message(args);
        return lw.response.send_error(message);
    }

    size_t jpeg_size, resized_size;
    unsigned char *jpeg_data = convert_to_jpeg(bin, (size_t)size, &jpeg_size);
    
    return lw.response.send_raw_string((char *)jpeg_data, (long)jpeg_size);
}

int luaopen_my_lib(lua_State *state) {
    lw = newLuaCEmbedNamespace();

    LuaCEmbed *l = lw.newLuaLib(state);

    lw.add_callback(l, "image_formated", format_img_lua);
    lw.add_callback(l, "convert_to_jpeg", convert_to_jpeg_response);

    return lw.perform(l);
}

