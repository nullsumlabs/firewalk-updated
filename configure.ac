#   $Id: configure.ac,v 1.3 2002/05/14 00:17:52 route Exp $
#
#   Firewalk 5.0
#   Firewalk autoconfiguration information file
#
#  Copyright (c) 1998 - 2002 Mike D. Schiffman  <mike@infonexus.com>
#  Copyright (c) 1998, 1999 David E. Goldsmith <dave@infonexus.com>
#  http://www.packetfactory.net/firewalk
#
#  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
#
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([firewalk], [5.0.1], [mike@infonexus.com], [firewalk],
        [http://www.packetfactory.net/firewalk])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_AUX_DIR([.])
AC_CONFIG_HEADERS([include/config.h])

AM_INIT_AUTOMAKE([foreign no-dependencies])
AC_CANONICAL_HOST

AC_PROG_CC
AC_PROG_INSTALL
AC_USE_SYSTEM_EXTENSIONS

if test "x$GCC" = xyes; then
    CFLAGS="$CFLAGS -Wall"
fi

dnl
dnl Checks for libraries.
dnl
AC_CHECK_LIB([net], [libnet_init], [LIBNET_LIBS="-lnet"],
    [AC_MSG_ERROR([libnet 1.1 or newer not found.  http://www.packetfactory.net/libnet])])
AC_CHECK_LIB([pcap], [pcap_open_live], [PCAP_LIBS="-lpcap"],
    [AC_MSG_ERROR([libpcap not found.  http://www.tcpdump.org])])

dnl
dnl libdnet is packaged as libdumbnet on Debian and Ubuntu.
dnl
AC_CHECK_HEADERS([dnet.h dumbnet.h])
if test "x$ac_cv_header_dnet_h" != xyes &&
   test "x$ac_cv_header_dumbnet_h" != xyes; then
    AC_MSG_ERROR([libdnet or libdumbnet headers not found.  http://libdnet.sourceforge.net])
fi
AC_CHECK_LIB([dnet], [arp_get], [DNET_LIBS="-ldnet"], [
    AC_CHECK_LIB([dumbnet], [arp_get], [DNET_LIBS="-ldumbnet"],
        [AC_MSG_ERROR([libdnet or libdumbnet not found.  http://libdnet.sourceforge.net])])
])

dnl
dnl OS specific libraries.
dnl
ADDITIONAL_LIBS=""
case "$host_os" in
*solaris*)
    AC_DEFINE([HAVE_SOLARIS], [1], [Define on Solaris.])
    AC_CHECK_LIB([socket], [socket], [ADDITIONAL_LIBS="$ADDITIONAL_LIBS -lsocket"],
        [AC_MSG_ERROR([libsocket not found.])])
    AC_CHECK_LIB([nsl], [gethostbyname], [ADDITIONAL_LIBS="$ADDITIONAL_LIBS -lnsl"],
        [AC_MSG_ERROR([libnsl not found.])])
    ;;
esac

dnl
dnl BSD BPF needs immediate mode for packet capture.
dnl
AC_MSG_CHECKING([for BPF device])
if test -c /dev/bpf0 || test -r /dev/bpf0 ||
   test -c /dev/bpf || test -r /dev/bpf; then
    AC_DEFINE([HAVE_BPF], [1], [Define when a BSD BPF device is available.])
    AC_MSG_RESULT([yes])
else
    AC_MSG_RESULT([no])
fi

AC_SUBST([LIBNET_LIBS])
AC_SUBST([PCAP_LIBS])
AC_SUBST([DNET_LIBS])
AC_SUBST([ADDITIONAL_LIBS])

AC_CONFIG_FILES([Makefile src/Makefile version.h])
AC_OUTPUT

dnl EOF
