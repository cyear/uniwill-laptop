MODNAME = uniwill-laptop
MODNAMEWMI = uniwill-wmi
MODVER = 1.0
MDIR = /usr/src/$(MODNAME)-$(MODVER)
MWMIDIR = /usr/src/$(MODNAMEWMI)-$(MODVER)

CFLAGS_uniwill-laptop.o := -DDEBUG
obj-m += uniwill-laptop.o
obj-m += uniwill-wmi.o

all:
	make -C /lib/modules/`uname -r`/build M=`pwd` modules

clean:
	make -C /lib/modules/`uname -r`/build M=`pwd` clean

dkmsinstall:
	mkdir -p $(MDIR)
	mkdir -p $(MWMIDIR)
	cp Makefile dkms.conf $(wildcard *.c) $(wildcard *.h) $(MDIR)/.
	cp Makefile $(wildcard *.c) $(wildcard *.h) $(MWMIDIR)/.
	cp dkms_wmi.conf $(MWMIDIR)/dkms.conf
	dkms add $(MODNAME)/$(MODVER)
	dkms build $(MODNAME)/$(MODVER)
	dkms install $(MODNAME)/$(MODVER)
	dkms add $(MODNAMEWMI)/$(MODVER)
	dkms build $(MODNAMEWMI)/$(MODVER)
	dkms install $(MODNAMEWMI)/$(MODVER)

dkmsuninstall:
	-rmmod $(MODNAME)
	-rmmod $(MODNAMEWMI)
	-dkms uninstall $(MODNAME)/$(MODVER)
	-dkms remove $(MODNAME)/$(MODVER) --all
	-dkms uninstall $(MODNAMEWMI)/$(MODVER)
	-dkms remove $(MODNAMEWMI)/$(MODVER) --all
	rm -rf $(MDIR)
	rm -rf $(MWMIDIR)
