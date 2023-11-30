################################################################################
#
# milkv-duo-libraries
#
################################################################################

MILKV_DUO_LIBRARIES_VERSION = f359994bd497f942bb67734280d81f6640c7c168
MILKV_DUO_LIBRARIES_SITE = $(call github,milkv-duo,milkv-duo-buildroot-libraries,$(MILKV_DUO_LIBRARIES_VERSION))
MILKV_DUO_LIBRARIES_INSTALL_STAGING = YES
MILKV_DUO_LIBRARIES_DEPENDENCIES = host-python3 host-mtools
MILKV_DUO_FIRMWARE_FSBL_64MB = ION

ifeq ($(BR2_PACKAGE_MILKV_DUO_FIRMWARE_FSBL_64MB),y)
	MILKV_DUO_FIRMWARE_FSBL_64MB = 64MB
endif

define MILKV_DUO_LIBRARIES_BUILD_CMDS
	if [ $(BR2_PACKAGE_MILKV_DUO_FIRMWARE_FSBL) = y ]; then \
		$(MAKE) -C $(@D)/firmware \
		ARCH=riscv BOOT_CPU=riscv CHIP_ARCH=cv180x \
		PROJECT_FULLNAME=cv1800b_milkv_duo_sd \
		CROSS_COMPILE=$(TARGET_CROSS) \
		FREE_RAM_SIZE=$(MILKV_DUO_FIRMWARE_FSBL_64MB) \
		bl2; \
	fi

	if [ $(BR2_PACKAGE_MILKV_DUO_PINMUX) = y ]; then \
		$(TARGET_MAKE_ENV) $(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-I $(@D)/pinmux/include $(@D)/pinmux/src/*.c -o $(@D)/pinmux/duo-pinmux; \
	fi
endef

define MILKV_DUO_LIBRARIES_INSTALL_STAGING_CMDS
	if [ $(BR2_PACKAGE_MILKV_DUO_FIRMWARE_FSBL) = y ]; then \
		$(INSTALL) -D -m 0755 $(@D)/firmware/build/cv180x/bl2.bin $(BINARIES_DIR)/bl2.bin; \
		$(INSTALL) -D -m 0755 $(@D)/firmware/plat/cv180x/chip_conf.bin $(BINARIES_DIR)/chip_conf.bin; \
		$(INSTALL) -D -m 0755 $(@D)/firmware/plat/cv180x/fiptool.py $(BINARIES_DIR)/fiptool.py; \
		$(INSTALL) -D -m 0644 $(@D)/firmware/plat/cv180x/multi.its $(BINARIES_DIR)/multi.its; \
		$(INSTALL) -D -m 0755 $(@D)/firmware/test/cv181x/ddr_param.bin $(BINARIES_DIR)/ddr_param.bin; \
	fi

	if [ $(BR2_PACKAGE_MILKV_DUO_PINMUX) = y ]; then \
		$(INSTALL) -D -m 0755 $(@D)/pinmux/duo-pinmux $(TARGET_DIR)/usr/bin/; \
	fi

	if [ $(BR2_PACKAGE_MILKV_DUO_FEATURES) = y ]; then \
		cp $(@D)/overlay/* -r $(TARGET_DIR); \
	fi
endef

$(eval $(generic-package))
