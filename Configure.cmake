
# Platform checks

include(CheckIncludeFileCXX)
include(CheckFunctionExists)

###########################################################
# LOG4CPP_HAVE_SSTREAM
###########################################################
CHECK_INCLUDE_FILE_CXX(sstream LOG4CPP_HAVE_SSTREAM)

###########################################################
# LOG4CPP_HAVE_DLFCN_H
###########################################################
CHECK_INCLUDE_FILE_CXX(dlfcn.h LOG4CPP_HAVE_DLFCN_H)


###########################################################
# LOG4CPP_HAVE_GETTIMEOFDAY
###########################################################
CHECK_FUNCTION_EXISTS(gettimeofday LOG4CPP_HAVE_GETTIMEOFDAY)


###########################################################
# LOG4CPP_HAVE_STDINT_H
###########################################################
CHECK_INCLUDE_FILE_CXX(stdint.h LOG4CPP_HAVE_STDINT_H)


###########################################################
# LOG4CPP_HAVE_UNISTD_H
###########################################################
CHECK_INCLUDE_FILE_CXX(unistd.h LOG4CPP_HAVE_UNISTD_H)


###########################################################
# LOG4CPP_HAVE_IO_H
###########################################################
CHECK_INCLUDE_FILE_CXX(io.h LOG4CPP_HAVE_IO_H)


###########################################################
# LOG4CPP_HAVE_SNPRINTF
###########################################################
CHECK_FUNCTION_EXISTS(snprintf LOG4CPP_HAVE_SNPRINTF)


###########################################################
# LOG4CPP_HAVE_SYSLOG
###########################################################
CHECK_FUNCTION_EXISTS(syslog LOG4CPP_HAVE_SYSLOG)


###########################################################
# LOG4CPP_HAVE_LOCALTIME_R
###########################################################

FILE(WRITE "${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/localtime_r.c.in"
"#include <time.h>\n"
"int main()\n"
"{\n"
"   time_t t;\n"
"   struct tm tm;\n"
"   (void)localtime_r(&t, &tm);\n"
"	return 0;\n"
"}")
CONFIGURE_FILE(${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/localtime_r.c.in ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/localtime_r.c)
TRY_COMPILE(LOG4CPP_HAVE_LOCALTIME_R ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/localtime_r.c OUTPUT_VARIABLE OUTPUT)

###########################################################
# LOG4CPP_HAVE_FTIME
###########################################################

CHECK_FUNCTION_EXISTS(ftime LOG4CPP_HAVE_FTIME)

#FILE(WRITE "${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/ftime.c.in"
#"#include <sys/timeb.h>\n"
#"int main()\n"
#"{\n"
#"   struct timeb t;\n"
#"   (void)ftime(&t);\n"
#"	return 0;\n"
#"}")
#CONFIGURE_FILE(${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/ftime.c.in ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/ftime.c)
#TRY_COMPILE(LOG4CPP_HAVE_FTIME ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/ftime.c OUTPUT_VARIABLE OUTPUT)

###########################################################
# LOG4CPP_HAVE_INT64_T
###########################################################

IF (LOG4CPP_HAVE_STDINT)
  FILE(WRITE "${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/int64_t.c.in"
	"#include <stdint.h>\n"
	"int main()\n"
	"{\n"
	"   volatile int64_t t;\n"
	"	return 0;\n"
	"}")
  CONFIGURE_FILE(${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/int64_t.c.in ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/int64_t.c)
  TRY_COMPILE(LOG4CPP_HAVE_INT64_T ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/int64_t.c OUTPUT_VARIABLE OUTPUT)
ENDIF (LOG4CPP_HAVE_STDINT)


###########################################################
# LOG4CPP_HAVE_NAMESPACES
###########################################################

FILE(WRITE "${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/namespaces.cpp.in"
"#include <stdint.h>\n"
"namespace test {\n"
" int x=1;\n"
"}\n"
"int main()\n"
"{\n"
"   return test::x;\n"
"}")
CONFIGURE_FILE(${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/namespaces.cpp.in ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/namespaces.cpp)
TRY_COMPILE(LOG4CPP_HAVE_NAMESPACES ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/configure-tryouts/namespaces.cpp OUTPUT_VARIABLE OUTPUT)

###########################################################
# LOG4CPP THREADING (only win32 or pthread supported)
###########################################################

find_package(Threads)

IF (CMAKE_THREAD_LIBS_INIT)

    IF(CMAKE_USE_WIN32_THREADS_INIT)
        SET(LOG4CPP_HAVE_THREADING TRUE)
        SET(LOG4CPP_USE_MSTHREADS TRUE)
        MESSAGE(STATUS "Log4cpp threading support enabled using win32 threads")
    ENDIF(CMAKE_USE_WIN32_THREADS_INIT)

    IF(CMAKE_USE_PTHREADS_INIT)
        SET(LOG4CPP_HAVE_THREADING TRUE)
        SET(LOG4CPP_USE_PTHREADS TRUE)
        MESSAGE(STATUS "Log4cpp threading support enabled using pthreads")
    ENDIF(CMAKE_USE_PTHREADS_INIT)

ENDIF (CMAKE_THREAD_LIBS_INIT)

# TODO
#LOG4CPP_HAVE_BOOST
#LOG4CPP_HAVE_IN_ADDR_T 
#LOG4CPP_HAVE_LIBIDSA
#LOG4CPP_USE_ONMITHREADS

