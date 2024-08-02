#!/bin/bash
#=================================================
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Clone community packages to package/community

# 删除冲突插件
rm -rf customfeeds/luci/applications/luci-app-mosdns && rm -rf customfeeds/packages/net/{alist,adguardhome,smartdns}

# 添加第三方应用
mkdir kenzok8
pushd kenzok8
git clone --depth=1 https://github.com/kenzok8/openwrt-packages .
popd

mkdir homelede
pushd homelede
git clone --depth=1 https://github.com/xiaoqingfengATGH/feeds-xiaoqingfeng .
popd

mkdir kenzok8-small
pushd kenzok8-small
git clone --depth=1 https://github.com/kenzok8/small-package .
rm -rf {base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
popd

mkdir kenzok8-outside
pushd kenzok8-outside
git clone --depth=1 https://github.com/kenzok8/small .
popd

mkdir Modem-Support
pushd Modem-Support
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support .
popd

mkdir MyConfig
pushd MyConfig
git clone --depth=1 https://github.com/Siriling/OpenWRT-MyConfig .
popd

# Add application
mkdir package/community
pushd package/community

# 系统相关应用
#Poweroff
mkdir luci-app-poweroff
cp -rf ../../kenzok8-small/luci-app-poweroff/* luci-app-poweroff
#fileassistant
rm -rf ../../customfeeds/luci/applications/luci-app-fileassistant
mkdir luci-app-fileassistant
cp -rf ../../kenzok8/luci-app-fileassistant/* luci-app-fileassistant
#guest-wifi
rm -rf ../../customfeeds/luci/applications/luci-app-guest-wifi
mkdir luci-app-guest-wifi
cp -rf ../../kenzok8-small/luci-app-guest-wifi/* luci-app-guest-wifi
#Onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner
#Eqos
mkdir luci-app-eqos
cp -rf ../../kenzok8-small/luci-app-eqos/* luci-app-eqos
#Wolplus
mkdir luci-app-wolplus
cp -rf ../../kenzok8-small/luci-app-wolplus/* luci-app-wolplus

# HomeLede
mkdir luci-app-homeconnect
cp -rf ../../feeds-xiaoqingfeng/luci-app-homeconnect/* luci-app-homeconnect

# 存储相关应用
mkdir gowebdav
mkdir luci-app-gowebdav
cp -rf ../../kenzok8-small/gowebdav/* gowebdav
cp -rf ../../kenzok8-small/luci-app-wolplus/* luci-app-gowebdav

# 科学上网和代理应用
#VSSR（Hello Word）
# svn export https://github.com/jerrykuku/lua-maxminddb/trunk lua-maxminddb
# svn export https://github.com/jerrykuku/luci-app-vssr/trunk luci-app-vssr
#OpenClash
mkdir luci-app-openclash
cp -rf ../../kenzok8/luci-app-openclash/* luci-app-openclash
cp -rf ../../MyConfig/configs/lede/general/applications/luci-app-openclash/* luci-app-openclash
# Daed-next
# git clone https://github.com/sbwml/luci-app-daed-next
# Subconverter
# git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# 去广告
#ADGuardHome
rm -rf ../../customfeeds/packages/utils/adguardhome
rm -rf ../../customfeeds/luci/applications/luci-app-adguardhome
mkdir adguardhome
mkdir luci-app-adguardhome
cp -rf ../../kenzok8/adguardhome/* adguardhome
cp -rf ../../kenzok8/luci-app-adguardhome/* luci-app-adguardhome
cp -rf ../../MyConfig/configs/lede/general/applications/luci-app-adguardhome/* luci-app-adguardhome
sed -i 's/默认账号和密码均为：admin/默认用户名和密码均为root/' luci-app-adguardhome/po/zh-cn/AdGuardHome.po
sed -i 's/网页管理账号和密码:admin ,端口:/端口/' luci-app-adguardhome/po/zh-cn/AdGuardHome.po
#dnsfilter
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-dnsfilter
#ikoolproxy
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ikoolproxy

# docker应用
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-filebrowser
# rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-kodexplorer
# rm -rf ../../customfeeds/packages/utils/verysync
# rm -rf ../../customfeeds/luci/applications/luci-app-verysync
# svn export https://github.com/kenzok8/small-package/trunk/verysync
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-verysync

# VPN服务器
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ssr-mudb-server
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ipsec-server
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-pptp-server
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-softethervpn

# DNS
# svn export https://github.com/kenzok8/small-package/trunk/mosdns
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-mosdns
# svn export https://github.com/kenzok8/small-package/trunk/smartdns
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-smartdns

# DDNS
# svn export https://github.com/kenzok8/small-package/trunk/ddnsto
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ddnsto

# iStore应用
mkdir taskd
mkdir luci-lib-taskd
mkdir luci-lib-xterm
mkdir luci-app-store
mkdir quickstart
mkdir luci-app-quickstart
cp -rf ../../kenzok8-small/taskd/* taskd
cp -rf ../../kenzok8-small/luci-lib-taskd/* luci-lib-taskd
cp -rf ../../kenzok8-small/luci-lib-xterm/* luci-lib-xterm
cp -rf ../../kenzok8-small/luci-app-store/* luci-app-store
cp -rf ../../kenzok8-small/quickstart/* quickstart
cp -rf ../../kenzok8-small/luci-app-quickstart/* luci-app-quickstart

# 其他
#Socat
rm -rf ../../customfeeds/luci/applications/luci-app-socat
mkdir luci-app-socat
cp -rf ../../kenzok8-small/luci-app-socat/* luci-app-socat
#Unblockneteasemusic
rm -rf ../../customfeeds/luci/applications/Unblockneteasemusic
rm -rf ../../customfeeds/luci/applications/luci-app-unblockmusic
mkdir UnblockNeteaseMusic
mkdir luci-app-unblockneteasemusic
cp -rf ../../kenzok8/UnblockNeteaseMusic/* UnblockNeteaseMusic
cp -rf ../../kenzok8/luci-app-unblockneteasemusic/* luci-app-unblockneteasemusic
# OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter

# 网络接口
#Minieap
mkdir luci-proto-minieap
cp -rf ../../kenzok8-small/luci-proto-minieap/* luci-proto-minieap
# cp -rf ../../kenzok8-small/luci-app-minieap/* luci-app-minieap

# 主题
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/images/bg1.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg # 修改默认背景
git clone https://github.com/DHDAXCW/theme

# 5G通信模组拨号工具
rm -rf package/wwan/driver/quectel_QMI_WWAN
rm -rf package/wwan/driver/quectel_MHI
rm -rf package/wwan/app/quectel_cm_5G
mkdir quectel_QMI_WWAN
mkdir quectel_MHI
mkdir quectel_cm_5G
# mkdir luci-app-hypermodem
cp -rf ../../Modem-Support/quectel_QMI_WWAN/* quectel_QMI_WWAN
cp -rf ../../Modem-Support/quectel_MHI/* quectel_MHI
cp -rf ../../Modem-Support/quectel_cm_5G/* quectel_cm_5G
# cp -rf ../../Modem-Support/luci-app-hypermodem/* luci-app-hypermodem

# 5G模组短信插件
# rm -rf customfeeds/luci/applications/luci-app-sms-tool
# mkdir luci-app-sms-tool
# cp -rf ../../Modem-Support/luci-app-sms-tool/* luci-app-sms-tool
# cp -rf ../../MyConfig/configs/istoreos/general/applications/luci-app-sms-tool/* luci-app-sms-tool

#5G模组插件
rm -rf customfeeds/package/utils/sms-tool
mkdir sms-tool
mkdir luci-app-modem
cp -rf ../../Modem-Support/sms-tool/* sms-tool
cp -rf ../../Modem-Support/luci-app-modem/* luci-app-modem

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

# 5G模组拨号脚本
mkdir -p package/base-files/files/root/5GModem
cp -rf $GITHUB_WORKSPACE/tools/5G模组拨号脚本/5GModem/* package/base-files/files/root/5GModem
chmod -R a+x package/base-files/files/root/5GModem
svn export https://github.com/Siriling/OpenWRT-MyConfig/trunk/configs/lede/general/etc/crontabs package/base-files/files/etc/crontabs

# 修改默认IP地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改子网掩码
#sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

# 修改主机名字
sed -i 's/OpenWrt/R5S/g' package/base-files/files/bin/config_generate

# 修改版本号
# sed -i 's/R22.3.3/R22.3.3定制版/g' package/lean/default-settings/files/zzz-default-settings
# sed -i 's/OpenWrt/R5S/g' package/lean/default-settings/files/zzz-default-settings

# 默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 系统信息内添加编译者信息
sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a\<tr><td width="33%"><%:Compiler author%><\/td><td>Siriling<\/td><\/tr><tr><td width="33%"><%:Resources link%><\/td><td><a target="_blank" style="padding-right: 20px;" href="https://github.com/Siriling/NanoPi-R5S-R5C">固件仓库<\/a><a target="_blank" style="padding-left: 20px;padding-right: 20px;" href="https://blog.siriling.com:1212/2023/03/18/openwrt-5g-modem">模组教程<\/a><\/td><\/tr>' package/lean/autocore/files/x86/index.htm
sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a\<tr><td width="33%"><%:Compiler author%><\/td><td>Siriling<\/td><\/tr><tr><td width="33%"><%:Resources link%><\/td><td><a target="_blank" style="padding-right: 20px;" href="https://github.com/Siriling/NanoPi-R5S-R5C">固件仓库<\/a><a target="_blank" style="padding-left: 20px;padding-right: 20px;" href="https://blog.siriling.com:1212/2023/03/18/openwrt-5g-modem">模组教程<\/a><\/td><\/tr>' package/lean/autocore/files/arm/index.htm

# 给添加的代码添加汉化
sed -i '$a\\nmsgid "Compiler author"\nmsgstr "编译作者"' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i '$a\\nmsgid "Resources link"\nmsgstr "资源链接"' feeds/luci/modules/luci-base/po/zh-cn/base.po

# 更换内核版本
# sed -i 's/6.1/5.15/g' target/linux/x86/Makefil

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

# 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本
pushd customfeeds/packages/lang
rm -rf golang
git clone https://github.com/kenzok8/golang customfeeds/packages/lang/golang
popd
