SHELL = /bin/bash

SUDO   ?= $(UID)
IMAGE  := "lxd-ansible"

export SUDO

.RECIPEPREFIX = >
.DEFAULT_GOAL = build

VERSION := "v0.1.0"
BUILD   := $(wildcard \
	./build/rootfs.squashfs \
	./build/lxd.tar.xz \
)

.PHONY: all lxd clean build import

all: clean build import

lxd:
> @echo -e "lxd package info:\n"
> @snap list lxd;
> @echo -e "lxd info:\n"
> @lxc info;
> @echo -e "lxd network:\n"
> @lxc network show lxdbr0;
> @echo -e "lxd image:\n"
> @lxc image info $(IMAGE);

clean:
ifeq ($(BUILD), ./build/rootfs.squashfs ./build/lxd.tar.xz)
> cd "./build" && \
>  sudo rm rootfs.squashfs lxd.tar.xz;
else
> @echo "nothing to cleanup, fileslist: '$(BUILD)'"
endif

build:
> @echo -e "\nBuilding $(IMAGE)";
> sudo distrobuilder build-lxd ubuntu.yaml ./build;

import:
> @echo -e "\nImporting $(IMAGE)"
> lxc image import \
>  build/lxd.tar.xz build/rootfs.squashfs \
>  --alias $(IMAGE);
