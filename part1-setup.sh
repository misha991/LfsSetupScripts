if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

./config.config
export LFS=$LFS_DIR
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget https://www.linuxfromscratch.org/lfs/downloads/stable/wget-list-sysv
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
wget https://www.linuxfromscratch.org/lfs/downloads/stable/md5sums
pushd $LFS/sources
 md5sum -c md5sums
popd
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo lfs | passwd lfs --stdin
passwd -d lfs
su lfs
cd ~/
echo "LFS=$LFS_DIR" >>  ~/.bashrc
echo "LC_ALL=POSIX" >>  ~/.bashrc
echo "LFS_TGT=$(uname -m)-lfs-linux-gnu" >>  ~/.bashrc
echo "PATH=/usr/bin" >>  ~/.bashrc
echo "if [ ! -L /bin ]; then PATH=/bin:$PATH; fi" >>  ~/.bashrc
echo "PATH=$LFS/tools/bin:$PATH" >>  ~/.bashrc
echo "CONFIG_SITE=$LFS/usr/share/config.site" >>  ~/.bashrc
echo "export LFS LC_ALL LFS_TGT PATH CONFIG_SITE" >>  ~/.bashrc
echo "Finished!"
