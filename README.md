# Brightxf
&emsp;**!!Run at Own Risk!!**
* No issues have come from running these(yet) but that doesn't mean there won't be!
* Reqs:
    * systemd
    * sudo

 &emsp;I have various old laptops that I test installs and builds on. Some of them do not have functioning or responsive media/function keys, and I apparently can't properly remapping keys on my minimal systems :P . I made this series of files to allow for basic terminal control of my laptops' screen brightness.
 
* Terminal Commands are:

```bash
brmx
brcur
brup
brwn
```
## INSTALL SCRIPT (In Progress: May not function as intended) 
Right now, it looks for anything but 'acpi' in the '/sys/class/backlight/'. I ran into having 2 directories in the backlight directory and needed to specify to correct one.
**May want to look into what is there before running script**
The brightness files in the acpi directory were not the ones I wanted to modify for this program.

### Curl Install

```bash
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/jb-williams/brightxf/master/install.sh | sh
```

### Manual Install
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

* Then

```bash
sudo systemctl daemon-reload
```

* May Need a Restart Machine.
