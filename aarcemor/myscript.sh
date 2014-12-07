#!/bin/sh

set -x

LOCATION=$1
VERSION=$2
FILETYPE=$3

# Variables kernel.org

WGET=wget
KERNELORG_PATH="https://www.kernel.org/pub/linux/kernel/v3.x/"
KERNELORG_FILE="linux-"
KERNELORG_VERSION=$VERSION
KERNELORG_FILETYPE=".tar."$FILETYPE
KERNELORG_OURFILE="$KERNELORG_FILE$KERNELORG_VERSION$KERNELORG_FILETYPE"

# Variables directory structure
DIRECTORY_ROOT=`pwd`
DIRECTORY_KERNELORG=$DIRECTORY_ROOT/kernelorg
DIRECTORY_OFFICIAL=$DIRECTORY_ROOT/official
DIRECTORY_TEMPORAL=$DIRECTORY_ROOT/temporal

# Variables official structure
OFFICIAL_KERNELNAME="$KERNELORG_FILE$KERNELORG_VERSION"
OFFICIAL_KERNELDIRECTORY="$DIRECTORY_OFFICIAL/$OFFICIAL_KERNELNAME"

download() {
  cd $DIRECTORY_KERNELORG
  echo "$KERNELORG_PATH$KERNELORG_FILE$KERNELORG_VERSION$KERNELORG_FILETYPE"
  wget $KERNELORG_PATH$KERNELORG_FILE$KERNELORG_VERSION$KERNELORG_FILETYPE
  cd $DIRECTORY_ROOT
}

directory_create() {
  test -d $DIRECTORY_KERNELORG || mkdir $DIRECTORY_KERNELORG
  test -d $DIRECTORY_OFFICIAL || mkdir $DIRECTORY_OFFICIAL
  test -d $DIRECTORY_TEMPORAL || mkdir $DIRECTORY_TEMPORAL
}

directory_cleanup() {
  echo
}

uncompress() {
  cd $DIRECTORY_KERNELORG
  tar xf $KERNELORG_OURFILE
  cd $DIRECTORY_ROOT 
}

official_setup() {
  cp -r $DIRECTORY_KERNELORG/$OFFICIAL_KERNELNAME $OFFICIAL_KERNELDIRECTORY
}

download
directory_create
uncompress
official_setup
directory_cleanup

# End of file
