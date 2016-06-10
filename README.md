# A Simple Vagrant Sandbox for Developing Java Apps on Docker

Tested on OS X 10.9.x

## Issues

A couple of errors occured when installing Docker

### Couldn't find the AUFS module:

    ==> default: + /usr/bin/curl -sSL https://get.docker.com/
    ==> default: + sh
    ==> default: modprobe: FATAL: Module aufs not found.
    
Meh, I think the install must have recovered as:

    vagrant@vagrant-ubuntu-trusty-64$ docker info
    ...
    Server Version: 1.11.2
    Storage Driver: aufs
     Root Dir: /var/lib/docker/aufs
    WARNING: No swap limit support
     Backing Filesystem: extfs
     Dirs: 0
     Dirperm1 Supported: false
     
But, from the docker info output notice...

### Dirperm1 not supported

See docker info output above.  Might need to keep an eye on the issue described 
in [docker issue 783](https://github.com/docker/docker/issues/783).

I did try the test described in antoineco's comment on 2016-04-21 and was able 
to create a file in /var/log/app as the "app" user.   


### Couldn't find the kernel headers of the appropriate version:

    ==> default: run-parts: executing /etc/kernel/postinst.d/dkms 3.13.0-87-generic /boot/vmlinuz-3.13.0-87-generic
    ==> default: Error! Your kernel headers for kernel 3.13.0-87-generic cannot be found.
    ==> default: Please install the linux-headers-3.13.0-87-generic package,
    ==> default: or use the --kernelsourcedir option to tell DKMS where it's located

It looks like what's happening is that the docker install upgrades the kernel,
but fails to install the kernel headers for the new kernel version.   

    ==> default: The following extra packages will be installed:
    ==> default:   crda iw libnl-3-200 libnl-genl-3-200 linux-firmware
    ==> default:   linux-image-3.13.0-87-generic linux-image-extra-3.13.0-87-generic
    ==> default:   linux-image-generic wireless-regdb
    ==> default: Suggested packages:
    ==> default:   fdutils linux-doc-3.13.0 linux-source-3.13.0 linux-tools
    ==> default:   linux-headers-3.13.0-87-generic
    ==> default: The following NEW packages will be installed:
    ==> default:   crda iw libnl-3-200 libnl-genl-3-200 linux-firmware
    ==> default:   linux-image-3.13.0-87-generic linux-image-extra-3.13.0-67-generic
    ==> default:   linux-image-extra-3.13.0-87-generic linux-image-extra-virtual
    ==> default:   linux-image-generic wireless-regdb

This will cause problems the next time the vbox guest addtions are built.

But then again, maybe not.   Next vagrant up it detected the new kernel, noticed 
that it needed to grab the appropriate headers, did so and re-built the vbox 
guest additions without incident

    ==> default: Machine booted and ready!
    GuestAdditions versions on your host (5.0.8) and guest (4.3.10) do not match.
    ...
    The following NEW packages will be installed:
      linux-headers-3.13.0-87 linux-headers-3.13.0-87-generic
    0 upgraded, 2 newly installed, 0 to remove and 134 not upgraded.
    Need to get 9,585 kB of archives.
    After this operation, 76.9 MB of additional disk space will be used.
    Get:1 http://archive.ubuntu.com/ubuntu/ trusty-updates/main linux-headers-3.13.0-87 all 3.13.0-87.133 [8,876 kB]
    Get:2 http://archive.ubuntu.com/ubuntu/ trusty-updates/main linux-headers-3.13.0-87-generic amd64 3.13.0-87.133 [709 kB]
    ...
    Removing existing VirtualBox non-DKMS kernel modules ...done.
    Building the VirtualBox Guest Additions kernel modules
     ...done.
    Doing non-kernel setup of the Guest Additions ...done.
    Starting the VirtualBox Guest Additions ...done.
    ...

