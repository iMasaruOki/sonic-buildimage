# linux kernel package

KVERSION_SHORT = 4.19.0-0.bpo.6
KVERSION = $(KVERSION_SHORT)-$(CONFIGURED_ARCH)
KERNEL_VERSION = 4.9.189
KERNEL_SUBVERSION = 3+deb9u2
ifeq ($(CONFIGURED_ARCH), armhf)
# Override kernel version for ARMHF as it uses arm MP (multi-platform) for short version
KVERSION = $(KVERSION_SHORT)-armmp
endif

export KVERSION_SHORT KVERSION KERNEL_VERSION KERNEL_SUBVERSION

LINUX_HEADERS_COMMON = linux-headers-$(KVERSION_SHORT)-common_$(KERNEL_VERSION)-$(KERNEL_SUBVERSION)_all.deb
$(LINUX_HEADERS_COMMON)_SRC_PATH = $(SRC_PATH)/sonic-linux-kernel
SONIC_MAKE_DEBS += $(LINUX_HEADERS_COMMON)

LINUX_HEADERS = linux-headers-$(KVERSION)_$(KERNEL_VERSION)-$(KERNEL_SUBVERSION)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(LINUX_HEADERS_COMMON),$(LINUX_HEADERS)))

LINUX_KERNEL = linux-image-$(KVERSION)_$(KERNEL_VERSION)-$(KERNEL_SUBVERSION)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(LINUX_HEADERS_COMMON),$(LINUX_KERNEL)))
