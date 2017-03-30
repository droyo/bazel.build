# Builds M4 as a prerequisite for building GCC
package(default_visibility = ["//visibility:private"])

genrule(
    name = "autoconf",
    outs = [
      "lib/alloca.h",
      "lib/config.h",
      "lib/configmake.h",
      "lib/fcntl.h",
      "lib/getopt.h",
      "lib/isnan.c",
      "lib/langinfo.h",
      "lib/locale.h",
      "lib/math.h",
      "lib/signal.h",
      "lib/spawn.h",
      "lib/stdio.h",
      "lib/stdlib.h",
      "lib/string.h",
      "lib/time.h",
      "lib/unistd.h",
      "lib/unused-parameter.h",
      "lib/wchar.h",
      "lib/wctype.h",
    ],
    cmd = """
      workdir=$$(mktemp -d -t tmp.XXXXXXXX)
      trap "rm -rf $$workdir" EXIT
      (cd external/m4 && cp -a * $$workdir)
      pushd $$workdir
        ./configure > configure.log
        pushd lib
          make -s $$(echo $(OUTS) | xargs -n1 basename)
        popd
      popd
      for hdr in $(OUTS)
      do
        cp $$workdir/lib/$$(basename $$hdr) $(@D)/lib
      done
      rm -rf $$workdir
    """,
    local = 1,
)

cc_library(
    name = "libm4",
    hdrs = glob(["lib/*.h"]) + [
      "lib/isnan.c",
      "lib/printf-frexp.c",
    ],
    includes = ["lib"],
    srcs = [
      ":autoconf",
      "lib/asnprintf.c",
      "lib/asprintf.c",
      "lib/basename.c",
      "lib/basename-lgpl.c",
      "lib/binary-io.c",
      "lib/c-ctype.c",
      "lib/clean-temp.c",
      "lib/cloexec.c",
      "lib/closein.c",
      "lib/closeout.c",
      "lib/close-stream.c",
      "lib/c-stack.c",
      "lib/c-strcasecmp.c",
      "lib/c-strncasecmp.c",
      "lib/dirname.c",
      "lib/dirname-lgpl.c",
      "lib/dup-safer.c",
      "lib/dup-safer-flag.c",
      "lib/execute.c",
      "lib/exitfail.c",
      "lib/fatal-signal.c",
      "lib/fclose.c",
      "lib/fcntl.c",
      "lib/fd-hook.c",
      "lib/fd-safer.c",
      "lib/fd-safer-flag.c",
      "lib/fflush.c",
      "lib/filenamecat.c",
      "lib/filenamecat-lgpl.c",
      "lib/fopen-safer.c",
      "lib/fpurge.c",
      "lib/freadahead.c",
      "lib/freading.c",
      "lib/fseek.c",
      "lib/fseeko.c",
      "lib/gl_avltree_oset.c",
      "lib/gl_linkedhash_list.c",
      "lib/gl_list.c",
      "lib/gl_oset.c",
      "lib/gl_xlist.c",
      "lib/gl_xoset.c",
      "lib/isnand.c",
      "lib/isnanf.c",
      "lib/isnanl.c",
      "lib/localcharset.c",
      "lib/malloca.c",
      "lib/math.c",
      "lib/memchr2.c",
      "lib/mkstemp-safer.c",
      "lib/pipe2.c",
      "lib/pipe2-safer.c",
      "lib/pipe-safer.c",
      "lib/printf-args.c",
      "lib/printf-frexpl.c",
      "lib/printf-parse.c",
      "lib/progname.c",
      "lib/quotearg.c",
      "lib/sig-handler.c",
      "lib/spawn-pipe.c",
      "lib/stripslash.c",
      "lib/tempname.c",
      "lib/tmpdir.c",
      "lib/unistd.c",
      "lib/vasnprintf.c",
      "lib/vasprintf.c",
      "lib/verror.c",
      "lib/version-etc.c",
      "lib/version-etc-fsf.c",
      "lib/wait-process.c",
      "lib/wctype-h.c",
      "lib/xalloc-die.c",
      "lib/xasprintf.c",
      "lib/xmalloca.c",
      "lib/xmalloc.c",
      "lib/xprintf.c",
      "lib/xsize.c",
      "lib/xstrndup.c",
      "lib/xvasprintf.c",
    ],
)

cc_library(
    name = "glthread",
    deps = [":libm4"],
    hdrs = glob(["lib/glthread/*.h"]),
    srcs = glob(["lib/glthread/*.c"]) + [":autoconf"],
)

cc_binary(
    name = "m4",
    deps = ["glthread", "libm4"],
    data = glob(["m4/*.m4"]),
    srcs = glob(["src/*.c", "src/*.h"]),
    visibility = ["//visibility:public"],
)