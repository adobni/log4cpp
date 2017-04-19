doxyfile_conf = configuration_data()
doxyfile_conf.set('PACKAGE_NAME', meson.project_name())
doxyfile_conf.set('PACKAGE_VERSION', meson.project_version())
doxyfile_conf.set('top_srcdir', meson.source_root())
doxyfile_conf.set('top_builddir', meson.build_root())
doxyfile_conf.set('enable_html_docs', 'YES')
doxyfile_conf.set('enable_latex_docs', 'NO')
doxyfile_conf.set('output_dir', join_paths(meson.build_root(), 'doc'))

if find_program('dot', required: false).found()
  doxyfile_conf.set('enable_dot', 'YES')
else
  doxyfile_conf.set('enable_dot', 'NO')
endif

doxyfile = configure_file(input: 'Doxyfile.in',
                          output: 'Doxyfile',
                          configuration: doxyfile_conf,
                          install: false)

docdir = join_paths('doc', 'log4cpp')

html_target = custom_target('log4cpp-docs',
                            input: [ doxyfile ],
                            output: [ 'html', 'man' ],
                            command: [ doxygen, doxyfile ],
                            install: true,
                            install_dir: docdir)
