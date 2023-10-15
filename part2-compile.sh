su lfs
./config.config
cd $0/PkgFiles
source binutils-pkg
if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    exit 1
fi
source gcc-pkg
if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    exit 1
fi