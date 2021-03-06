# -*- buffer-read-only: t -*- vi: set ro:
# DO NOT EDIT! GENERATED AUTOMATICALLY!
dnl Reentrant time functions: localtime_r, gmtime_r.

dnl Copyright (C) 2003, 2006-2010 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl Written by Paul Eggert.

AC_DEFUN([gl_TIME_R],
[
  dnl Persuade glibc and Solaris <time.h> to declare localtime_r.
  AC_REQUIRE([gl_USE_SYSTEM_EXTENSIONS])

  AC_REQUIRE([gl_HEADER_TIME_H_DEFAULTS])
  AC_REQUIRE([AC_C_RESTRICT])

  AC_CHECK_FUNCS_ONCE([localtime_r])
  if test $ac_cv_func_localtime_r = yes; then
    AC_CACHE_CHECK([whether localtime_r is compatible with its POSIX signature],
      [gl_cv_time_r_posix],
      [AC_COMPILE_IFELSE(
         [AC_LANG_PROGRAM(
            [[#include <time.h>]],
            [[/* We don't need to append 'restrict's to the argument types,
                 even though the POSIX signature has the 'restrict's,
                 since C99 says they can't affect type compatibility.  */
              struct tm * (*ptr) (time_t const *, struct tm *) = localtime_r;
              if (ptr) return 0;
              /* Check the return type is a pointer.
                 On HP-UX 10 it is 'int'.  */
              *localtime_r (0, 0);]])
         ],
         [gl_cv_time_r_posix=yes],
         [gl_cv_time_r_posix=no])
      ])
    if test $gl_cv_time_r_posix = yes; then
      REPLACE_LOCALTIME_R=0
    else
      REPLACE_LOCALTIME_R=1
    fi
  else
    HAVE_LOCALTIME_R=0
  fi
  if test $HAVE_LOCALTIME_R = 0 || test $REPLACE_LOCALTIME_R = 1; then
    AC_LIBOBJ([time_r])
    gl_PREREQ_TIME_R
  fi
])

# Prerequisites of lib/time_r.c.
AC_DEFUN([gl_PREREQ_TIME_R], [
  :
])
