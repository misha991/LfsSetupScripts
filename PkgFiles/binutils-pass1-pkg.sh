_export{
export file = binutils-2.41.tar.xz
export name = binutils-2.41
}
preInstall{}
configure{
../configure --prefix=$LFS/tools \
 --with-sysroot=$LFS \
 --target=$LFS_TGT \
 --disable-nls \
 --enable-gprofng=no \
 --disable-werror
}
postInstall{}