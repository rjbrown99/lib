# DO NOT EDIT THIS FILE
#
# Please edit /boot/armbianEnv.txt to set supported parameters
#

# default values
setenv load_addr "0x44000000"
setenv rootdev "/dev/mmcblk0p1"
setenv verbosity "1"
setenv rootfstype "ext4"

if load mmc 0 ${load_addr} /boot/armbianEnv.txt || load mmc 0 ${load_addr} armbianEnv.txt; then
	env import -t ${load_addr} ${filesize}
fi

# No display driver yet
setenv consoleargs "console=ttyS0,115200"

setenv bootargs "root=${rootdev} rootwait rootfstype=${rootfstype} ${consoleargs} panic=10 consoleblank=0 enforcing=0 loglevel=${verbosity} ${extraargs} ${extraboardargs}"
load mmc 0 ${fdt_addr_r} /boot/dtb/allwinner/${fdtfile} || load mmc 0 ${fdt_addr_r} /dtb/allwinner/${fdtfile}
load mmc 0 ${ramdisk_addr_r} /boot/uInitrd || load mmc 0 ${ramdisk_addr_r} uInitrd
load mmc 0 ${kernel_addr_r} /boot/Image || load mmc 0 ${kernel_addr_r} Image
booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
