g++ -shared -fpic -o cBind/gerente.so  cBind/main.cpp

#g++ -std=c++20 -O3 -I.. -I/usr/include -I/usr/include/png -I/usr/include/jpeg ../dlib/all/source.cpp -lpthread -lX11 -lpng -ljpeg ../extractMetrics.cpp -shared -fpic -o nome_do_programa_de_exemplo.so