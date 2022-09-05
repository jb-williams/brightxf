# Brightxf
&emsp;**!!Run at Own Risk!!**
* No issues have come from my use of these but that doesn't mean there won't be
* Reqs:
    * systemd
    * sudo

## INSTAL SCRIPT NOT TESTED YET 
* Setup Script Expects:
    * `~/Gits/brightxf`(may not be necessary)
    * `~/.local/bin`
    * `/etc/startup`(will be automated by SETUP.sh soon)

&emsp;I enjoy making/finding the most minimal gui and still be functional as a daily-driver(functional specifically to my needs). I tend to prefer cwm, a simple window manager, and sxhkd, used as a hot-key daemon, and I test my setup on a several different laptops of different specs. I have major issues getting all my "Fn"+ F keys to work properly across all my devices and just can't seem to wrap my head around any explanation I've come across(very likely just me). So, I put together these series of scripts and a systemd service file to specifically give both easy terminal control of your screen brightness as well as easily assigning hot-keys with sxhkd.

(Will be Automated by SETUP.sh soon)
* Copy these somewhere in your PATH:
    * `brcur` - current brightness
    * `brwn`  - brightness down
    * `brup`  - brightness up
    * `brmx`  - set brightness to max
    * `brightxf` - main script

* As `sudo`(root), make a directory `/etc/startup` and copy `brightness_mod.sh` there.
* Then as `sudo`(root), and copy `brightness_mod.service` to `/etc/systemd/system/` .
* Then run:
```bash
sudo systemctl enable brightness_mod.service
```
Then
```bash
sudo systemctl daemon-reload
```
* May Need a Restart.

Then the commands are:
```bash
brcur
brwn
brup
brmx
```
