#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
else

usr=$(whoami)

apt install curl -y
clear

# Add the release PGP keys:
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -

# Add the "stable" channel to your APT sources:
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Update and install syncthing:
apt update
apt install nano -y
apt install net-tools -y
apt install apache2 -y
apt install syncthing -y

# enable syncthing as service and starts it for the first time
systemctl enable syncthing@$usr.service
systemctl start syncthing@$usr.service
clear

echo "[..] -- please wait ..."
sleep 30s
clear

echo "[..] -- syncthing is up and running"
sleep 5s
clear
echo "[..] -- syncthing will be stoped again to update the config file"

systemctl stop syncthing@$usr.service
clear

echo "[..] -- the config file will now opend up"
echo "[..] -- now you have to update your ip for the webinterface"

sleep 10s
read -p "[..] -- press enter to continue"
nano /home/$usr/.config/syncthing/config.xml
sleep 5s
systemctl start syncthing@$usr.service
echo "[..] -- syncthing is up and running. Enjoy!"
read -p "[..] -- press enter to end"
clear
exit

if
