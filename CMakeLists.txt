cmake_minimum_required(VERSION 3.12)

set (CUDF_JNI_ROOT cudf_jni)
set (THIRD_PARTY /home/bobwang/work.d/nvspark/cudf/thirdparty)

set(CMAKE_CUDA_COMPILER /usr/local/cuda/bin/nvcc)
project("nccl" VERSION 0.7.2 LANGUAGES C CXX CUDA)

add_compile_definitions(__CUDACC__ XGBOOST_USE_CUDF XGBOOST_USE_CUDA XGBOOST_USE_NCCL)

find_package(CUDA REQUIRED)

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS}
        -gencode arch=compute_70,code=sm_70 //计算能力的要求
        -rdc=true
        -g
        -G
        --std c++11)

############################### rabit
file(GLOB_RECURSE SRC_SOURCES
        src/*.cc
        src/*.h
        src/*.cu
        src/nccl.h.in
        )
include_directories(xgboost/rabit/include)
list(APPEND SOURCE_FILES ${SRC_SOURCES})

include_directories(src/include)

add_library(cudf SHARED ${SOURCE_FILES})
