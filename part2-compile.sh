source config.config
if test -f $LFS/LfsSetupScripts/pkg_pass/setup-pass; then
  echo "setup is not finished!."
  return 0
  else
  echo "setup is not finished!."
  return 0
fi
pkg_dir=$LFS/LfsSetupScripts/PkgFiles
for entry in "$pkg_dir"/*
do
  echo " setting up $entry"
  source $entry 
  if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "exitted with code $?" >> $LFS/LfsSetupScripts/log
    echo "error occured. see logs for more info"
    return 1
fi
  
done