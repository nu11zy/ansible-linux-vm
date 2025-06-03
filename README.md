# Linux VM for MacOS (Debian Testing)

![xfce](/.github/assets/xfce.png)

This repository contains an Ansible playbook designed to install and configure a minimal XFCE4 environment on a macOS virtual machine. I use this playbook to create a golden image, which serves as a base for installing pentesting tools.

**Features**:
- Retina display support
- Low memory usage
- Terminal with zsh config and plugins
- Firefox with custom profile to disable telemetry

## Usage

0. Add shared folder to the VM and enable retina resolution in display settings.
1. Install debian latest release from [here](https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/) (enable ssh server)
2. Edit `/etc/apt/sources.list` and comment out `update` sources (only `testing` and `testing-security` sources should be uncommented):

```sh
deb http://deb.debian.org/debian/ testing main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security testing-security main contrib non-free non-free-firmware
```

3. Upgrade to testing branch.

```sh
sudo apt -y update && sudo apt -y full-upgrade
```

4. Reboot the VM.
5. Run the playbook (it will ask for sudo password and connect to the VM via ssh):

```sh
bash ./install.sh -H <target_host_ip> -u <username>
```
