## Process this file with automake to produce Makefile.in

SHELL = $(PREFERABLY_POSIX_SHELL)

SUBDIRS = confdata sexpr2xmldata \
  xml2sexprdata xmconfigdata xencapsdata

INCLUDES = \
	-I$(top_srcdir)/gnulib/lib -I../gnulib/lib \
	-I$(top_builddir)/include \
	-I$(top_srcdir)/include \
	-I$(top_srcdir)/src \
	-I$(top_srcdir)/src/util \
	-I$(top_srcdir)/src/conf \
	$(LIBXML_CFLAGS) \
	$(GNUTLS_CFLAGS) \
	$(SASL_CFLAGS) \
	$(SELINUX_CFLAGS) \
	$(APPARMOR_CFLAGS) \
        -DGETTEXT_PACKAGE=\"$(PACKAGE)\" \
         $(COVERAGE_CFLAGS) \
         $(WARN_CFLAGS)

if WITH_DRIVER_MODULES
INCLUDES += \
	-DTEST_DRIVER_DIR=\"$(top_builddir)/src/.libs\"
endif

LDADDS = \
	$(STATIC_BINARIES) \
	$(LIBXML_LIBS) \
        $(GNUTLS_LIBS) \
        $(SASL_LIBS) \
        $(SELINUX_LIBS) \
        $(APPARMOR_LIBS) \
        $(WARN_CFLAGS) \
	../src/libvirt_test.la \
	../gnulib/lib/libgnu.la \
	$(LIBSOCKET) \
        $(COVERAGE_LDFLAGS)

EXTRA_DIST =		\
        oomtrace.pl     \
	test-lib.sh	\
	qemuxml2argvdata \
	qemuxml2xmloutdata \
	nodeinfodata     \
	schematestutils.sh \
	capabilityschematest \
	capabilityschemadata \
	networkschematest \
	networkxml2xmlout \
	networkxml2xmlin \
	domainschematest \
	domainschemadata \
	interfaceschemadata \
	storagepoolschematest \
	storagepoolxml2xmlout \
	storagepoolxml2xmlin \
	storagevolschematest \
	storagevolxml2xmlout \
	storagevolxml2xmlin \
	nodedevschematest \
	nodedevschemadata \
	vmx2xmldata \
	xml2vmxdata \
	nwfilterxml2xmlout \
	nwfilterxml2xmlin \
	nwfilterschematest \
	domainsnapshotschematest \
	domainsnapshotxml2xmlout \
	domainsnapshotxml2xmlin \
	qemuhelpdata

noinst_PROGRAMS = virshtest conftest \
        nodeinfotest statstest qparamtest

if WITH_XEN
noinst_PROGRAMS += xml2sexprtest sexpr2xmltest \
	reconnect xmconfigtest xencapstest
endif
if WITH_QEMU
noinst_PROGRAMS += qemuxml2argvtest qemuxml2xmltest qemuargv2xmltest qemuhelptest
endif

if WITH_ESX
noinst_PROGRAMS += esxutilstest vmx2xmltest xml2vmxtest
endif

if WITH_SECDRIVER_SELINUX
noinst_PROGRAMS += seclabeltest
endif

if WITH_SECDRIVER_APPARMOR
noinst_PROGRAMS += secaatest
endif

if WITH_CIL
noinst_PROGRAMS += object-locking
endif

noinst_PROGRAMS += networkxml2xmltest

noinst_PROGRAMS += nwfilterxml2xmltest

noinst_PROGRAMS += storagevolxml2xmltest storagepoolxml2xmltest

noinst_PROGRAMS += nodedevxml2xmltest

noinst_PROGRAMS += interfacexml2xmltest

test_scripts = \
	capabilityschematest \
	interfaceschematest \
	networkschematest \
	storagepoolschematest \
	storagevolschematest \
	domainschematest \
	nodedevschematest \
	nwfilterschematest \
	domainsnapshotschematest

if WITH_LIBVIRTD
test_scripts +=				\
	test_conf.sh			\
	cpuset				\
	daemon-conf			\
	define-dev-segfault		\
	int-overflow			\
	libvirtd-fail			\
	libvirtd-pool			\
	read-bufsiz			\
	read-non-seekable		\
	start				\
	undefine			\
	vcpupin				\
	virsh-all			\
	virsh-schedinfo			\
	virsh-synopsis
endif

if WITH_SECDRIVER_APPARMOR
test_scripts += virt-aa-helper-test
else
EXTRA_DIST += virt-aa-helper-test
endif

