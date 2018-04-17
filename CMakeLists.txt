cmake_minimum_required(VERSION 3.11)
project(v4l2matlab)

set(CMAKE_CXX_STANDARD 11)

add_executable(grab thirdparty/webcam-v4l2/grab.cpp thirdparty/webcam-v4l2/webcam.cpp)
target_include_directories(grab PUBLIC thirdparty/webcam-v4l2)
target_link_libraries(grab v4l2)

add_library(webcam STATIC
        thirdparty/webcam-v4l2/webcam.cpp
        )
target_compile_features(webcam PUBLIC cxx_std_11)
set_target_properties(webcam PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(webcam PUBLIC
        thirdparty/webcam-v4l2
        )


add_library(dummy_mex
        src/WebcamMexWrapper.cpp
        )
target_include_directories(dummy_mex PUBLIC
        thirdparty/mexplus/include
        thirdparty/webcam-v4l2
        /usr/local/MATLAB/R2017b/extern/include
        /usr/local/MATLAB/R2017b/simulink/include
        /usr/local/MATLAB/R2017b/toolbox/distcomp/gpu/extern/include/
        )
target_compile_features(dummy_mex PUBLIC cxx_std_11)
