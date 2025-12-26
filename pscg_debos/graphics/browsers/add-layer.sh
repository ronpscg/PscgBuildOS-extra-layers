#!/bin/bash
#
# Compatible with: the debos training distro (do not confuse with the debos package, we became aware of years after this template O_o)
#
# This layer is responsible for:
# - Installing selected browser packages

LOCAL_APT_FLAGS="--no-install-recommends"

sanity_check() {
	if [ "$ENABLE_BROWSERS" = "true" ] ; then
		if [ ! "$ENABLE_GRAPHICS" = "true" ] ; then
			# It's not an error - but I want the user to read it very well. If they meant to do so and they know what they are doing, it is fine.
			error "You enabled browsers, but not graphics. Are you sure you want to do that?"
			warn "Do understand that there will be so many dependencies that the image would be huge as well, and you'd probably prefer to add graphics even if you plan to do everything headless"
			fatalError "Quitting anyway. We don't want you to install a Browser without setting up graphics properly"
		fi
	fi
}

main() {
	sanity_check
	source_file_or_die $LOCAL_DIR/packages.deb.buildconfig # the package config is sourced but there will not be duplication of packages (from the other sourcing for cache building) so that is fine
	sudo chroot $ROOTFS_DIR bash -c "DEBIAN_FRONTEND=noninteractive ;  apt-get install -y $LOCAL_APT_FLAGS $pscg_debos_graphics_browser_packages " || fatalError "Failed to run main logic"
}


commonScriptPrologueLogRunAndEpilogue $@
