export TOP=`pwd`
. build/envsetup.sh 
setpaths
lunch foster_e-userdebug # (use "lunch foster_e_hdd-userdebug" if you got the shield tv pro)
mp bootimage -j6 # (change j9 to j<number-of-cpu-cores+1> for optimal build speed)
cp out/target/product/t210/boot.img boot.img
export TOP=
