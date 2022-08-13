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
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}
CATEGORIES=	java
USE_GITHUB=	nodefault
GH_TUPLE=	ibmruntimes:openj9-openjdk-jdk17:openj9-${DISTVERSIONFULL}:ibmruntime \
		eclipse-openj9:openj9:openj9-${DISTVERSIONFULL}:openj9/../openj9-openjdk-jdk17-openj9-${DISTVERSIONFULL}/openj9 \
		eclipse-openj9:openj9-omr:openj9-${DISTVERSIONFULL}:openj9omr/../openj9-openjdk-jdk17-openj9-${DISTVERSIONFULL}/omr
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
		--with-openj9-cc=/${CC} \
		--with-openj9-cxx=${CXX}
# bootstrap JDK
BOOTSTRAPJDKDIR?=       ${LOCALBASE}/bootstrap-openjdk17
BUILD_DEPENDS+=         ${BOOTSTRAPJDKDIR}/bin/javac:java/bootstrap-openjdk17

USE_IMAKE=	yes

pre-configure:
	 ${CHMOD} +x ${WRKSRC}/configure ${WRKSRC}/get_source.sh

.include <bsd.port.mk>
