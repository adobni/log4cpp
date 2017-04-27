

testmain_src = executable('testmain', 'testmain.cpp',
  include_directories: incdir,
  link_with: log4cpp_dep)
# This seems to be a test of NDC that performs 10000 iterations rather than a unit test.
# It takes 10000 seconds (2.77 hours aprox.) to complete. Run it manually or uncomment next line.
# test('testmain', testmain_src, timeout: 10030)

# depends on sys/time.h so doesn't build on MSVC
has_time_h = compiler.has_header('sys/time.h')
if has_time_h
    testbench_src = executable('testbench', ['testbench.cpp', 'Clock.cpp'],
      include_directories: incdir,
      link_with: log4cpp_dep)
    test('testbench', testbench_src)
endif