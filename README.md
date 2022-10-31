# Brightxf
&emsp;**!!Run at Own Risk!!**
* No issues have come from my use of these but that doesn't mean there won't be
* Reqs:
    * systemd
    * sudo

* Terminal Commands are:

```bash
brmx
brcur
brup
brwn
```
## INSTALL SCRIPT NOT FULLY TESTED YET 

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

* May Need a Restart.
