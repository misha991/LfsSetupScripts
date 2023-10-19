SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if test -f $LFS/LfsScripts/pkg-pass/setup-pass; then
  echo "Setup completed."
  return 0
fi
source ./config.config
export LFS=$LFS_DIR
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
mkdir $LFS/LfsSetupScripts/pkg_pass
touch $LFS/LfsSetupScripts/pkg_pass/setup-pass
cd $SCRIPT_DIR
echo "Finished!"