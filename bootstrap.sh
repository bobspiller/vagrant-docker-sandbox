#!/bin/bash -x

#
# Get the latest...
apt-get update

#
# Install JDK7
#JDK_URL="http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz"

JDK_URL="http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz"
JDK_ARCHIVE="jdk-linux-x64.tar.gz"
#WGET_OPTS="-nv -O ${JDK_ARCHIVE}"
#ORACLE_LICENSE_OPTS="--continue --no-check-certificate --header 'Cookie: oraclelicense=a'"

cd /tmp
wget -nv -O ${JDK_ARCHIVE}\
 --continue --no-check-certificate\
 --header "Cookie: oraclelicense=a" ${JDK_URL}

if [ ! -d /opt/java ]; then
    mkdir /opt/java
fi
cd /opt/java 
tar -C /opt/java -zxvf /tmp/${JDK_ARCHIVE}
rm /tmp/${JDK_ARCHIVE}


#
# Install Maven
MAVEN_ARCHIVE=apache-maven-3.3.9-bin.tar.gz
MAVEN_URL=http://shinyfeather.com/maven/maven-3/3.3.9/binaries/${MAVEN_ARCHIVE}
cd /tmp &&\
   wget -nv ${MAVEN_URL} && \
   cd /opt &&\
   tar xvfz /tmp/${MAVEN_ARCHIVE} &&\
   rm -f /tmp/${MAVEN_ARCHIVE}

#
# This gets APT docker package
#sudo apt-get install -y docker.io

# This gets the latest available version of docker
/usr/bin/curl -sSL https://get.docker.com/ | sh

#
# Allow vagrant user to run docker commands
sudo usermod -aG docker vagrant
