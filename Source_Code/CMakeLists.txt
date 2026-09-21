cmake_minimum_required(VERSION 3.20)
project(QuickDictNative LANGUAGES CXX RC)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

if(WIN32)
    add_executable(QuickDictNative WIN32 QuickDictNative.cpp resource.rc)
else()
    add_executable(QuickDictNative QuickDictNative.cpp)
endif()

target_compile_definitions(QuickDictNative PRIVATE UNICODE _UNICODE NOMINMAX WIN32_LEAN_AND_MEAN)

if(MSVC)
    target_compile_options(QuickDictNative PRIVATE /W4 /EHsc /utf-8 /O2)
    target_link_options(QuickDictNative PRIVATE /SUBSYSTEM:WINDOWS)
endif()

if(WIN32)
    target_link_libraries(QuickDictNative PRIVATE user32 gdi32 shell32 advapi32 winhttp comctl32 dwmapi)
endif()
