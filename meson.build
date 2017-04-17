project('log4cpp', 'cpp', version : '1.1.1')

incdir  = include_directories('include', '.')

thread_dep = dependency('threads')

compiler = meson.get_compiler('cpp')

sstream_test = '''#include<sstream>
void func() { stringstream message; message << "Hello"; }
'''
LOG4CPP_HAVE_SSTREAM = compiler.compiles(sstream_test, name : 'has sstream')

int64_test = '''#include<stdint.h>
int64_t i;
'''
LOG4CPP_HAVE_INT64_T = compiler.compiles(int64_test, name : 'has int64_t')

conf_data = configuration_data()

conf_data.set('LOG4CPP_HAVE_SSTREAM', LOG4CPP_HAVE_SSTREAM, description: 'define if the compiler has stringstream')

LOG4CPP_HAVE_GETTIMEOFDAY = compiler.has_function('gettimeofday', prefix : '#include<sys/time.h>')
conf_data.set('LOG4CPP_HAVE_GETTIMEOFDAY', LOG4CPP_HAVE_GETTIMEOFDAY, description: 'Define if you have the gettimeofday function.')

LOG4CPP_HAVE_SNPRINTF = compiler.has_function('snprintf', prefix : '#include<cstdio>')
conf_data.set('LOG4CPP_HAVE_SNPRINTF', LOG4CPP_HAVE_SNPRINTF, description: 'define if the C library has snprintf.')

LOG4CPP_HAVE_SYSLOG = compiler.has_function('syslog', prefix : '#include<syslog.h>')
conf_data.set('LOG4CPP_HAVE_SYSLOG', LOG4CPP_HAVE_SYSLOG, description: 'define if the C library has the syslog function.')

LOG4CPP_HAVE_FTIME  = compiler.has_function('ftime', prefix : '#include<sys/timeb.h>')
conf_data.set('LOG4CPP_HAVE_FTIME', LOG4CPP_HAVE_FTIME, description: 'define if the C library has ftime.')

LOG4CPP_HAVE_UNISTD_H = compiler.has_header('unistd.h')
conf_data.set('LOG4CPP_HAVE_UNISTD_H', LOG4CPP_HAVE_UNISTD_H, description: 'Define if you have the <unistd.h> header file.')

LOG4CPP_HAVE_STDINT_H = compiler.has_header('stdint.h')
conf_data.set('LOG4CPP_HAVE_STDINT_H', LOG4CPP_HAVE_STDINT_H, description: 'Define if you have the <stdint.h> header file.')

LOG4CPP_HAVE_IO_H = compiler.has_header('io.h')
conf_data.set('LOG4CPP_HAVE_IO_H', LOG4CPP_HAVE_IO_H, description: 'Define if you have the <io.h> header file.')

LOG4CPP_HAVE_THREADING = thread_dep.found()
conf_data.set('LOG4CPP_HAVE_THREADING', LOG4CPP_HAVE_THREADING, description: 'define if you have threading support')

LOG4CPP_USE_PTHREADS = compiler.has_header('pthread.h')
conf_data.set('LOG4CPP_USE_PTHREADS', LOG4CPP_USE_PTHREADS, description: 'define if you use pthreads')

idsa_test = '''#include <idsa.h>
  void func() { idsa_open((char *)"test", NULL, IDSA_F_FAILOPEN); }
'''
LOG4CPP_HAVE_LIBIDSA = compiler.links(idsa_test, args : '-lidsa', name : 'has idsa')
conf_data.set('LOG4CPP_HAVE_LIBIDSA', LOG4CPP_HAVE_LIBIDSA, description: 'Define if you have the idsa library (-lidsa).')

conf_data.set('LOG4CPP_VERSION', meson.project_version())

configure_file(output : 'config.h',
               configuration : conf_data)

sources = [
    'src/Appender.cpp',
    'src/AppenderSkeleton.cpp',
    'src/AppendersFactory.cpp',
    'src/BufferingAppender.cpp',
    'src/FactoryParams.cpp',
    'src/LayoutsFactory.cpp',
    'src/LevelEvaluator.cpp',
    'src/Localtime.cpp',
    'src/PassThroughLayout.cpp',
    'src/TriggeringEventEvaluatorFactory.cpp',
    'src/LayoutAppender.cpp',
    'src/FileAppender.cpp',
    'src/DailyRollingFileAppender.cpp',
    'src/RollingFileAppender.cpp',
    'src/FixedContextCategory.cpp',
    'src/IdsaAppender.cpp',
    'src/OstreamAppender.cpp',
    'src/StringQueueAppender.cpp',
    'src/SyslogAppender.cpp',
    'src/RemoteSyslogAppender.cpp',
    'src/SimpleLayout.cpp',
    'src/BasicLayout.cpp',
    'src/PatternLayout.cpp',
    'src/Category.cpp',
    'src/CategoryStream.cpp',
    'src/HierarchyMaintainer.cpp',
    'src/Configurator.cpp',
    'src/BasicConfigurator.cpp',
    'src/SimpleConfigurator.cpp',
    'src/PropertyConfigurator.cpp',
    'src/PropertyConfiguratorImpl.cpp',
    'src/LoggingEvent.cpp',
    'src/Priority.cpp',
    'src/NDC.cpp',
    'src/Filter.cpp',
    'src/TimeStamp.cpp',
    'src/StringUtil.cpp',
    'src/Properties.cpp',
    'src/Win32DebugAppender.cpp',
    'src/NTEventLogAppender.cpp',
    'src/DllMain.cpp',
    'src/DummyThreads.cpp',
    'src/MSThreads.cpp',
    'src/OmniThreads.cpp',
    'src/PThreads.cpp',
    'src/PortabilityImpl.cpp',
    'src/AbortAppender.cpp'
]

library('log4cpp', sources, include_directories: incdir, dependencies: thread_dep)

# TODO
# subdir('tests')
