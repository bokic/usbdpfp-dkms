# Makefile - usbdpfp kernel module build file for Linux kernel 2.6 and later
#
# Copyright 1996-2011 DigitalPersona, Inc.  All rights reserved.
#  
# see: linux/Documentation/kbuild/makefiles.txt for full documentation on makefile
# see: linux/Documentation/kbuild/modules.txt for full documenttion on kbuild
#

DRIVER_VERSION	:= 2.0.0.7

modname := usbdpfp
obj-m := $(modname).o

KVERSION := $(shell uname -r)
KDIR := /lib/modules/$(KVERSION)/build
PWD := "$$(pwd)"

EXTRA_CFLAGS	:= -DDRIVER_VERSION=\"v$(DRIVER_VERSION)\"

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) O=$(PWD) -C $(KDIR) M=$(PWD) clean

load:
	-rmmod $(modname)
	insmod $(modname).ko

install:
	install -m 0644 -o root -g root $(modname).ko /lib/modules/$(KVERSION)/kernel/drivers/misc
	depmod -a

uninstall:
	rm /lib/modules/$(KVERSION)/kernel/drivers/misc/$(modname).ko
	depmod -a

