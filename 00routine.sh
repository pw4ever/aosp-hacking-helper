#!/bin/bash - 

pwd=$(pwd)

# AOSP specific setting
export JAVA_HOME=/opt/java6
export USE_CCACHE=1
mkdir -p ${pwd}/.ccache
export CCACHE_DIR=${pwd}/.ccache
#export ANDROID_PRODUCT_OUT=$(pwd)/out/target/product/generic/

source venv/bin/activate
source build/envsetup.sh

top=$(gettop)


# create directories
mkdir -p ${top}/99stuff/{kernel,sdcard}/
mkdir -p ${top}/99kernel/modules/

# building goldfish (emulator) kernel
# env setup for https://github.com/pw4ever/linux-kernel-hacking-helper
export ARENA=${top}/99arena/kernel/
mkdir -p ${ARENA}

## print out the whole procedure
cat - <<'END'

# the whole procedure; select the ones you need

# suppose we are at top-level AOSP directory now
bash
source 00routine.sh
lunch aosp_arm-eng

# obtain Android emulator kernel (goldfish)
cd $(gettop)/99kernel/
git clone https://android.googlesource.com/kernel/goldfish.git goldfish
cd $(gettop)/99kernel/goldfish/
git checkout -t -b goldfish-3.4 origin/android-goldfish-3.4
git checkout goldfish-3.4

# initialize "linux kernel hacking helper" directories ($ARENA has been set up by "source 00routine.sh")
hack_init.sh 10

# choose the arch you want to build

# build onto "linux kernel hacking helper" instance 1, on ARM arch, with 8 parallel jobs, and merging kernel configs for KGDB (kernel debugger) and LKM (loadable kernel module)
$(gettop)/01build-goldfish-kernel.sh 1 arm 8 ${HOME}/hacking/linux-kernel/helper/config/kgdb ${HOME}/hacking/linux-kernel/helper/config/lkm
$(gettop)/01build-goldfish-kernel.sh 2 x86_64 8 ${HOME}/hacking/linux-kernel/helper/config/kgdb ${HOME}/hacking/linux-kernel/helper/config/lkm
$(gettop)/01build-goldfish-kernel.sh 3 i686 8 ${HOME}/hacking/linux-kernel/helper/config/kgdb ${HOME}/hacking/linux-kernel/helper/config/lkm

# build kernel module
cd $(gettop)/99kernel/modules

# cd into the directory of the module, e.g., "hello"

# build onto "linux kernel hacking helper" instance 1, on ARM arch, with 8 parallel jobs
$(gettop)/01build-goldfish-module.sh 1 arm 8
END
