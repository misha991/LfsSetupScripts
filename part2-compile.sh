source config.config
if !test -f $LFS/LfsSetupScripts/pkg_pass/setup-pass; then
  echo "setup is not finished!."
  exit 0
fi
pkg_dir=$LFS/LfsSetupScripts/PkgFiles
for entry in "$pkg_dir"/*
do
  echo "$entry"
done