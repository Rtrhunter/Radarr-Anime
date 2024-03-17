#!/bin/bash

# Script by @ComputerByte
# For Sonarr Anime Uninstalls

# Log to Swizzin.log
export log=/root/logs/swizzin.log
touch $log

systemctl disable --now -q sonarranime
rm /etc/systemd/system/sonarranime.service
systemctl daemon-reload -q

if [[ -f /install/.nginx.lock ]]; then
    rm /etc/nginx/apps/sonarranime.conf
    systemctl reload nginx
fi

rm /install/.sonarranime.lock

sed -e "s/class sonarranime_meta://g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    name = \"sonarranime\"//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    pretty_name = \"Sonarr Anime\"//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    baseurl = \"\/sonarranime\"//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    systemd = \"sonarranime\"//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    check_theD = True//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/    img = \"sonarr\"//g" -i /opt/swizzin/core/custom/profiles.py
sed -e "s/class sonarr_meta(sonarr_meta)://g" -i /opt/swizzin/core/custom/profiles.py
