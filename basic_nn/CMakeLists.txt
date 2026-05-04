cmake_minimum_required(VERSION 3.18)
project(MinstCpp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Torch REQUIRED)

add_executable(minst_fc minst_fc.cpp)

#[[
PRIVATE
= 只影响当前 target 自己

PUBLIC
= 影响当前 target 自己，也影响链接它的其他 target

INTERFACE
= 当前 target 自己不用，只影响链接它的其他 target
]]
target_link_libraries(minst_fc PRIVATE "${TORCH_LIBRARIES}")
target_compile_options(minst_fc PRIVATE ${TORCH_CXX_FLAGS}) 

set_property(TARGET minst_fc PROPERTY CXX_STANDARD 17)