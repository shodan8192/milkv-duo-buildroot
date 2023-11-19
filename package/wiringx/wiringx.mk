################################################################################
#
# wiringX
#
################################################################################

WIRINGX_VERSION = 54030cd9b68ef895439e1444f418524e16cbb4c1
WIRINGX_SITE = $(call github,wiringX,wiringX,$(WIRINGX_VERSION))
WIRINGX_LICENSE = MPL-2.0
WIRINGX_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
