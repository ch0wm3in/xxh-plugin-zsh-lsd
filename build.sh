#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir
mkdir $build_dir/bin

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done





#portable_url='https://,,,/.tar.gz'
#tarname=`basename $portable_url`
#
cd $build_dir/bin
#
#[ $QUIET ] && arg_q='-q' || arg_q=''
#[ $QUIET ] && arg_s='-s' || arg_s=''
#[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'
lsd_release$(curl -s https://github.com/Peltoche/lsd/releases/latest | cut -d "\"" -f 2 | cut -d "/" -f 8)
lsd_url="https://github.com/Peltoche/lsd/releases/download/$lsd_release/lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz"
if [ -x "$(command -v wget)" ]; then
  wget $lsd_url
  tar xf  lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz lsd-$lsd_release-x86_64-unknown-linux-gnu/lsd --strip-components=1
fi
#elif [ -x "$(command -v curl)" ]; then
#  curl $arg_s -L $portable_url -o $tarname
#else
#  echo Install wget or curl
#fi
#
#tar -xzf $tarname
#rm $tarname
