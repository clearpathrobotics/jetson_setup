#!/usr/bin/env bash

############## ADD ROS KINETIC SOURCE ##############
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

############## ADD CP SOURCE ##############
wget https://packages.clearpathrobotics.com/public.key -O - | sudo apt-key add -
sudo sh -c 'echo "deb https://packages.clearpathrobotics.com/stable/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/clearpath-latest.list'
sudo apt-get install apt-transport-https

############## UPDATE ##############
sudo apt-get update

############## ROS ##############
sudo apt-get install ros-kinetic-desktop-full

############## SETUP ROS ENVIRONMENT ##############
sudo mkdir -p /etc/ros

sudo wget -O /etc/profile.d/clearpath-ros-environment.sh http://gitlab/research/jetson_setup/raw/master/files/clearpath-ros-environment.sh
sudo wget -O /etc/ros/setup.bash http://gitlab/research/jetson_setup/raw/master/files/setup.bash

############## UDEV AND CONVENIENCE ##############
wget -O /home/nvidia/.screenrc http://gitlab/research/jetson_setup/raw/master/files/.screenrc
wget -O /home/nvidia/.vimrc http://gitlab/research/jetson_setup/raw/master/files/.vimrc
sudo wget -O /etc/udev/rules.d/10-microstrain.rules http://gitlab/research/jetson_setup/raw/master/files/10-microstrain.rules
sudo wget -O /etc/udev/rules.d/41-clearpath.rules http://gitlab/research/jetson_setup/raw/master/files/41-clearpath.rules
sudo wget -O /etc/udev/rules.d/41-hokuyo.rules http://gitlab/research/jetson_setup/raw/master/files/41-hokuyo.rules
sudo wget -O /etc/udev/rules.d/52-ftdi.rules http://gitlab/research/jetson_setup/raw/master/files/52-ftdi.rules
sudo wget -O /etc/udev/rules.d/60-startech.rules http://gitlab/research/jetson_setup/raw/master/files/60-startech.rules

############## DS4 ##############
mkdir ~/ds4
cd ~/ds4
git clone https://github.com/clearpathrobotics/ds4drv.git --branch xenial
sudo apt-get update
sudo apt-get install -y dpkg-dev debhelper git-buildpackage python-all-dev config-package-dev dkms
cd ds4drv
dpkg-buildpackage -uc -us
cd ..
sudo dpkg -i python-ds4drv*
sudo apt-get -f -y install
cd ~
rm -rf ds4
