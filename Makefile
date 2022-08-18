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
USE_GITHUB=	nodefault
GH_TUPLE=	ibmruntimes:openj9-openjdk-jdk17:openj9-${DISTVERSIONFULL}:ibmruntime \
		eclipse-openj9:openj9:openj9-${DISTVERSIONFULL}:openj9/../openj9-openjdk-jdk17-openj9-${DISTVERSIONFULL}/openj9 \
		eclipse-openj9:openj9-omr:openj9-${DISTVERSIONFULL}:openj9omr/../openj9-openjdk-jdk17-openj9-${DISTVERSIONFULL}/omr
WRKSRC=		${WRKDIR}/${PORTNAME}-${DISTNAME}
       
MAINTAINER=	bmarwell@apache.org
COMMENT=	Java Development Kit based on OpenJDK with Eclipse OpenJ9

LICENSE=	GPLv2
#LICENSE_FILE=	${WRKSRC}/LICENSE
       
USES=		ssl shebangfix localbase gmake xorg iconv jpeg pkgconfig
BUILD_DEPENDS=	${LOCALBASE}/include/cups/cups.h:print/cups \
		bash:shells/bash \
		gsed:textproc/gsed \
		autoconf>0:devel/autoconf \
		cmake>0:devel/cmake \
		nasm>0:devel/nasm \
		zip>0:archivers/zip \
		harfbuzz>0:print/harfbuzz
LIB_DEPENDS=	libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libgif.so:graphics/giflib \
                liblcms2.so:graphics/lcms2 \
                libpng.so:graphics/png
SHEBANG_FILES=	configure

DISABLE_MAKE_JOBS=	yes

GNU_CONFIGURE=	yes
CONFIGURE_ENV=  CC="${CC}" \
                CXX="${CXX}" \
                CPP="${CPP}" \
                ac_cv_path_SED=${LOCALBASE}/bin/gsed
CONFIGURE_ARGS=	--with-boot-jdk=${BOOTSTRAPJDKDIR} \
		--with-toolchain-type=clang \
		--enable-jitserver=no \
		--with-extra-cflags="${CFLAGS}" \
		--with-extra-cxxflags="${CXXFLAGS}" \
		--with-freetype=system \
		--with-freetype-include=${LOCALBASE}/include/freetype2 \
		--with-freetype-lib=${LOCALBASE}/lib \
		--with-fontconfig=${LOCALBASE} \
		--with-libjpeg=system \
		--with-giflib=system \
		--with-harfbuzz=system \
		--with-libpng=system \
		--with-zlib=system \
		--with-lcms=system \
		--with-cmake \
		--x-includes=${LOCALBASE}/include \
                --x-libraries=${LOCALBASE}/lib \
		--with-openj9-cc="${CC}" \
		--with-openj9-cxx="${CXX}"

.if defined(WITH_CCACHE_BUILD) && !defined(NO_CCACHE)
# configure wants to enable ccache itself, so don't add ccache to PATH
CCACHE_WRAPPER_PATH=	/nonexistent
CONFIGURE_ARGS+=	--enable-ccache
BUILD_DEPENDS+=		${LOCALBASE}/bin/ccache:devel/ccache
.else
CONFIGURE_ARGS+=	--disable-ccache
.endif

# to get ${LOCALBASE}
.include <bsd.port.pre.mk>

BOOTSTRAP_JDKS=	${LOCALBASE}/openjdk17 ${LOCALBASE}/bootstrap-openjdk17

# do we have valid native jdk installed?
.for BJDK in ${BOOTSTRAP_JDKS}
.  if !defined(BOOTSTRAPJDKDIR) && exists(${BJDK}/bin/javac)
BOOTSTRAPJDKDIR=	${BJDK}
.  endif
.endfor

# if no valid jdk found, set dependency
.if !defined(BOOTSTRAPJDKDIR)
BOOTSTRAPJDKDIR?=	${LOCALBASE}/bootstrap-openjdk17
BUILD_DEPENDS+=		${BOOTSTRAPJDKDIR}/bin/javac:java/bootstrap-openjdk17
.endif

USE_AUTOCONF=   yes
USE_IMAKE=	yes
USE_XORG=	x11 xext xi xrandr xrender xt xtst
NO_CCACHE=      yes

pre-configure:
	 ${CHMOD} +x ${WRKSRC}/configure

.include <bsd.port.post.mk>
