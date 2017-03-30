# Extensions to use when building the third-party packages
local_repository(
    name = "build_tools",
    path = "build_tools",
)

# This workplace builds its own compilers for all supported languages.

# GCC prerequisites - version numbers copied from the download_prerequisite
# script of the chosen GCC version.

# This is needed to build GMP and GCC
new_http_archive (
    name = "m4",
    urls = ["http://ftpmirror.gnu.org/gnu/m4/m4-1.4.17.tar.xz"],
    sha256 = "f0543c3beb51fa6b3337d8025331591e0e18d8ec2886ed391f1aade43477d508",
    strip_prefix = "m4-1.4.17",
    build_file = "build-files/BUILD.m4",
)

new_http_archive (
    name = "libgmp",
    urls = ["http://ftpmirror.gnu.org/gnu/gmp/gmp-4.3.2.tar.gz"],
    sha256 = "7be3ad1641b99b17f6a8be6a976f1f954e997c41e919ad7e0c418fe848c13c97",
    strip_prefix = "gmp-4.3.2",
    build_file = "build-files/BUILD.libgmp",
)
new_http_archive (
    name = "libmpc",
    urls = ["http://www.multiprecision.org/mpc/download/mpc-0.8.2.tar.gz"],
    sha256 = "ae79f8d41d8a86456b68607e9ca398d00f8b7342d1d83bcf4428178ac45380c7",
    strip_prefix = "mpc-0.8.2",
    build_file = "build-files/BUILD.libmpc",
)
new_http_archive (
    name = "libmpfr",
    urls = ["http://ftpmirror.gnu.org/gnu/mpfr/mpfr-2.4.2.tar.gz"],
    sha256 = "246d7e184048b1fc48d3696dd302c9774e24e921204221540745e5464022b637",
    strip_prefix = "mpfr-2.4.2",
    build_file = "build-files/BUILD.libmpfr",
)
new_http_archive (
    name = "libisl",
    urls = ["http://isl.gforge.inria.fr/isl-0.15.tar.xz"],
    sha256 = "104a608839771d809558f5fd7533ca1a3b8ee5a667c5dcd9dc3499bf0a1522d5",
    strip_prefix = "isl-0.15",
    build_file = "build-files/BUILD.libisl",
)

# C compiler
new_http_archive (
    name = "gcc",
    urls = ["http://ftpmirror.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.gz"],
    sha256 = "a50308c1824959ead0483d58e1d1b89641812bab28aea474ca5da3298d670c984c19f4565951c16e0937e0efb34e889e20a421d043432c5c2698fe014810b82d",
    build_file = "build-files/BUILD.gcc",
)

# new_http_archive (
#     name = "musl",
#     urls = ["https://www.musl-libc.org/releases/musl-1.1.16.tar.gz"],
#     # Checksum obtained running sha256sum against a downloaded
#     # copy after verifying gpg signature. Matches checksum found
#     # on launchpad.net
#     sha256 = "937185a5e5d721050306cf106507a006c3f1f86d86cd550024ea7be909071011",
#     build_file = "build-files/BUILD.musl",
# )
# 
# new_http_archive (
#     name = "glibc",
#     urls = ["http://ftpmirror.gnu.org/gnu/glibc/glibc-2.25.tar.gz"],
#     sha256 = "ad984bac07844ecc222039d43bd5f1f1e1571590ea28045232ae3fa404cefc32",
#     build_file = "build-files/BUILD.glibc",
# )

# Setup Go rules
git_repository(
    name = "io_bazel_rules_go",
    remote = "https://github.com/bazelbuild/rules_go.git",
    tag = "0.4.1",
)
load("@io_bazel_rules_go//go:def.bzl", "go_repositories")
go_repositories()

# Go packages
new_git_repository(
    name = "gogive",
    remote = "https://github.com/droyo/gogive",
    commit = "0799a4b",
    build_file = "build-files/BUILD.gogive",
)

# Plan 9 from user space
new_git_repository(
    name = "plan9port",
    remote = "https://github.com/9fans/plan9port",
    commit = "9f34853",
    build_file = "build-files/BUILD.plan9port",
)

# System types:
#   --build=BUILD     configure for building on BUILD [guessed]
#   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
# 
# Optional Features:
#   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
#   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
#   --enable-maintainer-mode  enable make rules and dependencies not useful
# 			  (and sometimes confusing) to the casual installer
#   --enable-assert         enable ASSERT checking [default=no]
#   --enable-alloca         how to get temp memory [default=reentrant]
#   --enable-cxx            enable C++ support [default=no]
#   --enable-fft            enable FFTs for multiplication [default=yes]
#   --enable-mpbsd          build Berkeley MP compatibility library
#                           [default=no]
#   --enable-nails          use nails on limbs [default=no]
#   --enable-profiling      build with profiler support [default=no]
#   --enable-fat            build a fat binary on systems that support it
#                           [default=no]
#   --enable-minithres      choose minimal thresholds for testing [default=no]
#   --enable-shared[=PKGS]  build shared libraries [default=yes]
#   --enable-static[=PKGS]  build static libraries [default=yes]
#   --enable-fast-install[=PKGS]
#                           optimize for fast installation [default=yes]
#   --disable-libtool-lock  avoid locking (might break parallel builds)
# 
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-readline         readline support in calc demo program
#                           [default=detect]
#   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#   --with-pic              try to use only PIC/non-PIC objects [default=use
#                           both]
#   --with-tags[=TAGS]      include additional configurations [automatic]
# 
# Some influential environment variables:
#   ABI         desired ABI (for processors supporting more than one ABI)
#   CC          C compiler command
#   CFLAGS      C compiler flags
#   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#               nonstandard directory <lib dir>
#   LIBS        libraries to pass to the linker, e.g. -l<library>
#   CPPFLAGS    C/C++/Objective C preprocessor flags, e.g. -I<include dir> if
#               you have headers in a nonstandard directory <include dir>
#   CPP         C preprocessor
#   CC_FOR_BUILD
#               build system C compiler
#   CPP_FOR_BUILD
#               build system C preprocessor
#   CXX         C++ compiler command
#   CXXFLAGS    C++ compiler flags
#   CXXCPP      C++ preprocessor
#   M4          m4 macro processor
#   YACC        The `Yet Another C Compiler' implementation to use. Defaults to
#               the first program found out of: `bison -y', `byacc', `yacc'.
#   YFLAGS      The list of arguments that will be passed by default to $YACC.
#               This script will default YFLAGS to the empty string to avoid a
#               default value of `-d' given by some make applications.
# 
