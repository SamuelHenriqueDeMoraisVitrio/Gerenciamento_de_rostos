#include <dlib/matrix.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>

std::vector<dlib::matrix<float,0,1>> load_descriptors(const std::string& file_path){
    std::ifstream input(file_path);
    std::vector<dlib::matrix<float,0,1>> descriptors;
    std::string line;
    while (std::getline(input, line)){
        std::istringstream stream(line);
        dlib::matrix<float,0,1> descriptor(128);
        for (long i = 0; i < 128; ++i){
            stream >> descriptor(i);
        }
        descriptors.push_back(descriptor);
    }
    return descriptors;
}

int main(int argc, char** argv)
try{
    if (argc != 3)
    {
        std::cout << "USE: ./compare_face_metrics metrica1.txt metrica2.txt" << std::endl;
        return 1;
    }

    auto descriptors1 = load_descriptors(argv[1]);
    auto descriptors2 = load_descriptors(argv[2]);

    if (descriptors1.empty() || descriptors2.empty())
    {
        std::cout << "Nenhuma metrica encontrada em um dos arquivos!" << std::endl;
        return 1;
    }

    for (const auto& d1 : descriptors1)
    {
        for (const auto& d2 : descriptors2)
        {
            double distance = dlib::length(d1 - d2);
            if (distance < 0.6)
            {
                std::cout << "A mesma pessoa (Distancia: " << distance << ")" << std::endl;
            }
            else
            {
                std::cout << "Diferente pessoas (Distancia: " << distance << ")" << std::endl;
            }
        }
    }
}
catch (std::exception& e)
{
    std::cout << e.what() << std::endl;
    return 1;
}