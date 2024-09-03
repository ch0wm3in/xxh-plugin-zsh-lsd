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
if [ -x "$(command -v wget)" ]; then
  lsd_release=$(wget -S -O- --max-redirect=0 --save-header https://github.com/Peltoche/lsd/releases/latest 2>&1 | grep -e "Location: " | cut -d " " -f 4 | cut -d "/" -f 8)
  lsd_url="https://github.com/lsd-rs/lsd/releases/download/$lsd_release/lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz"
  bat_release=$(wget -S -O- --max-redirect=0 --save-header https://github.com/sharkdp/bat/releases/latest 2>&1 | grep -e "Location: " | cut -d " " -f 4 | cut -d "/" -f 8)
  bat_url="https://github.com/sharkdp/bat/releases/download/$bat_release/bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz"
  
  wget $lsd_url
  wget $bat_url
  
  tar xf  lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz lsd-$lsd_release-x86_64-unknown-linux-gnu/lsd --strip-components=1
  tar xf  bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz bat-$bat_release-x86_64-unknown-linux-gnu/bat --strip-components=1
  rm lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz
  rm bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz
elif [ -x "$(command -v curl)" ]; then
  lsd_release=$(curl -s https://github.com/Peltoche/lsd/releases/latest -D- | grep "location: " | cut -d "/" -f 8 | tr -d "\r")
  bat_release=$(curl -s https://github.com/sharkdp/bat/releases/latest -D- | grep "location: " | cut -d "/" -f 8 | tr -d "\r")
  lsd_url="https://github.com/lsd-rs/lsd/releases/download/$lsd_release/lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz"
  bat_url="https://github.com/sharkdp/bat/releases/download/$bat_release/bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz"
  
  curl $lsd_url -OJL
  curl $bat_url -OJL
  
  tar xf  lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz lsd-$lsd_release-x86_64-unknown-linux-gnu/lsd --strip-components=1
  tar xf  bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz bat-$bat_release-x86_64-unknown-linux-gnu/bat --strip-components=1
  rm lsd-$lsd_release-x86_64-unknown-linux-gnu.tar.gz
  rm bat-$bat_release-x86_64-unknown-linux-gnu.tar.gz
else
  echo Install wget or curl
fi
#
#tar -xzf $tarname
#rm $tarname
