# New ports collection makefile for:   openj9-openjdk-jdk17
# Version required:    0.33.0
# Date created:        2022-08-10
# Whom:                bmarwell
#
# $FreeBSD$
#
       
PORTNAME=	openj9-openjdk-jdk17
PORTVERSION=	0.33.0
DISTNAME=	openj9-${DISTVERSIONFULL}
CATEGORIES=	java
#USE_GITHUB=	yes
#GH_ACCOUNT=	ibmruntimes
MASTER_SITES=	https://github.com/ibmruntimes/openj9-openjdk-jdk17/archive/refs/tags/:openj9openjdkjdk17 \
		https://github.com/eclipse-openj9/openj9/archive/refs/tags/:openj9 \
		https://github.com/eclipse-openj9/openj9-omr/archive/refs/tags/:omr
DISTFILES=	openj9-${DISTVERSIONFULL}.tar.gz:openj9openjdkjdk17 \
		openj9-${DISTVERSIONFULL}.tar.gz:openj9 \
		openj9-${DISTVERSIONFULL}.tar.gz:omr
DIST_SUBDIR     = ${PORTNAME}
WRKSRC=		${WRKDIR}/${PORTNAME}-${DISTNAME}
       
MAINTAINER=	bmarwell@apache.org
COMMENT=	Java Development Kit based on OpenJDK with Eclipse OpenJ9

LICENSE=	GPLv2
#LICENSE_FILE=	${WRKSRC}/LICENSE
       
# bootstrap JDK needed
USES=		ssl shebangfix autoreconf
#BUILD_DEPENDS=	bash:shells/bash

GNU_CONFIGURE=	yes
CONFIGURE_ENV=  CC=${CC} \
                CXX=${CXX} \
                CPP=${CPP}
CONFIGURE_ARGS=	--with-boot-jdk=/usr/local/openjdk17 \
		--enable-jitserver=no \
		--with-cmake \
		--with-openj9-cc=/usr/local/bin/gcc \
		--with-openj9-cxx=/usr/local/bin/g++
# bootstrap JDK
BOOTSTRAPJDKDIR?=       ${LOCALBASE}/bootstrap-openjdk17
BUILD_DEPENDS+=         ${BOOTSTRAPJDKDIR}/bin/javac:java/bootstrap-openjdk17

USE_IMAKE=	yes

pre-configure:
	 ${CHMOD} +x ${WRKSRC}/configure ${WRKSRC}/get_source.sh
	 ${WRKSRC}/get_source.sh

.include <bsd.port.mk>
