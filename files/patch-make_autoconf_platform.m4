--- make/autoconf/platform.m4.orig	2022-08-13 19:35:27 UTC
+++ make/autoconf/platform.m4
@@ -36,7 +36,7 @@ AC_DEFUN([PLATFORM_EXTRACT_VARS_FROM_CPU],
       VAR_CPU_BITS=32
       VAR_CPU_ENDIAN=little
       ;;
-    x86_64)
+    amd64|x86_64)
       VAR_CPU=x86_64
       VAR_CPU_ARCH=x86
       VAR_CPU_BITS=64
