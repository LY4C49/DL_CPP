cmake_minimum_required(VERSION 3.18)
project(HelloTorchCUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find LibTorch
find_package(Torch REQUIRED)

# Build executable
add_executable(example example.cpp)

# Link LibTorch
target_link_libraries(example "${TORCH_LIBRARIES}")

# Use Torch recommended compile flags
target_compile_options(example PRIVATE ${TORCH_CXX_FLAGS})

# Keep C++17 explicit for this target
set_property(TARGET example PROPERTY CXX_STANDARD 17)