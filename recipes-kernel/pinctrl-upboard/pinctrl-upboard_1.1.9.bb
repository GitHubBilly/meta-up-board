SUMMARY = "UP boards pin controller modules"
DESCRIPTION = "${SUMMARY}"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

SRCREV = "d626a5eef494cefb7cc0517965ba2e332fe86b3f"
PV = "1.1.9+git${SRCPV}"
# Equivalent to git@github.com:up-division/pinctrl-upboard.git (bitbake ssh form).
# Upstream master does not yet include UPN-WCL01 HAT/PWM deltas; those remain
# tracked outside this recipe until a newer tagged release is available.
SRC_URI = "git://github.com/up-division/pinctrl-upboard.git;protocol=ssh;user=git;branch=master"

# NOTE: upstream commit ce2276b ("add kernel 6.17 compatibility for
# gpio_chip .set callback", included since v1.1.9) already fixes the
# gpio_chip.set void->int signature change natively via a
# LINUX_VERSION_CODE >= 6.17 conditional, so the local
# 0001-gpio-set-callback-returns-int.patch used for 1.1.8 is no longer
# needed and no longer applies cleanly.

S = "${UNPACKDIR}/${BP}/files"

inherit module

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES:${PN} += "kernel-module-upboard-fpga"
RPROVIDES:${PN} += "kernel-module-upboard-ec"
RPROVIDES:${PN} += "kernel-module-leds-upboard"
RPROVIDES:${PN} += "kernel-module-pinctrl-upboard"
RPROVIDES:${PN} += "kernel-module-pinctrl-upelement"
RPROVIDES:${PN} += "kernel-module-pwm-upboard"
