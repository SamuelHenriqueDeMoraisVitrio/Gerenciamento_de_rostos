cmake_minimum_required(VERSION 2.8.12)
project(projeto)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

add_subdirectory(./dlib dlib_build)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src/dependencies/dlib_face_detection/link/)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src/dependencies/dlib_face_detection/link/)

add_library(extract_face_metrics SHARED extractMetrics.cpp)
target_link_libraries(extract_face_metrics dlib::dlib)

add_library(compare_face_metrics SHARED faceCompar.cpp)
target_link_libraries(compare_face_metrics dlib::dlib)
