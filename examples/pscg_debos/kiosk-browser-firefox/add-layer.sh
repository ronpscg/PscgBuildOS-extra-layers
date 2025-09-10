#!/bin/bash
#
# Compatible with: the debos training distro (do not confuse with the debos package, we became aware of years after this template O_o)
# Should be compatible with: anything that uses weston and has systemd
# Could be compatible with/ported to: anything that uses weston, regardless of systemd
#
# This layer is responsible for:
# - Adding a firefox kiosk browser
#
# As this is an example, we don't bother to check if the browser is installed, and so
# we even avoid the buildconfig file or installations. What we do, instead is demonstrate how
# a single systemd unit file replacement can do wonders.
#

do_launch_weston_at_graphical_target_startup_systemd() {
	sudo cp -v $LOCAL_DIR/targetfiles/etc/systemd/system/weston.service $ROOTFS_DIR/etc/systemd/system/weston.service || fatalError "Failed to copy weston.service to the rootfs"
	sudo chroot $ROOTFS_DIR bash -c "systemctl enable weston.service" || fatalError "Failed to enable weston.service"
}

main() {
	do_launch_weston_at_graphical_target_startup_systemd
}


commonScriptPrologueLogRunAndEpilogue $@