EXTRA_DIST += $(test_scripts)

TESTS = virshtest \
        nodeinfotest \
	statstest \
	qparamtest \
	$(test_scripts)

if WITH_XEN
TESTS += xml2sexprtest \
	sexpr2xmltest \
	xmconfigtest \
	xencapstest
if ENABLE_XEN_TESTS
TESTS += reconnect
endif
endif

if WITH_QEMU
TESTS += qemuxml2argvtest qemuxml2xmltest qemuargv2xmltest qemuhelptest
TESTS += nwfilterxml2xmltest
endif

if WITH_ESX
TESTS += esxutilstest vmx2xmltest xml2vmxtest
endif

if WITH_SECDRIVER_SELINUX
TESTS += seclabeltest
endif

if WITH_SECDRIVER_APPARMOR
TESTS += secaatest
endif

if WITH_LIBVIRTD
noinst_PROGRAMS += eventtest
TESTS += eventtest
endif

TESTS += networkxml2xmltest

TESTS += storagevolxml2xmltest storagepoolxml2xmltest

TESTS += nodedevxml2xmltest

TESTS += interfacexml2xmltest

path_add = $$abs_top_builddir/src$(PATH_SEPARATOR)$$abs_top_builddir/daemon$(PATH_SEPARATOR)$$abs_top_builddir/tools

# NB, automake < 1.10 does not provide the real
# abs_top_{src/build}dir variables, so don't rely
# on them here. Fake them with 'pwd'
TESTS_ENVIRONMENT =				\
  abs_top_builddir=`cd '$(top_builddir)'; pwd`	\
  abs_top_srcdir=`cd '$(top_srcdir)'; pwd`	\
  abs_builddir=`cd '$(builddir)'; pwd`		\
  abs_srcdir=`cd '$(srcdir)'; pwd`		\
  CONFIG_HEADER="`cd '$(top_builddir)'; pwd`/config.h"	\
  PATH="$(path_add)$(PATH_SEPARATOR)$$PATH"	\
  SHELL="$(SHELL)"				\
  LIBVIRT_DRIVER_DIR="$(abs_top_builddir)/src/.libs" \
  LIBVIRT_DEBUG="error"				\
  LC_ALL=C					\
  $(VG)

valgrind:
	$(MAKE) check VG="valgrind --quiet --leak-check=full --suppressions=$(srcdir)/.valgrind.supp"

if WITH_XEN
xml2sexprtest_SOURCES = \
	xml2sexprtest.c testutilsxen.c testutilsxen.h \
	testutils.c testutils.h
xml2sexprtest_LDADD = ../src/libvirt_driver_xen.la $(LDADDS)

sexpr2xmltest_SOURCES = \
	sexpr2xmltest.c testutilsxen.c testutilsxen.h \
	testutils.c testutils.h
sexpr2xmltest_LDADD = ../src/libvirt_driver_xen.la $(LDADDS)

xmconfigtest_SOURCES = \
	xmconfigtest.c testutilsxen.c testutilsxen.h \
	testutils.c testutils.h
xmconfigtest_LDADD = ../src/libvirt_driver_xen.la $(LDADDS)

xencapstest_SOURCES = \
	xencapstest.c testutils.h testutils.c
xencapstest_LDADD = ../src/libvirt_driver_xen.la $(LDADDS)

reconnect_SOURCES = \
	reconnect.c
reconnect_LDADD = $(LDADDS)

else
EXTRA_DIST += xml2sexprtest.c sexpr2xmltest.c xmconfigtest.c \
	xencapstest.c reconnect.c \
	testutilsxen.c testutilsxen.h
endif

if WITH_QEMU
qemuxml2argvtest_SOURCES = \
	qemuxml2argvtest.c testutilsqemu.c testutilsqemu.h \
	testutils.c testutils.h
qemuxml2argvtest_LDADD = ../src/libvirt_driver_qemu.la $(LDADDS)

qemuxml2xmltest_SOURCES = \
	qemuxml2xmltest.c testutilsqemu.c testutilsqemu.h \
	testutils.c testutils.h
qemuxml2xmltest_LDADD = ../src/libvirt_driver_qemu.la $(LDADDS)

qemuargv2xmltest_SOURCES = \
	qemuargv2xmltest.c testutilsqemu.c testutilsqemu.h \
	testutils.c testutils.h
qemuargv2xmltest_LDADD = ../src/libvirt_driver_qemu.la $(LDADDS)

