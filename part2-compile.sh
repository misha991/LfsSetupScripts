source config.config
cd $LFS/LfsScripts/pkg_toolchain/
source binutils-pkg
if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    exit
fi
cd $LFS/LfsScripts/pkg_toolchain/
source gcc-pkg
if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    exit
fi
cd $LFS/LfsScripts/pkg_toolchain/
source glibc-pkg