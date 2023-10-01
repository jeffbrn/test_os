# test_os

DIY operating system

## Building a boot image

### Prerequisites

Boot image is created using docker

### Steps

```
$ cd boot
$ pushd .dev-docker
$ docker compose up -d
$ docker exec -ti boot-os-dev /bin/bash
$ make
$ exit
$ docker compose down
$ popd
```

## Testing the boot image

The boot image can be tested using a qemu utility

### Installing Prerequisites

```
$ sudo apt update && sudo apt install -y grub-common xorriso qemu-system-x86 grub-pc-bin
```

### Running the test

```
$ qemu-system-x86_64 -cdrom build/os-x86_64.iso
```

### VMWare

You can also test the boot image using VMWare by creating a VM based on a generic linux and using the file 'build/os-x86_64.iso' to boot from

## References

-   [A minimal Multiboot Kernel](https://os.phil-opp.com/multiboot-kernel/)
-   [EFI fix on WSL](https://github.com/microsoft/WSL/issues/1043)
