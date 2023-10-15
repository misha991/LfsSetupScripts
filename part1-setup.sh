SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if test -f $LFS/LfsScripts/pkg-pass/setup-pass; then
  echo "Setup completed."
  exit
fi
source ./config.config
export LFS=$LFS_DIR
file = $LFS/*
if ! [[ "$file" == /* ]] ; then
    path=.
fi
dirname "$file" | tr '/' $'\n' | while read part ; do
    path="$path/$part"
    # Check for execute permissions
    if ! [[ -x "$path" ]] ; then
        echo "'$path' is blocking access."
        exit
    fi
done
if ! [[ -r "$file" ]] ; then
    echo "'$file' is not readable."
    exit
fi


mkdir -v $LFS/sources
chmod -v +rwx $LFS/sources
wget https://www.linuxfromscratch.org/lfs/downloads/stable/wget-list-sysv
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
cd $LFS/sources
wget https://www.linuxfromscratch.org/lfs/downloads/stable/md5sums
pushd $LFS/sources
 md5sum -c md5sums
popd
touch wget-pass
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
 ln -sv usr/$i $LFS/$i
done
case $(uname -m) in
 x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools
echo "LFS=$LFS_DIR" >>  ~/.bashrc
echo "LC_ALL=POSIX" >>  ~/.bashrc
echo "LFS_TGT=$(uname -m)-lfs-linux-gnu" >>  ~/.bashrc
echo "PATH=/usr/bin" >>  ~/.bashrc
echo "if [ ! -L /bin ]; then PATH=/bin:$PATH; fi" >>  ~/.bashrc
echo "PATH=$LFS/tools/bin:$PATH" >>  ~/.bashrc
echo "CONFIG_SITE=$LFS/usr/share/config.site" >>  ~/.bashrc
echo "export LFS LC_ALL LFS_TGT PATH CONFIG_SITE" >>  ~/.bashrc
source ~/.bash_profile
mkdir $LFS/LfsScripts
mkdir $LFS/LfsScripts/pkg_pass
mkdir $LFS/LfsScripts/pkg_toolchain
touch $LFS/LfsScripts/pkg_pass/setup-pass
cd $SCRIPT_DIR
mv PkgFiles/* $LFS/LfsScripts/pkg_toolchain
mv ./* $LFS/LfsScripts
rm -r $SCRIPT_DIR
echo "Finished!"