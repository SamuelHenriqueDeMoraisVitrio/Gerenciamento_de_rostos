cmake_minimum_required(VERSION 3.10)
project(ResizeImage)

# Encontrar a biblioteca ImageMagick
find_package(PkgConfig REQUIRED)
pkg_check_modules(MAGICK REQUIRED MagickWand)

# Adicionar diretórios de include do ImageMagick
include_directories(${MAGICK_INCLUDE_DIRS})

# Definir o diretório de saída do executável
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src/dependencies/imageMagick/)

# Adicionar o executável
add_executable(gerente main.c)

# Linkar as bibliotecas do ImageMagick
target_link_libraries(gerente ${MAGICK_LIBRARIES})
