export PROJECT_ROOT ?= ${CURDIR}
export OUTPUT_ROOT ?= ${PROJECT_ROOT}/build
export INSTALL_ROOT ?= ${PROJECT_ROOT}/root
export TOOLS_ROOT ?= ${PROJECT_ROOT}/tools
export IMAGE_ROOT ?= ${PROJECT_ROOT}/images
export ARCHIVE_ROOT ?= ${PROJECT_ROOT}/downloads
export BUILD_TYPE ?= release

export BUILD_ROOT ?= ${OUTPUT_ROOT}/${BUILD_TYPE}

include common.mk

compilers:
	+$(Q)${MAKE} -C ${PROJECT_ROOT}/compilers --no-print-directory -f compilers.mk ${MAKECMDGOALS}
.PHONY: compilers

all: compilers

clean: compilers

distclean:
	@echo "DISTCLEAN ${PROJECT_ROOT}"
	$(Q)-${RM} -r ${OUTPUT_ROOT} ${IMAGE_ROOT}

realclean: distclean
	@echo "REALCLEAN ${PROJECT_ROOT}"
	$(Q)-${RM} -r ${INSTALL_ROOT} ${ARCHIVE_ROOT}
