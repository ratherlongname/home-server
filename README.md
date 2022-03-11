Home server setup w/ DietPi
===========================

Setup a multi-function home server on a Raspberry Pi 4.

I'll use the [DietPi][1] operating system, which is a minimal image designed to run on small single board computers like my RPi. It also uses dialog boxes, so I won't have to use command line commands any more than I need to.

I also won't connect the RPi to any keyboard or monitor. It will always be headless.


Setup DietPi
------------
 1. Add wifi network SSID and password to the `dietpi-wifi.txt` present in this repository.

 2. Edit the `dietpi.txt` file in this repository, fill in sensitive fields like passwords etc.

 3. Download latest image from [DietPi][1].

 4. Mount the `.img` file.

 5. Replace existing `dietpi.txt`, `dietpi-wifi.txt` files with the edited ones.

 6. Flash it to a USB drive using [BalenaEtcher][2].

 7. Plug the USB drive into the RPi 4 and power it on.

 8. SSH into the RPi.

```bash
# Hostname will work only if `avahi-daemon` was specified to be downloaded in `dietpi.txt` and DietPi's first boot setup is complete.
# Otherwise find IP address of RPi by logging into the network's router.

ssh dietpi@<IP of RPi / hostname from dietpi.txt>
```

 9. If DietPi's first boot setup is still running, a message will print on loop. Wait for it to finish.

```bash
# Follow the output of the first run setup
tail -n 10 -f /var/tmp/dietpi/logs/dietpi-firstrun-setup.log
```

10. Reboot the RPi.

```bash
sudo shutdown -r now
```

11. SSH into the RPi.

```bash
ssh dietpi@<HOSTNAME>.local
```

12. Update everything.

```bash
sudo apt-get update
sudo apt-get upgrade
```


Setup an external media drive
-----------------------------
1. Organize the movies, shows, music on the drive for Plex. [Follow this guide][3].
2. Plug the drive into the RPi.

3. Mount the drive using `dietpi-drive_manager`.

```bash
sudo dietpi-drive_manager
# Click through the menus to mount the drive in the default location
# /mnt/<UUID of drive>
```

3. Verify new entry in `/etc/fstab`.

```bash
cat /etc/fstab
# A new entry should read near the end of the file:
# UUID=<UUID of drive> /mnt/<UUID of drive> <format> <options>
```


Setup Plex
----------
1. Plex is already installed if it was specified in `dietpi.txt`. Otherwise use `dietpi-software` to install it.

2. Open `http://<server hostname>.local:32400/web` from any device on the same network as the server.

3. Follow through with the setup on-screen. Add libraries from directories in `/mnt/<UUID of drive>/`.

4. Disable video stream transcoding in `Settings > Transcoder > Show Advanced > Disable video stream transcoding`.

5. Enjoy!


More setting up
---------------
1. Remove rTorrent lock if hostname was changed in `dietpi.txt`. Otherwise rTorrent won't work.

```bash
sudo rm /mnt/dietpi_userdata/downloads/.session/rtorrent.lock
sudo systemctl restart rtorrent
```

2. Change default download directory of rTorrent

```bash
sudo nano /mnt/dietpi_userdata/rtorrent/.rtorrent.rc
# Edit 'directory.default.set'
sudo systemctl restart rtorrent
```

3. Change netdata configuration to allow remote connections

```bash
sudo nano /etc/netdata/netdata.conf
# Comment out the line 'bind socket to IP = 127.0.0.1'
sudo systemctl restart netdata
```

References
----------
- How to install DietPi (https://dietpi.com/docs/install)
- DietPi software list (https://dietpi.com/docs/software)
- DietPi full software list with IDs (https://github.com/MichaIng/DietPi/wiki/DietPi-Software-list)

<!-- External Links -->
[1]: https://dietpi.com
[2]: https://www.balena.io/etcher
[3]: https://support.plex.tv/articles/categories/your-media/
