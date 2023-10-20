SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source config.config
if test -f $LFS/LfsSetupScripts/pkg_pass/setup-pass; then
  echo "."
  else
  echo "setup is not finished!."
  return 1
fi
pkg_dir=$LFS/LfsSetupScripts/PkgFiles
for entry in "$pkg_dir"/*
do
  FileName = $(basename $entry .sh)
  echo $FileName
  echo $entry
  source pkgCompile.sh $FileName "$FileName-pass"
  if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "exitted with code $?" >> $LFS/LfsSetupScripts/log
    echo "error occured. see logs for more info"
fi
  
done
cd $SCRIPT_DIR