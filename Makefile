# New ports collection makefile for:   openj9-openjdk-jdk17
# Version required:    0.33.0
# Date created:        2022-08-10
# Whom:                bmarwell
#
# $FreeBSD$
#
       
PORTNAME=	openj9
PORTVERSION=	0.33.0
CATEGORIES=	java
#USE_GITHUB=	yes
#GH_ACCOUNT=	ibmruntimes
MASTER_SITES=	https://github.com/ibmruntimes/openj9-openjdk-jdk17/archive/refs/tags/
       
MAINTAINER=	bmarwell@apache.org
COMMENT=	Java Development Kit based on OpenJDK with Eclipse OpenJ9

LICENSE=	GPLv2
#LICENSE_FILE=	${WRKSRC}/LICENSE
       
# bootstrap JDK needed
USES=		ssl shebangfix
#BUILD_DEPENDS=	bash:shells/bash

CONFIGURE_ARGS=	--disable-werror \
		--with-boot-jdk=/usr/local/openjdk17 \
		--enable-jitserver=no \
		--with-cmake \
		--with-openj9-cc=/usr/local/bin/gcc \
		--with-openj9-cxx=/usr/local/bin/g++
GNU_CONFIGURE=	yes

USE_IMAKE=	yes

.include <bsd.port.mk>
