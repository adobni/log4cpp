#
# Nicholas Yue nicholas_yue@users.sourceforge.net
#
# Note:
# (1) A dummy file include/config.h is required (remance from configure)
# (2) Default installation directory is /usr/local, override with -DCMAKE_INSTALL_PREFIX="" during cmake
#     invocation
# (3) Do the usual "make clean all" to build the library
# (4) To install either "make install" or "make install DESTDIR=<your directory>"
# (5) Need to include changes in include/log4cpp/Portability.hh for OSX to build

cmake_minimum_required(VERSION 2.6)

PROJECT ( LOG4CPP )

SET(LOG4CPP_VERSION "1.1.1")
SET(LOG4CPP_PACKAGE "log4cpp")

INCLUDE_DIRECTORIES ( include )
INCLUDE_DIRECTORIES ( . )

IF (WIN32)
  ADD_DEFINITIONS ( -D_CRT_SECURE_NO_WARNINGS )
ELSE (WIN32)
  IF (APPLE)
    ADD_DEFINITIONS ( -DNDEBUG -DLOG4CPP_HAVE_SSTREAM )
  ELSE (APPLE)
#    ADD_DEFINITIONS ( -pthread -DNDEBUG )
  ENDIF (APPLE)
ENDIF (WIN32)



INCLUDE("${CMAKE_CURRENT_SOURCE_DIR}/Configure.cmake")
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/include/config-cmake.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/log4cpp/config.h)
# BEFORE the source dir, so as not to accidentally pick up a configure'd file
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_CURRENT_BINARY_DIR}/include)


#IF ( CMAKE_BUILD_TYPE MATCHES "Debug" )
#  SET ( LOG4CPP_LIBRARY_NAME "log4cppD" )
#ELSE ( CMAKE_BUILD_TYPE MATCHES "Debug" )
SET ( LOG4CPP_LIBRARY_NAME "log4cpp" )
#ENDIF ( CMAKE_BUILD_TYPE MATCHES "Debug" )

ADD_LIBRARY ( ${LOG4CPP_LIBRARY_NAME}
  src/Appender.cpp
  src/AppenderSkeleton.cpp
  src/AppendersFactory.cpp
  src/BufferingAppender.cpp
  src/FactoryParams.cpp
  src/LayoutsFactory.cpp
  src/LevelEvaluator.cpp
  src/Localtime.cpp
  src/PassThroughLayout.cpp
  src/TriggeringEventEvaluatorFactory.cpp
  src/LayoutAppender.cpp
  src/FileAppender.cpp
  src/DailyRollingFileAppender.cpp
  src/RollingFileAppender.cpp
  src/FixedContextCategory.cpp
  src/IdsaAppender.cpp
  src/OstreamAppender.cpp
  src/StringQueueAppender.cpp
  src/SyslogAppender.cpp
  src/RemoteSyslogAppender.cpp
  src/SimpleLayout.cpp
  src/BasicLayout.cpp
  src/PatternLayout.cpp
  src/Category.cpp
  src/CategoryStream.cpp
  src/HierarchyMaintainer.cpp
  src/Configurator.cpp
  src/BasicConfigurator.cpp
  src/SimpleConfigurator.cpp
  src/PropertyConfigurator.cpp
  src/PropertyConfiguratorImpl.cpp
  src/LoggingEvent.cpp
  src/Priority.cpp
  src/NDC.cpp
  src/Filter.cpp
  src/TimeStamp.cpp
  src/StringUtil.cpp
  src/Properties.cpp
  src/Win32DebugAppender.cpp
  src/NTEventLogAppender.cpp
  src/DllMain.cpp
  src/DummyThreads.cpp
  src/MSThreads.cpp
  src/OmniThreads.cpp
  src/PThreads.cpp
  src/PortabilityImpl.cpp
  src/AbortAppender.cpp
)

SET_TARGET_PROPERTIES(${LOG4CPP_LIBRARY_NAME} PROPERTIES VERSION ${LOG4CPP_VERSION})

IF (WIN32)
  TARGET_LINK_LIBRARIES (${LOG4CPP_LIBRARY_NAME} kernel32 user32 ws2_32 advapi32 )
  SET_TARGET_PROPERTIES(${LOG4CPP_LIBRARY_NAME} PROPERTIES LINK_FLAGS /NODEFAULTLIB:msvcrt )
ENDIF (WIN32)


find_package(Threads)
target_link_libraries( ${LOG4CPP_LIBRARY_NAME} ${CMAKE_THREAD_LIBS_INIT})

add_subdirectory( tests )

INSTALL (
  DIRECTORY include/log4cpp
  DESTINATION include
  PATTERN "config.h" EXCLUDE
  PATTERN ".svn" EXCLUDE
  PATTERN "*.am" EXCLUDE
  PATTERN "*.in" EXCLUDE
)

INSTALL (
  FILES ${CMAKE_CURRENT_BINARY_DIR}/include/log4cpp/config.h
  DESTINATION include/log4cpp
)

INSTALL (
  TARGETS ${LOG4CPP_LIBRARY_NAME}
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)


find_package( Doxygen )
IF ( DOXYGEN_EXECUTABLE )
    SET(PACKAGE_NAME "${PROJECT_NAME}")
    SET(PACKAGE_VERSION "${VERSION}")
    SET(enable_latex_docs "NO")
    SET(enable_html_docs "YES")
    SET(top_srcdir "${CMAKE_SOURCE_DIR}")
    SET(enable_dot "${DOT_EXECUTABLE}")
    CONFIGURE_FILE(doc/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
    ADD_CUSTOM_TARGET(
        docs ${DOXYGEN_EXECUTABLE} "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile"
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen" VERBATIM
    )
ENDIF ( DOXYGEN_EXECUTABLE )
