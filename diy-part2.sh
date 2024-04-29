#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

FILE_PATH="feeds/kenzo/ddns-go/Makefile"

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File does not exist."
    exit 1
fi

sed -i '/PKG_BUILD_FLAGS:=no-mips16/a PKG_USE_MIPS16:=0' "$FILE_PATH"

# 修复 batman-dev 编译不通过问题
rm -f feeds/routing/batman-adv/src/compat-hacks.h
wget https://raw.githubusercontent.com/No06/routing/main/batman-adv/src/compat-hacks.h -O feeds/routing/batman-adv/src/compat-hacks.h