qemuhelptest_SOURCES = qemuhelptest.c testutils.c testutils.h
qemuhelptest_LDADD = ../src/libvirt_driver_qemu.la $(LDADDS)
else
EXTRA_DIST += qemuxml2argvtest.c qemuxml2xmltest.c qemuargv2xmltest.c qemuhelptest.c testutilsqemu.c testutilsqemu.h
endif

if WITH_ESX
esxutilstest_SOURCES = \
	esxutilstest.c \
	testutils.c testutils.h
esxutilstest_LDADD = ../src/libvirt_driver_esx.la $(LDADDS)

vmx2xmltest_SOURCES = \
	vmx2xmltest.c \
	testutils.c testutils.h
vmx2xmltest_LDADD = ../src/libvirt_driver_esx.la $(LDADDS)

xml2vmxtest_SOURCES = \
	xml2vmxtest.c \
	testutils.c testutils.h
xml2vmxtest_LDADD = ../src/libvirt_driver_esx.la $(LDADDS)
else
EXTRA_DIST += esxutilstest.c vmx2xmltest.c xml2vmxtest.c
endif

networkxml2xmltest_SOURCES = \
	networkxml2xmltest.c \
	testutils.c testutils.h
networkxml2xmltest_LDADD = $(LDADDS)

nwfilterxml2xmltest_SOURCES = \
	nwfilterxml2xmltest.c \
	testutils.c testutils.h
nwfilterxml2xmltest_LDADD = $(LDADDS)

storagevolxml2xmltest_SOURCES = \
	storagevolxml2xmltest.c \
	testutils.c testutils.h
storagevolxml2xmltest_LDADD = $(LDADDS)

storagepoolxml2xmltest_SOURCES = \
	storagepoolxml2xmltest.c \
	testutils.c testutils.h
storagepoolxml2xmltest_LDADD = $(LDADDS)

nodedevxml2xmltest_SOURCES = \
	nodedevxml2xmltest.c \
	testutils.c testutils.h
nodedevxml2xmltest_LDADD = $(LDADDS)

interfacexml2xmltest_SOURCES = \
	interfacexml2xmltest.c \
	testutils.c testutils.h
interfacexml2xmltest_LDADD = $(LDADDS)

virshtest_SOURCES = \
	virshtest.c \
	testutils.c testutils.h
virshtest_LDADD = $(LDADDS)

conftest_SOURCES = \
	conftest.c
conftest_LDADD = $(LDADDS)

nodeinfotest_SOURCES = \
	nodeinfotest.c testutils.h testutils.c
nodeinfotest_LDADD = $(LDADDS)

statstest_SOURCES = \
	statstest.c testutils.h testutils.c
statstest_LDADD = $(LDADDS)

if WITH_SECDRIVER_SELINUX
seclabeltest_SOURCES = \
	seclabeltest.c
seclabeltest_LDADD = ../src/libvirt_driver_security.la $(LDADDS)
else
EXTRA_DIST += seclabeltest.c
endif

if WITH_SECDRIVER_APPARMOR
secaatest_SOURCES = \
	secaatest.c
secaatest_LDADD = ../src/libvirt_driver_security.la $(LDADDS)
else
EXTRA_DIST += secaatest.c
endif

qparamtest_SOURCES = \
	qparamtest.c testutils.h testutils.c
qparamtest_LDADD = $(LDADDS)

if WITH_LIBVIRTD
eventtest_SOURCES = \
	eventtest.c testutils.h testutils.c ../daemon/event.c
eventtest_LDADD = -lrt $(LDADDS)
endif

if WITH_CIL
CILOPTFLAGS =
CILOPTINCS =
CILOPTPACKAGES = -package unix,str,cil
CILOPTLIBS = -linkpkg

object_locking_SOURCES = object-locking.ml

%.cmx: %.ml
	ocamlfind ocamlopt $(CILOPTFLAGS) $(CILOPTINCS) $(CILOPTPACKAGES) -c $<

object-locking: object-locking.cmx object-locking-files.txt
	ocamlfind ocamlopt $(CILOPTFLAGS) $(CILOPTINCS) $(CILOPTPACKAGES) $(CILOPTLIBS) $< -o $@

object-locking-files.txt:
	find $(top_builddir)/src/ -name '*.i' > $@

else
EXTRA_DIST += object-locking.ml
endif

CLEANFILES = *.cov *.gcov .libs/*.gcda .libs/*.gcno *.gcno *.gcda *.cmi *.cmx object-locking-files.txt
