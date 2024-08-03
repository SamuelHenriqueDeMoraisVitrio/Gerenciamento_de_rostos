#gcc -shared -fpic -o dependencies/imageMagick/imageMGK.so cBind/imageMagick/main.c `pkg-config --cflags --libs MagickWand`
gcc -shared -fpic -o dependencies/dlib_face_detection/extract.so cBind/extract_lua.c

#gcc -shared -fpic -o teste.so extract_lua.c
#gcc -o imagemagick_example main.c `pkg-config --cflags --libs MagickWand`
#g++ -std=c++20 -O3 -I.. -I/usr/include -I/usr/include/png -I/usr/include/jpeg ../dlib/all/source.cpp -lpthread -lX11 -lpng -ljpeg ../extractMetrics.cpp -shared -fpic -o nome_do_programa_de_exemplo.so