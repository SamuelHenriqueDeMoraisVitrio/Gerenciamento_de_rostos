#include "iostream"
#include "string"
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing/render_face_detections.h>
#include <dlib/image_processing.h>
#include <dlib/gui_widgets.h>
#include <dlib/image_io.h>

using namespace dlib;



int main(int argc, char** argv){

        array2d<rgb_pixel> img;
        load_image(img, "donwload.jpeg");

        // Load face detection and pose estimation models.
        frontal_face_detector detector = get_frontal_face_detector();
        shape_predictor sp;
        deserialize("./shape_predictor_68_face_landmarks.dat") >> sp;

        // Detect faces
        std::vector<rectangle> dets = detector(img);
        std::cout << "Number of faces detected: " << dets.size() << std::endl;
}
/*
        // Load face detection and pose estimation models.
        frontal_face_detector detector = get_frontal_face_detector();
        shape_predictor sp;
        deserialize(argv[2]) >> sp;

        // Detect faces
        std::vector<rectangle> dets = detector(img);
        std::cout << "Number of faces detected: " << dets.size() << std::endl;

        // Find the pose of each face.
        std::vector<full_object_detection> shapes;
        for (unsigned long i = 0; i < dets.size(); ++i)
        {
            full_object_detection shape = sp(img, dets[i]);
            shapes.push_back(shape);
            std::cout << "number of parts: " << shape.num_parts() << std::endl;
            std::cout << "pixel position of first part:  " << shape.part(0) << std::endl;
            std::cout << "pixel position of second part: " << shape.part(1) << std::endl;
        }

        // Display it all on the screen
        image_window win;
        win.clear_overlay();
        win.set_image(img);
        win.add_overlay(render_face_detections(shapes));
        win.wait_until_closed();
    }
    catch (std::exception& e)
    {
        std::cerr << "Exception thrown: " << e.what() << std::endl;
    }

    return 0;
}
*/