# test_os

DIY operating system

## O/S boot image

### Prerequisites

Boot image is created using docker

### Building the boot image

First shell into the dev container:

```
cd boot
./run_docker.sh
```

### Building the x64 image

```
cd src/arch/x86_x64
make
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

## Miscellaneous

-   interrogate generated image file: file kernel.img
-   disk info: fdisk -lu kernel.img

## References

-   [A minimal Multiboot Kernel](https://os.phil-opp.com/multiboot-kernel/)
-   [EFI fix on WSL](https://github.com/microsoft/WSL/issues/1043)
-   [QEMU](https://www.qemu.org/docs/master/)
