Home Server Setup w/ Raspberry Pi OS
====================================

Instructions to install and setup Plex Media Server on a new Raspberry Pi 4 remotely. No need to connect a keyboard or monitor to the Pi.


Boot the RPi
------------

1. Flash OS image ([Raspberry Pi OS Lite][1]) to pendrive or SD card.
2. Create empty file named `ssh` in root of pendrive.
3. Replace wifi network SSID and password in file `wpa_supplicant.conf`.
4. Copy file `wpa_supplicant.conf` to root of pendrive.
5. Insert pendrive into the Pi and power it on.
6. On a separate machine -- `ssh pi@raspberrypi.local`.
7. Default password is `raspberry`.
8. `whoami` -- output should be `pi`.
9. `sudo apt-get update`.
10. `sudo apt-get dist-upgrade -y`.


Mount External Drive
--------------------

Follow instructions here: [External Storage Configuration][2]


Setup Plex Media Server
-----------------------

```bash
ssh pi@raspberrypi.local

echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y plexmediaserver

exit

ssh -L 32400:raspberrypi.local:32400 pi@raspberrypi.local
```

Now open http://127.0.0.1:32400/web/ to start the basic setup wizard

Known Issues
------------
- Sometimes the external drive doesn't mount automatically.

<!-- External Links -->
[1]: https://www.raspberrypi.org/software/operating-systems/
[2]: https://www.raspberrypi.com/documentation/computers/configuration.html#external-storage-configuration
