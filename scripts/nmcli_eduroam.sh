#!/bin/sh
# Connect to eduroam using nmcli
# Based on: https://gist.github.com/BollaBerg/7a3fc9744d5bf6eb16f8aab5928df755
# which is heavily inspired by https://haluk.github.io/posts-output/2020-10-19-linux/

echo "Enter wifi device name (find using nmcli device show):"
read DEVICE_NAME

echo "Enter eduroam user ID (e.g. xxx@domain.com):"
read USER_ID

echo "Enter user password:"
read -s USER_PASSWORD

echo $DEVICE_NAME

nmcli con add \
  type wifi \
  ifname $DEVICE_NAME \
  con-name eduroam \
  ssid eduroam \
  ipv4.method auto \
  802-1x.eap peap \
  802-1x.phase2-auth mschapv2 \
  802-1x.identity $USER_ID \
  802-1x.password $USER_PASSWORD \
  wifi-sec.key-mgmt wpa-eap

nmcli device wifi connect eduroam
