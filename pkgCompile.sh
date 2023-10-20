echo "" > $LFS/LfsSetupScripts/log
if test -f $LFS/LfsSetupScripts/pkg_pass/$1; then
  echo "$1 is installed." >> $LFS/LfsSetupScripts/log
echo "$1 is installed."
  exit 0
fi
source $LFS/LfsSetupScripts/PkgFiles/$2
echo "setting up $name" >> $LFS/LfsSetupScripts/log
echo "setting up $name"
cd $LFS/sources
tar -xf $file
if [ $? -eq 0 ]; then
    echo "extracted $file" >> $LFS/LfsSetupScripts/log
    echo "extracted $file"
else
    echo "failed to extract $file" >> $LFS/LfsSetupScripts/log
    echo "failed to extract $file"
    return 1
fi
cd ${file#".tar.xz"}
mkdir -v build
cd build
preInstall
echo "configuring $name"
echo "configuring $name" >> $LFS/LfsSetupScripts/log
configure
if [ $? -eq 0 ]; then
    echo "Configuration success $name"  >> $LFS/LfsSetupScripts/log
    echo "Configuration success $name"
else
    echo "failed"
    return 1
fi
make $MAKE_FLAGS
 if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    return 1
fi
make install
 if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "failed"
    return 1
fi
touch $LFS/pkg_pass/binutils-pass1