
INCLUDES = -I$(top_builddir)/include -I$(top_srcdir)/include -I@srcdir@/include
LDADDS = $(STATIC_BINARIES) $(WARN_CFLAGS) $(top_builddir)/src/libvirt.la 	$(COVERAGE_LDFLAGS)

noinst_PROGRAMS=info1

info1_SOURCES=info1.c
info1_LDFLAGS=
info1_LDADD= $(LDADDS)
