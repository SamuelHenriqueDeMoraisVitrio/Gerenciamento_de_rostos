#include <cstddef>
#include <dlib/dnn.h>
#include <dlib/image_io.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing.h>
#include <iostream>
#include <sstream>
#include <vector>

template <template <int,template<typename>class,int,typename> class block, int N, template<typename>class BN, typename SUBNET>
using residual = dlib::add_prev1<block<N,BN,1,dlib::tag1<SUBNET>>>;

template <template <int,template<typename>class,int,typename> class block, int N, template<typename>class BN, typename SUBNET>
using residual_down = dlib::add_prev2<dlib::avg_pool<2,2,2,2,dlib::skip1<dlib::tag2<block<N,BN,2,dlib::tag1<SUBNET>>>>>>;

template <int N, template <typename> class BN, int stride, typename SUBNET>
using block  = BN<dlib::con<N,3,3,1,1,dlib::relu<BN<dlib::con<N,3,3,stride,stride,SUBNET>>>>>;

template <int N, typename SUBNET> using ares      = dlib::relu<residual<block,N,dlib::affine,SUBNET>>;
template <int N, typename SUBNET> using ares_down = dlib::relu<residual_down<block,N,dlib::affine,SUBNET>>;

template <typename SUBNET> using alevel0 = ares_down<256,SUBNET>;
template <typename SUBNET> using alevel1 = ares<256,ares<256,ares_down<256,SUBNET>>>;
template <typename SUBNET> using alevel2 = ares<128,ares<128,ares_down<128,SUBNET>>>;
template <typename SUBNET> using alevel3 = ares<64,ares<64,ares<64,ares_down<64,SUBNET>>>>;
template <typename SUBNET> using alevel4 = ares<32,ares<32,ares<32,SUBNET>>>;

using anet_type = dlib::loss_metric<dlib::fc_no_bias<128,dlib::avg_pool_everything<
                            alevel0<
                            alevel1<
                            alevel2<
                            alevel3<
                            alevel4<
                            dlib::max_pool<3,3,2,2,dlib::relu<dlib::affine<dlib::con<32,7,7,2,2,
                            dlib::input_rgb_image_sized<150>
                            >>>>>>>>>>>>;

std::vector<dlib::matrix<dlib::rgb_pixel>> jitter_image(const dlib::matrix<dlib::rgb_pixel>& img);

extern "C"{
    char *extract(unsigned char*body, size_t size);
}

// Função para carregar imagem a partir de unsigned char*
void load_image_from_buffer(dlib::matrix<dlib::rgb_pixel>& img, const unsigned char* buffer, size_t size){
    dlib::load_jpeg(img, buffer, size);
}

char *extract(unsigned char* body, size_t size) try{

    // Carregar os modelos necessários
    dlib::frontal_face_detector detector = dlib::get_frontal_face_detector();
    dlib::shape_predictor sp;
    dlib::deserialize("treinee/shape_predictor_5_face_landmarks.dat") >> sp;
    anet_type net;
    dlib::deserialize("treinee/dlib_face_recognition_resnet_model_v1.dat") >> net;

    // Carregar a imagem
    dlib::matrix<dlib::rgb_pixel> img;
    load_image_from_buffer(img, body, size);

    // Detectar faces na imagem
    std::vector<dlib::matrix<dlib::rgb_pixel>> faces;
    for (auto face : detector(img)){
        auto shape = sp(img, face);
        dlib::matrix<dlib::rgb_pixel> face_chip;
        dlib::extract_image_chip(img, dlib::get_face_chip_details(shape,150,0.25), face_chip);
        faces.push_back(std::move(face_chip));
    }

    if (faces.size() == 0){
        return NULL;
    }

    // Obter as descrições faciais
    std::vector<dlib::matrix<float,0,1>> face_descriptors = net(faces);

    std::ostringstream oss;
    for (const auto& descriptor : face_descriptors) {
        for (long i = 0; i < descriptor.size(); ++i) {
            oss << descriptor(i) << " ";
        }
        oss << std::endl;
    }

    std::string descriptor_str = oss.str();
    char* descriptor_cstr = new char[descriptor_str.size() + 1];
    std::copy(descriptor_str.begin(), descriptor_str.end(), descriptor_cstr);
    descriptor_cstr[descriptor_str.size()] = '\0'; // Null-terminator

    return descriptor_cstr;
}
catch (std::exception& e){
    std::cout << 1 << ' ' << e.what() << std::endl;
    return NULL;
}

