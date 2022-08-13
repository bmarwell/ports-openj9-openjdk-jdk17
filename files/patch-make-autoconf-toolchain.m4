--- make/autoconf/toolchain.m4.orig	2022-08-04 18:30:43 UTC
+++ make/autoconf/toolchain.m4
@@ -42,6 +42,7 @@ VALID_TOOLCHAINS_linux="gcc clang"
 VALID_TOOLCHAINS_macosx="gcc clang"
 VALID_TOOLCHAINS_aix="xlc"
 VALID_TOOLCHAINS_windows="microsoft"
+VALID_TOOLCHAINS_bsd="gcc clang"
 
 # Toolchain descriptions
 TOOLCHAIN_DESCRIPTION_clang="clang/LLVM"
