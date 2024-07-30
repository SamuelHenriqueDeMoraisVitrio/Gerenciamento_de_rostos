cmake_minimum_required(VERSION 2.8.12)
project(projeto)

add_subdirectory(./dlib dlib_build)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY /home/samuelhdmv/Documentos/Gerenciamento_de_rostos/src/dependencies/dlib_face_detection/)

add_executable(extract_face_metrics extractMetrics.cpp)
target_link_libraries(extract_face_metrics dlib::dlib)

add_executable(compare_face_metrics faceCompar.cpp)
target_link_libraries(compare_face_metrics dlib::dlib)
