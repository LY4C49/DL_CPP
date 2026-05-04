cmake_minimum_required(VERSION 3.18)
project(HelloTorchCUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Torch REQUIRED)

add_executable(example example.cpp)

target_link_libraries(example "${TORCH_LIBRARIES}")
target_compile_options(example PRIVATE ${TORCH_CXX_FLAGS})

set_property(TARGET example PROPERTY CXX_STANDARD 17)