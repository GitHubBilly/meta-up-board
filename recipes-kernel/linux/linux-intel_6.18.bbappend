FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PR := "${PR}.3"

SRC_URI += " \
       file://up-board.cfg \
       file://up-board-user-config.cfg \
       file://audio.cfg \
       file://ethernet.cfg \
       file://intel-dev.cfg \
       file://intel-dev.scc \
       file://usb.cfg \
       file://ipu.cfg \
       file://wireless.cfg \
       file://up-board-pinctrl.cfg \
       file://ufs.cfg \
"

# replace these SRCREVs with the real commit ids once you've had
# the appropriate changes committed to the upstream linux-yocto repo
# SRCREV_machine_pn-linux-yocto_up-board ?= "${AUTOREV}"
# SRCREV_meta_pn-linux-yocto_up-board ?= "${AUTOREV}"

# OE-core's do_shared_workdir only copies tools/objtool into the shared
# kernel build dir when CONFIG_UNWINDER_ORC=y. On this kernel version,
# CONFIG_OBJTOOL=y alone makes objtool mandatory for compiling any object
# file (in-tree or out-of-tree module), independent of the ORC unwinder.
# Without this, out-of-tree module builds (e.g. pinctrl-upboard) fail with
# "objtool: No such file or directory".
do_shared_workdir:append () {
	kerneldir=${STAGING_KERNEL_BUILDDIR}
	if [ ! -x $kerneldir/tools/objtool/objtool ] && [ -x tools/objtool/objtool ]; then
		if (grep -q -i -e '^CONFIG_OBJTOOL=y$' $kerneldir/.config); then
			mkdir -p $kerneldir/tools/objtool
			cp tools/objtool/objtool $kerneldir/tools/objtool/
		fi
	fi
}

# UP Nexus WCL: Xe3 display + disable SoundWire SOF (link modpost failures).
SRC_URI:append:up-nexus-wcl = " \
    file://xe3.cfg \
    file://wcl-soundwire-off.cfg \
"

# UP Xtreme ARL: Arc graphics via DRM_XE (verified on live UPX-ARL01).
SRC_URI:append:up-xtreme-arl = " \
    file://arl-xe.cfg \
"
SRC_URI:append:up-xtreme-arl-rt = " \
    file://arl-xe.cfg \
"

# UP Xtreme PTL: Xe3 / DRM_XE display (verified on live UPX-PTL01-SYS).
SRC_URI:append:up-xtreme-ptl = " \
    file://ptl-xe.cfg \
"
SRC_URI:append:up-xtreme-ptl-rt = " \
    file://ptl-xe.cfg \
"
