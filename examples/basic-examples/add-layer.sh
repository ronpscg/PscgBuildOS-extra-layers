#!/bin/bash
#
# Compatible with: the pscgbuildos Linux distros
#
# This layer is responsible for:
# - adding some examples to some of the demonstrated components


#
# This educational example can show you how to use a much slimmer module_prepare-ed "kernel build" to build out-of-tree modules that would suit your rootfs.
# You can then modprobe your built modules. The important thing is that you pack it properly.
# We are deliberately not using the kernel build folder, but rather preparing the module, and you can do it without building the kernel at all
#
educational_demonstration_modprepare() {

	# To illustrate the concepts, we will remove previous remainders, if they exist
	verbose_do_or_die rm -rf $kernel__modules_prepare_workdir

	# Prepare the kernel module for building
	debug_do_or_die kernel__do_modules_prepare_and_pack_workdir

	# While at it, you can also create the kernel headers, but it is quite pointless for this distro builder. comment out the next line if you wish to do so
	# debug_do_or_die kernel__do_headers_install_and_pack_workdir
}


educational_demonstration_oot_modules_hello() {
	local examplemodule=$LOCAL_DIR/hello-module
	local builddir
	local moreopts=""
	if [ "$config_examples__common_build_modules_against" = "build" ] ; then
		builddir=$LINUX_BUILD_DIR
	elif [ "$config_examples__common_build_modules_against" = "modules_prepare" ] ; then
		builddir=$kernel__modules_prepare_workdir
		moreopts="KBUILD_MODPOST_WARN=1"
	else
		fatalError "Please either use build or modules_prepare"
	fi

	# You absolutely must build the module before running a module install
	verbose_do_or_die make $moreopts -C $LINUX_SOURCE_DIR O=$builddir INSTALL_MOD_PATH=$kernel__modules_install_workdir M=$examplemodule
	# And then you can module install
	verbose_do_or_die make  -C $LINUX_SOURCE_DIR O=$builddir INSTALL_MOD_PATH=$kernel__modules_install_workdir M=$examplemodule modules_install

	debug "Done building your educational example!"
}


main() {
	if [ "$config_kernel__edu_do_modules_prepare" = "true" ] ; then
		educational_demonstration_modprepare
	fi
	if [ "$config_examples__common_linux_add_hello_module" = "true" ] ; then
		educational_demonstration_oot_modules_hello
	fi
}


commonScriptPrologueLogRunAndEpilogue $@