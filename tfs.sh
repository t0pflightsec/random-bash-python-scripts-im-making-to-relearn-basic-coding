#!/bin/bash
# Check for root privileges
if [[ $(id -u) -ne 0 ]]; then
  echo "tfs.sh secue connection  script"
  echo  "must be ran as s root; ie sudo bash tfs.sh"
  echo " starts tor , brings down wifi adapter/s ,spoof mac , start port forwarding,max txpower to adapters,bring connections up."
  echo "purptea / tfsec.org"
  exit 1
fi
echo " >>>tfsec:: going dark......." 
echo ">>>>tfs.sh secue connection  script"
 echo " >>starts tor , brings down wifi adapter/s ,spoof mac , start port forwarding,max txpower to adapters,bring connections up."
echo "   >  - purptea / tfsec.org             "
#start tor 
sleep 3
clear
echo "starting tor"
/etc/init.d/tor start
sleep 2
service tor  start
sleep 3
systemctl restart tor
service tor  start
  echo "Enabling port forwarding..."
  echo 1 > /proc/sys/net/ipv4/ip_forward
 iptables -P FORWARD ACCEPT
sleep 2
  echo "Port forwarding enabled."
# Bring wlan0 and wlan1 down
echo "Bringing down wlan0..."
ifconfig wlan0 down
sleep 3
echo "wlan0 down."
echo "Bringing down wlan1..."
sleep 3 
ifconfig wlan1 down
echo "wlan1 down."

# Change MAC address on both devices
echo "Changing MAC address of wlan0."
macchanger -A   wlan0
echo "wlan0 MAC address changed."
#sleep3
echo "Changing MAC address of wlan1."
macchanger -A wlan1
#echo "wlan1 MAC address changed."
sleep 2
# Bring wlan0 and wlan1 back up
echo "Bringing up wlan0..."
ifconfig wlan0 up
echo "wlan0 up."
sleep 2
echo "Bringing up wlan1..."
fconfig wlan1 up
echo "wlan1 up."
echo "going  to max txpower "
iwconfig wlan0 txpower 27
iwconfig wlan1 txpower 36
echo ">>> tfs::: connection secured, happy hunting! -purptea"
echo " >>>:: https://scripts.tfsec.org   "                                 
