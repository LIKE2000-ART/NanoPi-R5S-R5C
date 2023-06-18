#!/bin/bash
#=================================================
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Clone community packages to package/community

# Add application
mkdir package/community
pushd package/community

# mt7921 mt7916
rm -rf package/kernel/mac80211/Makefile
cp -f $GITHUB_WORKSPACE/Makefile package/kernel/mac80211/Makefile

# Lienol's Packages
svn export https://github.com/Lienol/openwrt-package/trunk Lienol-Packages
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf Lienol-Packages/verysync
rm -rf Lienol-Packages/luci-app-verysync

# luci-app-ssr-plus
svn export https://github.com/fw876/helloworld/trunk helloworld

# Passwall和Passwall2
svn export https://github.com/xiaorouji/openwrt-passwall/trunk openwrt-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall
svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2

# VSSR（Hello Word）
svn export https://github.com/jerrykuku/lua-maxminddb/trunk lua-maxminddb
svn export https://github.com/jerrykuku/luci-app-vssr/trunk luci-app-vssr

# OpenClash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
svn export https://github.com/Siriling/OpenWRT-MyConfig/trunk/configs/general/applications/luci-app-openclash temp/luci-app-openclash
cp -rf temp/luci-app-openclash/* luci-app-openclash

# Unblockneteasemusic
rm -rf ../../customfeeds/luci/applications/luci-app-unblockmusic
svn export https://github.com/kenzok8/openwrt-packages/trunk/UnblockNeteaseMusic
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-unblockneteasemusic

# ADGuardHome
rm -rf ../../customfeeds/packages/utils/adguardhome
rm -rf ../../customfeeds/luci/applications/luci-app-adguardhome
svn export https://github.com/kenzok8/openwrt-packages/trunk/adguardhome
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome
svn export https://github.com/Siriling/OpenWRT-MyConfig/trunk/configs/general/applications/luci-app-adguardhome temp/luci-app-adguardhome
cp -rf temp/luci-app-adguardhome/* luci-app-adguardhome

# Poweroff
svn export https://github.com/esirplayground/luci-app-poweroff/trunk luci-app-poweroff

# luci-app-services-wolplus
svn export https://github.com/msylgj/OpenWrt_luci-app/trunk/luci-app-services-wolplus

# luci-app-services-wolplus
svn export https://github.com/msylgj/OpenWrt_luci-app/trunk/luci-app-services-wolplus

# Minieap
svn export https://github.com/ysc3839/luci-proto-minieap/trunk luci-proto-minieap

# Onliner (need luci-app-nlbwmon)
svn export https://github.com/rufengsuixing/luci-app-onliner/trunk luci-app-onliner

# OpenAppFilter
svn export https://github.com/destan19/OpenAppFilter/trunk OpenAppFilter

# DDNSto & Linkease
svn export https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto
svn export https://github.com/linkease/nas-packages/trunk/network/services/ddnsto

# Subconverter
svn export https://github.com/tindy2013/openwrt-subconverter/trunk openwrt-subconverter

# Apk (Apk Packages Manager)
svn export https://github.com/openwrt/packages/trunk/utils/apk

# Theme
rm -rf customfeeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
svn export https://github.com/jerrykuku/luci-app-argon-config/trunk luci-app-argon-config
cp -f $GITHUB_WORKSPACE/images/bg1.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg # 修改默认背景
git clone https://github.com/DHDAXCW/theme

popd

# Add Pandownload
pushd package/lean
svn export https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server
popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# MT7921、MT7916网卡驱动
rm -rf package/kernel/mac80211/Makefile
cp -f $GITHUB_WORKSPACE/Makefile package/kernel/mac80211/Makefile

# 修复移远PCIe驱动(quectel_MHI)
rm -rf package/wwan/driver/quectel_MHI
svn export https://github.com/Siriling/5G-Modem-Support/trunk/quectel_MHI package/wwan/driver/quectel_MHI

# 添加5G模组拨号脚本
mkdir -p package/base-files/files/root/5GModem
cp -rf $GITHUB_WORKSPACE/tools/5G模组拨号脚本/5GModem/* package/base-files/files/root/5GModem
chmod -R a+x package/base-files/files/root/5GModem
svn export https://github.com/Siriling/OpenWRT-MyConfig/trunk/configs/general/etc/crontabs package/base-files/files/etc/crontabs

# 修改默认IP地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名字
sed -i 's/OpenWrt/R5S/g' package/base-files/files/bin/config_generate

# 修改版本号
# sed -i 's/R22.3.3/R22.3.3定制版/g' package/lean/default-settings/files/zzz-default-settings
# sed -i 's/OpenWrt/R5S/g' package/lean/default-settings/files/zzz-default-settings

# 系统信息内添加编译者信息
sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a\<tr><td width="33%"><%:Compiler author%><\/td><td>Siriling<\/td><\/tr><tr><td width="33%"><%:Resources link%><\/td><td><a target="_blank" style="padding-right: 20px;" href="https://github.com/Siriling/NanoPi-R5S-R5C">固件仓库<\/a><a target="_blank" style="padding-left: 20px;padding-right: 20px;" href="https://blog.siriling.com:1212/2023/03/18/openwrt-5g-modem">模组教程<\/a><\/td><\/tr>' package/lean/autocore/files/x86/index.htm
sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a\<tr><td width="33%"><%:Compiler author%><\/td><td>Siriling<\/td><\/tr><tr><td width="33%"><%:Resources link%><\/td><td><a target="_blank" style="padding-right: 20px;" href="https://github.com/Siriling/NanoPi-R5S-R5C">固件仓库<\/a><a target="_blank" style="padding-left: 20px;padding-right: 20px;" href="https://blog.siriling.com:1212/2023/03/18/openwrt-5g-modem">模组教程<\/a><\/td><\/tr>' package/lean/autocore/files/arm/index.htm

# 给添加的代码添加汉化
sed -i '$a\\nmsgid "Compiler author"\nmsgstr "编译作者"' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i '$a\\nmsgid "Resources link"\nmsgstr "资源链接"' feeds/luci/modules/luci-base/po/zh-cn/base.po

# 更换内核版本
# sed -i 's/5.15/6.1/g' target/linux/x86/Makefil

# 更默认命令行样式（shell to zsh）
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# 修改banner
rm -rf package/base-files/files/etc/banner
wget -P package/base-files/files/etc https://raw.githubusercontent.com/DHDAXCW/lede-rockchip/stable/package/base-files/files/etc/banner

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# pcie patch
cp -f $GITHUB_WORKSPACE/999-fuck-rockchip-pcie.patch target/linux/rockchip/patches-6.1/999-fuck-rockchip-pcie.patch
