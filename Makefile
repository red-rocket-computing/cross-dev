.DEFAULT_GOAL := all
ifeq (${MAKECMDGOALS},)
MAKECMDGOALS := all
endif

export ARCH_CROSS ?= host
export BUILD_TYPE ?=  release
export PROJECT_ROOT ?= ${CURDIR}
export OUTPUT_ROOT ?= ${PROJECT_ROOT}/build
export TOOLS_ROOT ?= ${PROJECT_ROOT}/tools
export PREFIX ?= ${PROJECT_ROOT}/images

export INSTALL_ROOT ?= ${PREFIX}$(if ${BUILD_TYPE},/${BUILD_TYPE},)
export BUILD_ROOT ?= ${OUTPUT_ROOT}$(if ${BUILD_TYPE},/${BUILD_TYPE},)

ifeq (${V},)
SILENT=--silent
endif

MAKEFLAGS += ${SILENT}

include ${TOOLS_ROOT}/makefiles/tree.mk

target: compilers

TOOLCHAIN_NAME := gcc-arm-none-eabi-$(shell grep CT_GCC_VERSION= ${PROJECT_ROOT}/compilers/cross-ng-arm-none-eabi/arm-none-eabi.conf | cut -d \" -f 2 | sed 's/\./-/g')

test:
	@echo ${TOOLCHAIN_NAME}

distclean:
	@echo "DISTCLEAN ${BUILD_ROOT} ${INSTALL_ROOT}"
	-${RM} -r ${BUILD_ROOT} ${INSTALL_ROOT}

realclean:
	-${RM} -r ${OUTPUT_ROOT} ${PREFIX} 

info:
	@echo "BUILD_TYPE=${BUILD_TYPE}"
	@echo "PROJECT_ROOT=${PROJECT_ROOT}"
	@echo "OUTPUT_ROOT=${OUTPUT_ROOT}"
	@echo "TOOLS_ROOT=${TOOLS_ROOT}"
	@echo "PREFIX=${PREFIX}"
	@echo "BUILD_ROOT=${BUILD_ROOT}"
	@echo "INSTALL_ROOT=${INSTALL_ROOT}"
.PHONY: info

help:
	@echo "all           Build everything"
	@echo "clean         Run the clean action of all projects"
	@echo "distclean     Delete all build artifacts and qualified directories"
	@echo "realclean     Delete all build artifacts, directories and external repositories"
	@echo "info          Display build configuration"
.PHONY: help

${V}.SILENT:
