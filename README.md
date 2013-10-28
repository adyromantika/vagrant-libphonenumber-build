# Vagrant libphonenumber Build Machine

This is a Vagrant machine (precise64 box) I use to build the [libphonenumber](https://code.google.com/p/libphonenumber/) C++ library.

libphonenumber is owned by Google and The Libphonenumber Authors licensed under Apache License, Version 2.0.

## Installing

1. Make sure [VirtualBox](https://www.virtualbox.org/) is installed
1. [Install Vagrant](http://docs.vagrantup.com/v2/installation/).
1. Clone this repository or download it as zip.
1. Add an entry in the host file for `vagrant-libphonenumber.localhost` with IP `192.168.99.98` (optional). One can always use `vagrant ssh` to enter the virtual machine.
1. In the terminal, go to the folder where you cloned or unzipped the files and type `vagrant up` and let puppet do its magic checking out the source, and installing the packages / dependencies for building libphonenumber.

Note that puppet downloads JRE from Oracle, and I have not tested this build using java alternatives.

## Building

By default, build process is done using user "vagrant" and can be changed in the puppet module if necessary. Unchanged, the source and scripts will be located in `/home/vagrant`. If `root` is specified, the source and scripts will be located in `/usr/src`. 

Two scripts are included:

1. `libphonenumber-build.sh` will build the library
1. `libphonenumber-install.sh` will install the library to `/usr/local`
