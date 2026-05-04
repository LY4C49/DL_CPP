cmake_minimum_required(VERSION 3.18)
project(MinstCpp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Torch REQUIRED)

add_executable(minst_fc minst_fc.cpp)

target_link_libraries(minst_fc "${TORCH_LIBRARIES}")
target_compile_options(minst_fc PRIVATE ${TORCH_CXX_FLAGS})

set_property(TARGET minst_fc PROPERTY CXX_STANDARD 17)