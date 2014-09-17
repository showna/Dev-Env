COMMON_CFLAGS= -c -Wall -DRTI_LINUX -DRTI_UNIX -D__LITTLE_ENDIAN__

ifeq ($(findstring i86Linux2.6gcc4,$(NDDSTARGET)), i86Linux2.6gcc4)
	CFLAGS= $(COMMON_CFLAGS) -m32 -fpic
	LDFLAGS=-m32
endif
ifeq ($(findstring x64Linux2.6gcc4,$(NDDSTARGET)), x64Linux2.6gcc4)
	CFLAGS= $(COMMON_CFLAGS) -DRTI_64BIT -m64 -fpic
	LDFLAGS=-m64
endif

CFLAGS_DEBUG= $(CFLAGS) -g
CFLAGS += -O2

TARGET= $(NDDSTARGET)

INCLUDE_DIRS+= -I$(NDDSHOME)/include \
	       -I$(NDDSHOME)/include/ndds

LIBRARY_PATH= -L$(NDDSHOME)/lib/$(NDDSTARGET)
JAVA_LIBRARY_PATH = -L$(NDDSHOME)/lib/$(NDDSTARGET)jdk
LIBS+= -lnddsc -lnddscore -ldl
LIBS_CPP+= $(LIBS) -lnddscpp
LIBS_JAVA+= $(LIBS) -lnddsjava
LIBS_DEBUG+= -lnddscd -lnddscored -ldl
LIBS_CPP_DEBUG+= $(LIBS_DEBUG) -lnddscppd
LIBS_JAVA_DEBUG+= $(LIBS_DEBUG) -lnddsjavad
