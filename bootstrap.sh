#!/bin/bash -x

#
# Get the latest...
apt-get update

if [ ! -d /opt/java ]; then
    mkdir /opt/java
fi

#
# Install the JDK
JDK_ARCHIVE="jdk-8u144-linux-x64.tar.gz"

cd /opt/java
tar xvfz /home/vagrant/distros/${JDK_ARCHIVE}

#
# Install Maven
MAVEN_ARCHIVE=apache-maven-3.3.9-bin.tar.gz

cd /opt
tar xvfz /home/vagrant/distros/${MAVEN_ARCHIVE}

#
# This gets APT docker package
#sudo apt-get install -y docker.io

# which docker version to grab:
if [ -z "${VDS_WHICH_DOCKER}" ]; then
    VDS_WHICH_DOCKER=get
fi

# This gets the latest available version of docker
/usr/bin/curl -sSL https://${VDS_WHICH_DOCKER}.docker.com/ | sh

#
# Allow vagrant user to run docker commands
sudo usermod -aG docker vagrant
