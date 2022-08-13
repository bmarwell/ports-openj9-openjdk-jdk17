--- closed/autoconf/custom-hook.m4.orig	2022-08-04 18:30:43 UTC
+++ closed/autoconf/custom-hook.m4
@@ -316,7 +316,7 @@ AC_DEFUN([OPENJ9_PLATFORM_EXTRACT_VARS_FROM_CPU],
 [
   # Convert openjdk cpu names to openj9 names
   case "$1" in
-    x86_64)
+    x86_64|amd64)
       OPENJ9_CPU=x86-64
       ;;
     powerpc64le)
@@ -457,6 +457,9 @@ AC_DEFUN([OPENJ9_PLATFORM_SETUP],
     elif test "x$OPENJDK_BUILD_OS" = xmacosx ; then
       OPENJ9_PLATFORM_CODE=oa64
       OPENJ9_BUILD_OS=osx
+    elif test "x$OPENJDK_BUILD_OS" = xbsd ; then
+      OPENJ9_PLATFORM_CODE=ba64
+      OPENJ9_BUILD_OS=bsd
     else
       AC_MSG_ERROR([Unsupported OpenJ9 platform ${OPENJDK_BUILD_OS}!])
     fi
