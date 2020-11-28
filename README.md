# lxd-ansible

## Requirements

```sh
$ sudo snap install distrobuilder --classic
distrobuilder 1.0 from Stéphane Graber (stgraber) installed

$ sudo apt install debootstrap rsync gpg squashfs-tools
```

## Build

### Manual

```sh
$ distrobuilder build-lxd ubuntu.yaml

$ lxc image import lxd.tar.xz rootfs.squashfs --alias lxd-ansible
Image imported with fingerprint: 012345...

$ lxc image list lxd-ansible
```

### Task Runner

```sh
$ make
...
+ systemctl enable systemd-networkd
+ locale-gen en_US.UTF-8
Generating locales (this might take a while)...
  en_US.UTF-8... done
Generation complete.
+ update-locale LANG=en_US.UTF-8
+ mkdir -m 0700 /root/.ssh
+ ssh-keygen -t ed25519 -f /root/.ssh/dummy -N  -C ansible-dummy-key
Generating public/private ed25519 key pair.
Your identification has been saved in /root/.ssh/dummy
Your public key has been saved in /root/.ssh/dummy.pub
The key fingerprint is:
SHA256:F1QNFUpW0ma678/+68BjEo25k0/B0KnsNY3woTRusYc ansible-dummy-key
The key's randomart image is:
+--[ED25519 256]--+
|          ..**+. |
|         . o.o*  |
|          .*.B   |
|          +.^ +  |
|        S .E @ . |
|         .o O o  |
|           * B   |
|            * +. |
|             oo=B|
+----[SHA256]-----+
+ echo -e dummy ssh key:\n
-e dummy ssh key:

+ cat /root/.ssh/dummy
-----BEGIN OPENSSH PRIVATE KEY-----
-----END OPENSSH PRIVATE KEY-----
+ mount -o bind / /mnt
+ rm -rf /mnt/run/lock /mnt/run/mount /mnt/run/utmp
+ umount /mnt
+ rm /etc/group- /etc/gshadow- /etc/passwd- /etc/shadow- /etc/subgid- /etc/subuid-
Parallel mksquashfs: Using 4 processors
Creating 4.0 filesystem on build/rootfs.squashfs, block size 1048576.
...
```

## Use

```sh
$ lxc launch lxd-ansible tdd-ansible-ubercool
$ lxc exec test-ansible -- ansible --version
$ lxc exec test-ansible -- systemctl status ssh
```

## Links

- [distrobuilder](https://github.com/lxc/distrobuilder)
