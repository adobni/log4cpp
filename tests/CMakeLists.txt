
cmake_minimum_required(VERSION 2.6)


add_executable(testmain testmain.cpp)

target_link_libraries( testmain ${LOG4CPP_LIBRARY_NAME} ${CMAKE_THREAD_LIBS_INIT})

add_executable(testbench testbench.cpp Clock.cpp)

target_link_libraries( testbench ${LOG4CPP_LIBRARY_NAME} ${CMAKE_THREAD_LIBS_INIT})
