sudo rmmod uniwill_laptop uniwill_wmi
make clean && make
sudo insmod uniwill-wmi.ko && sudo insmod uniwill-laptop.ko       
