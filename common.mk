
ifeq (${.DEFAULT_GOAL},)
.DEFAULT_GOAL := all
endif

ifeq ("$(origin V)", "command line")
VERBOSE = ${V}
endif

ifndef VERBOSE
VERBOSE = 0
endif

ifeq (${VERBOSE},1)
  quiet =
  Q =
else
  quiet = (${1})
  Q = @
endif

CC := ${CROSS_COMPILE}gcc
CXX := ${CROSS_COMPILE}g++
LD := ${CROSS_COMPILE}gcc
AR := ${CROSS_COMPILE}ar
AS := ${CROSS_COMPILE}as
OBJCOPY := ${CROSS_COMPILE}objcopy
OBJDUMP := ${CROSS_COMPILE}objdump
SIZE := ${CROSS_COMPILE}size
NM := ${CROSS_COMPILE}nm
FIND := find

CROSS_FLAGS := 
 
ARFLAGS := 
ASFLAGS := ${CROSS_FLAGS}
CFLAGS := ${CROSS_FLAGS}
CXXFLAGS := ${CROSS_FLAGS}
CPPFLAGS += 
LDFLAGS := ${CROSS_FLAGS}
LDLIBS :=
LOADLIBES := 

