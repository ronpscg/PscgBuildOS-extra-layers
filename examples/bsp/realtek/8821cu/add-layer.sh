#!/bin/bash
#
# Compatible with: pscg_alpineos
# Should be compatible with: anything else if you set the userspace packages for it 
#
# This layer is responsible for:
# - Populating wifi and bluetooth relavant userspace packages in distros that support packaging
#

#
# Note: This is an example. The purpose is to show something for a specific distro not to do everything. Perhaps you will see this with more features and distros, perhaps you won't
#

add_rootfs_packages_pscg_alpineos() {
	echo $ROOTFS_DIR
	sudo chroot $ROOTFS_DIR apk add iw wpa_supplicant bluez bluez-deprecated openrc-init	
}

main() {
	# It is just an example. Ideally each distro will take care of features...
	verbose_do_or_die "add_rootfs_packages_${config_distro}"
}



commonScriptPrologueLogRunAndEpilogue $@
