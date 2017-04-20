project('log4cpp', 'cpp', version : '1.1.1')

incdir  = include_directories('include', '.')


thread_impl = get_option('LOG4CPP_USE_THREADING')
if thread_impl == 'LOG4CPP_USE_SYSTEM_THREADS'
  thread_dep = dependency('threads', required: true)
elif thread_impl == 'LOG4CPP_USE_BOOSTTHREADS'
  thread_dep = dependency('boost', modules: ['thread'], required: true)
elif thread_impl == 'LOG4CPP_USE_NOTHREADS'
  thread_dep = []
else
  error('Invalid threading option!')
endif

compiler = meson.get_compiler('cpp')

cppflags = []
if compiler.get_id() == 'gcc' or compiler.get_id() == 'clang'
  cppflags += [
    '-Wall',
    '-pedantic'
  ]
endif

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

conf_data.set('LOG4CPP_HAVE_THREADING', thread_impl == 'LOG4CPP_USE_NOTHREADS', description: 'define if you have threading support')

conf_data.set('LOG4CPP_USE_BOOSTTHREADS', thread_impl == 'LOG4CPP_USE_BOOSTTHREADS', description: 'define if you use Boost threads')

# Decide if system threads means pthreads or ms threads. There should be a more elegant way to do this.
if thread_impl == 'LOG4CPP_USE_SYSTEM_THREADS'
  LOG4CPP_HAS_PTHREADS = compiler.has_header('pthread.h')
  conf_data.set('LOG4CPP_USE_PTHREADS', LOG4CPP_HAS_PTHREADS, description: 'define if you use pthreads')
  conf_data.set('LOG4CPP_USE_MSTHREADS', not LOG4CPP_HAS_PTHREADS, description: 'define if you use ms threads')
endif

idsa_test = '''#include <idsa.h>
  void func() { idsa_open((char *)"test", NULL, IDSA_F_FAILOPEN); }
'''
LOG4CPP_HAVE_LIBIDSA = compiler.links(idsa_test, args : '-lidsa', name : 'has idsa')
conf_data.set('LOG4CPP_HAVE_LIBIDSA', LOG4CPP_HAVE_LIBIDSA, description: 'Define if you have the idsa library (-lidsa).')

conf_data.set('LOG4CPP_VERSION', meson.project_version())

configure_file(output : 'config.h',
               configuration : conf_data, install_dir: join_paths('include', 'log4cpp'))

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

library('log4cpp', sources,
  include_directories: incdir,
  dependencies: thread_dep,
  install : true,
  install_dir : join_paths('lib', 'log4cpp'),
  cpp_args: cppflags)

headers = [
  'include/log4cpp/AbortAppender.hh',
  'include/log4cpp/Appender.hh',
  'include/log4cpp/AppendersFactory.hh',
  'include/log4cpp/AppenderSkeleton.hh',
  'include/log4cpp/BasicConfigurator.hh',
  'include/log4cpp/BasicLayout.hh',
  'include/log4cpp/BufferingAppender.hh',
  'include/log4cpp/Category.hh',
  'include/log4cpp/CategoryStream.hh',
  'include/log4cpp/config-MinGW32.h',
  'include/log4cpp/config-openvms.h',
  'include/log4cpp/Configurator.hh',
  'include/log4cpp/config-win32.h',
  'include/log4cpp/config-win32-stlport-boost.h',
  'include/log4cpp/convenience.h',
  'include/log4cpp/DailyRollingFileAppender.hh',
  'include/log4cpp/Export.hh',
  'include/log4cpp/FactoryParams.hh',
  'include/log4cpp/FileAppender.hh',
  'include/log4cpp/Filter.hh',
  'include/log4cpp/FixedContextCategory.hh',
  'include/log4cpp/HierarchyMaintainer.hh',
  'include/log4cpp/IdsaAppender.hh',
  'include/log4cpp/LayoutAppender.hh',
  'include/log4cpp/Layout.hh',
  'include/log4cpp/LayoutsFactory.hh',
  'include/log4cpp/LevelEvaluator.hh',
  'include/log4cpp/LoggingEvent.hh',
  'include/log4cpp/Makefile.am',
  'include/log4cpp/Manipulator.hh',
  'include/log4cpp/NDC.hh',
  'include/log4cpp/NTEventLogAppender.hh',
  'include/log4cpp/OstreamAppender.hh',
  'include/log4cpp/PassThroughLayout.hh',
  'include/log4cpp/PatternLayout.hh',
  'include/log4cpp/Portability.hh',
  'include/log4cpp/Priority.hh',
  'include/log4cpp/PropertyConfigurator.hh',
  'include/log4cpp/RemoteSyslogAppender.hh',
  'include/log4cpp/RollingFileAppender.hh',
  'include/log4cpp/SimpleConfigurator.hh',
  'include/log4cpp/SimpleLayout.hh',
  'include/log4cpp/SmtpAppender.hh',
  'include/log4cpp/StringQueueAppender.hh',
  'include/log4cpp/SyslogAppender.hh',
  'include/log4cpp/TimeStamp.hh',
  'include/log4cpp/TriggeringEventEvaluatorFactory.hh',
  'include/log4cpp/TriggeringEventEvaluator.hh',
  'include/log4cpp/Win32DebugAppender.hh',
  'include/log4cpp/threading/BoostThreads.hh',
  'include/log4cpp/threading/DummyThreads.hh',
  'include/log4cpp/threading/MSThreads.hh',
  'include/log4cpp/threading/OmniThreads.hh',
  'include/log4cpp/threading/PThreads.hh',
  'include/log4cpp/threading/Threading.hh'
]

install_headers(headers, subdir : 'log4cpp')

doxygen = find_program('doxygen', required: false)
if doxygen.found()
  subdir('doc')
else
  message('Documentation disabled without doxygen')
endif

# TODO
# subdir('tests')
