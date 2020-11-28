# lxd-ansible

## Requirements

```sh
$ sudo snap install distrobuilder --classic
distrobuilder 1.0 from Stéphane Graber (stgraber) installed

$ sudo apt install debootstrap rsync gpg squashfs-tools
```

## Build

```sh
$ distrobuilder build-lxd ubuntu.yaml

$ lxc image import lxd.tar.xz rootfs.squashfs --alias lxd-ansible
Image imported with fingerprint: 012345...

$ lxc image list lxd-ansible
```

## Links

- [distrobuilder](https://github.com/lxc/distrobuilder)
