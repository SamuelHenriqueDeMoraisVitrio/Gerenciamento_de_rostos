
#include "dependencies/LuaCEmbed.h"

LuaCEmbedNamespace  lw;

#include <stdio.h>
#include <stdlib.h>
#include <MagickWand/MagickWand.h>

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

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_image\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Read input file into memory
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    fseek(input_file, 0, SEEK_END);
    size_t input_size = ftell(input_file);
    fseek(input_file, 0, SEEK_SET);

    unsigned char *input_data = (unsigned char *)malloc(input_size);
    if (!input_data) {
        perror("Error allocating memory for input data");
        fclose(input_file);
        return EXIT_FAILURE;
    }

    fread(input_data, 1, input_size, input_file);
    fclose(input_file);

    // Process the image
    size_t output_size;
    unsigned char *output_data = resize_and_convert_image(input_data, input_size, &output_size);
    if (!output_data) {
        fprintf(stderr, "Error processing image\n");
        free(input_data);
        return EXIT_FAILURE;
    }

    // Write the output to a file (for demonstration purposes)
    FILE *output_file = fopen("output.jpg", "wb");
    if (!output_file) {
        perror("Error opening output file");
        free(input_data);
        free(output_data);
        return EXIT_FAILURE;
    }

    fwrite(output_data, 1, output_size, output_file);
    fclose(output_file);

    // Clean up
    free(input_data);
    free(output_data);

    return 0;
}


/*
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
*/

