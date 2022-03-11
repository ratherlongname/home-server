# Executed automatically after DietPi install

# Remove rTorrent lock since hostname was changed
rm /mnt/dietpi_userdata/downloads/.session/rtorrent.lock
systemctl restart rtorrent
