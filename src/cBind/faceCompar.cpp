#include <dlib/matrix.h>
#include <iostream>
#include <vector>
#include <cmath>

std::vector<dlib::matrix<float,0,1>> load_descriptors_from_string(const std::string& data){
    std::istringstream input(data);
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


extern "C"{
    bool compar_faces(const char *data1, const char *data2);
}

bool compar_faces(const char *data1, const char *data2){

    auto descriptors1 = load_descriptors_from_string(data1);
    auto descriptors2 = load_descriptors_from_string(data2);

    if (descriptors1.empty() || descriptors2.empty())
    {
        return false;
    }

    for (const auto& d1 : descriptors1){
        for (const auto& d2 : descriptors2){
            double distance = dlib::length(d1 - d2);
            if (distance < 0.6){
                return true;
            }
            else{
                return false;
            }
        }
    }
    return false;
}