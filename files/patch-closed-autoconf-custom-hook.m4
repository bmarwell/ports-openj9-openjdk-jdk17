--- closed/autoconf/custom-hook.m4.orig
+++ closed/autoconf/custom-hook.m4
@@ -457,8 +457,11 @@ AC_DEFUN([OPENJ9_PLATFORM_SETUP],
     elif test "x$OPENJDK_BUILD_OS" = xmacosx ; then
       OPENJ9_PLATFORM_CODE=oa64
       OPENJ9_BUILD_OS=osx
+    elif test "x$OPENJDK_BUILD_OS" = xbsd ; then
+      OPENJ9_PLATFORM_CODE=ba64
+      OPENJ9_BUILD_OS=bsd
     else
       AC_MSG_ERROR([Unsupported OpenJ9 platform ${OPENJDK_BUILD_OS}!])
     fi

