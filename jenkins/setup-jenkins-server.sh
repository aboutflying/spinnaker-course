#!/bin/bash

groupadd ubuntu
useradd -g ubuntu -G admin -s /bin/bash -d /home/ubuntu ubuntu
mkdir -p /home/ubuntu
cp -r /root/.ssh /home/ubuntu/.ssh
chown -R ubuntu:ubuntu /home/ubuntu
echo "ubuntu	ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

su - ubuntu <<EOF
sudo apt-get update
sudo apt-get -y install openjdk-8-jdk
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins git
sudo service jenkins enable
sudo service jenkins start
EOF