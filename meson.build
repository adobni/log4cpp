project('log4cpp', 'cpp', version : '1.1.1')

incdir  = include_directories('include', '.')


compiler = meson.get_compiler('cpp')

code = '''#include<sstream>
void func() { stringstream message; message << "Hello"; return 0; }
'''
LOG4CPP_HAVE_SSTREAM = compiler.compiles(code, name : 'has sstream')

LOG4CPP_HAVE_UNISTD_H = compiler.has_header('unistd.h')

LOG4CPP_HAVE_GETTIMEOFDAY = compiler.has_function('gettimeofday', prefix : '#include<sys/time.h>')
LOG4CPP_HAVE_SNPRINTF = compiler.has_function('snprintf', prefix : '#include<cstdio>')

LOG4CPP_HAVE_STDINT_H = compiler.has_header('stdint.h')
LOG4CPP_HAVE_IO_H = compiler.has_header('io.h')

conf_data = configuration_data()
conf_data.set('LOG4CPP_HAVE_SSTREAM', LOG4CPP_HAVE_SSTREAM, description: 'define if the compiler has stringstream')
conf_data.set('LOG4CPP_HAVE_GETTIMEOFDAY', LOG4CPP_HAVE_GETTIMEOFDAY, description: 'Define if you have the gettimeofday function.')
conf_data.set('LOG4CPP_HAVE_SNPRINTF', LOG4CPP_HAVE_SNPRINTF, description: 'define if the C library has snprintf.')

conf_data.set('LOG4CPP_HAVE_UNISTD_H', LOG4CPP_HAVE_UNISTD_H, description: 'Define if you have the <unistd.h> header file.')
conf_data.set('LOG4CPP_HAVE_STDINT_H', LOG4CPP_HAVE_STDINT_H, description: 'Define if you have the <stdint.h> header file.')
conf_data.set('LOG4CPP_HAVE_IO_H', LOG4CPP_HAVE_IO_H, description: 'Define if you have the <io.h> header file.')



conf_data.set('LOG4CPP_VERSION', meson.project_version())
conf_data.set('LOG4CPP_PACKAGE', '') # TODO

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

thread_dep = dependency('threads')

library('log4cpp', sources, include_directories: incdir, dependencies: thread_dep)

# TODO
# subdir('tests')
