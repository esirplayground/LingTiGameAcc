#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=LingTiGameAcc
PKG_VERSION:=20201108
PKG_RELEASE:=5

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=eSir Playground

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=Network
  TITLE:=LingTi Game Accelerator
  URL:=https://github.com/esirplayground/LingTiGameAcc	
  DEPENDS:=+kmod-tun
  PKGARCH:=all
endef

#DIR_ARCH:=$(ARCH)

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)/$(PKG_NAME)
	cp -r ./files/* $(PKG_BUILD_DIR)/$(PKG_NAME)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/tmp/lingti
	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME)/* $(1)/tmp/lingti


endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
mkdir -p ./usr/bin/lingti
chmod +x ./tmp/lingti/lingti.sh
sh ./tmp/lingti/lingti.sh
rm -rf ./tmp/lingti
chmod +x ./usr/bin/lingti/*
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
