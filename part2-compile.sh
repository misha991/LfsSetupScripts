source config.config
if test -f $LFS/LfsSetupScripts/pkg_pass/setup-pass; then
  echo "setup is not finished!."
  else
  echo "setup is not finished!."
  return 1
fi
pkg_dir=$LFS/LfsSetupScripts/PkgFiles
for entry in "$pkg_dir"/*
do
  source pkgCompile.sh "$entry-pkg" $entry
  if [ $? -eq 0 ]; then
    echo "succesed"
else
    echo "exitted with code $?" >> $LFS/LfsSetupScripts/log
    echo "error occured. see logs for more info"
    return 1
fi
  
done