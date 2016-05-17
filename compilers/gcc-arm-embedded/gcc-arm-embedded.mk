#
# Copyright 2016 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#
ifeq ($(findstring ${BUILD_ROOT},${CURDIR}),)
include ${PROJECT_ROOT}/tools/makefiles/target.mk
else

include ${PROJECT_ROOT}/common.mk

IMAGE_PATH := ${IMAGE_ROOT}
DOWNLOAD_PATH := ${ARCHIVE_ROOT}

SOURCE_BASE := gcc-arm-none-eabi
SOURCE_VERSION := 5_3-2016q1
SOURCE_RELEASE_DATE := 20160330
SOURCE_PACKAGE := ${SOURCE_BASE}-${SOURCE_VERSION}-${SOURCE_RELEASE_DATE}-src.tar.bz2
SOURCE_URI := https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download
SOURCE_MD5_URI := ${SOURCE_URI}/${SOURCE_PACKAGE}/+md5

all: ${IMAGE_PATH}/${SOURCE_BASE}-linux.tar.bz2

clean:
	rm -rf ${IMAGE_PATH}/${SOURCE_BASE}-linux.tar.bz2

${IMAGE_PATH}/${SOURCE_BASE}-linux.tar.bz2: pkg/${SOURCE_BASE}-linux.tar.bz2
	mkdir -p ${IMAGE_PATH}
#	ln -f ${BUILD_PATH}/pkg/${SOURCE_BASE}-linux.tar.bz2 ${IMAGE_PATH}/${SOURCE_BASE}-linux.tar.bz2

pkg/${SOURCE_BASE}-linux.tar.bz2: release.txt
	$(Q)./build-prerequisites.sh --skip_steps=mingw32
	$(Q)./build-toolchain.sh --build_type=native --skip_steps=mingw32,manual
	
release.txt: ${DOWNLOAD_PATH}/${SOURCE_PACKAGE}
	$(Q)tar --strip=1 -mxf ${DOWNLOAD_PATH}/${SOURCE_PACKAGE}
	$(Q)cd src && find -name "*.tar.*" | xargs -I% tar -xf %

${DOWNLOAD_PATH}/${SOURCE_PACKAGE}:
	$(Q)mkdir -p ${DOWNLOAD_PATH}
	$(Q)wget ${SOURCE_URI}/${SOURCE_PACKAGE} -O ${DOWNLOAD_PATH}/${SOURCE_PACKAGE}
	$(Q)wget ${SOURCE_URI}/${SOURCE_PACKAGE}/+md5 -O ${DOWNLOAD_PATH}/${SOURCE_PACKAGE}.md5

endif
