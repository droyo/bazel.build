"""Shorthands for building plan9port libs and binaries."""

_common_copts = [
  '-O2',
  '-Wall',
  '-Wno-parentheses',
  '-Wno-unused-result',
  '-Wno-missing-braces',
  '-Wno-switch',
  '-Wno-comment',
  '-Wno-sign-compare',
  '-Wno-unknown-pragmas',
  '-fno-omit-frame-pointer',
  '-fsigned-char',
  '-fno-optimize-sibling-calls',
]
_common_defines = [
  'PLAN9PORT_USING_PTHREADS',
  'PLAN9PORT',
]

def p9p_library(name, **kwargs):
  """Build a cc_library with appropriate compiler directives."""

  kwargs['copts'] =  _common_copts + kwargs.get('copts', [])
  kwargs['defines'] = _common_defines + kwargs.get('defines', [])

  hdr = name.split('lib', 1)[-1] + '.h'
  kwargs['hdrs'] = kwargs.get('hdrs', ['include/' + hdr])

  kwargs['includes'] = [
    'include',
    'src/' + name
  ] + kwargs.get('includes', [])

  kwargs['srcs'] = kwargs.get('srcs', native.glob(
    include=['src/' + name + '/**/*.c', 'src/' + name + '/**/*.h'],
    exclude=['src/' + name + '/**/test*.c', 'src/' + name + '/**/debug*.c'],
  ))

  native.cc_library(name=name, **kwargs)

def p9p_binary(name, **kwargs):
  """Build a cc_binary with appropriate compiler directives."""

  kwargs['copts'] =  _common_copts + kwargs.get('copts', [])
  kwargs['defines'] = _common_defines + kwargs.get('defines', [])

  kwargs['includes'] = [
    'include',
    'src/cmd/' + name,
  ] + kwargs.get('includes', [])

  kwargs['srcs'] = kwargs.get('srcs', native.glob([
    'src/cmd/' + name + '.c',
    'src/cmd/' + name + '.h',
    'src/cmd/' + name + '/*.c',
    'src/cmd/' + name + '/*.h',
  ]))

  native.cc_binary(name=name, **kwargs)

def p9p_yacc(name, file, **kwargs):
  dirname = file.rsplit('/', 1)[0]
  kwargs['tools'] = kwargs.get('tools', []) + [
    ':yacc',
    'lib/yaccpar',
    'lib/yaccpars',
  ]
  kwargs['srcs'] = [file]
  kwargs['outs'] = kwargs.get('outs', [
    dirname + '/y.tab.c',
    dirname + '/y.tab.h',
  ])
  kwargs['message'] = kwargs.get('message', 'YACC $<')

  cmd = ('PLAN9=$$(dirname $$(dirname $(location lib/yaccpar)))' +
         ' $(location :yacc) -d -s $(@D)/' + dirname + '/y $<')
  kwargs['cmd'] = kwargs.get('cmd', cmd)

  native.genrule(name=name, **kwargs)

def p9p_lex(name, file, **kwargs):
  dirname = file.rsplit('/', 1)[0]
  kwargs['tools'] = [':lex']
  kwargs['srcs'] = file
  kwargs['outs'] = [dirname + '/lex.yy.c']
  kwargs['message'] = kwargs.get('message', 'LEX $<')
  cmd = ('PLAN9=$$(dirname $$(dirname $(location lib/lex.ncform)))' +
         ' $(location :lex) -t $< > $@')
  kwargs['cmd'] = kwargs.get('cmd', cmd)

  native.genrule(name=name, **kwargs)
